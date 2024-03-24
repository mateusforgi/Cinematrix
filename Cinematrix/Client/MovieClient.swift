//
//  MovieClient.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

protocol MovieClient: AnyObject {
    var imageBaseURL:  URL { get }
    func popularMovies(_ page: Int, size: Int) async throws -> MovieResponseDTO
    func movieDetails(_ id: Int) async throws -> MovieDetailsResponseDTO
}

final class MovieNetworkClient: MovieClient {
    let baseUrl: URL
    let client: NetworkClient
    let apiKey: String
    var imageBaseURL:  URL
    
    init(client: NetworkClient = NetworkManager()) {
        self.client = client
        guard let urlString = Bundle.main.infoDictionary?["MOVIE_BASE_URL"] as? String, let url = URL(string: urlString) else {
            preconditionFailure("Unable to build URL")
        }
        guard let key = Bundle.main.infoDictionary?["MOVIE_API_KEY"] as? String else {
            preconditionFailure("Unable find API key")
        }
        guard let imageURL = Bundle.main.infoDictionary?["MOVIE_IMAGE_BASE_URL"] as? String,
              let imageBaseURL = URL(string: "\(imageURL)") else {
            preconditionFailure("Unable to build Image URL")
        }
        self.apiKey = key
        self.baseUrl = url
        self.imageBaseURL = imageBaseURL
    }
    
    func popularMovies(_ page: Int, size: Int) async throws -> MovieResponseDTO {
        return try await get(.popularMovies, params: [.init(key: .page, value: String(page)), .init(key: .size, value: String(size))])
    }
    
    func movieDetails(_ id: Int) async throws -> MovieDetailsResponseDTO {
        return try await get(.moveDetail(id: id), params: [.init(key: .appendToResponse, value: "credits,images")])
    }
    
    private func get<T: Codable>(_ path: Paths, params: [MovieNetworkClient.QueryItem] = []) async throws -> T {
        let url = baseUrl.appendingPathComponent(path.path)
        
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = [.init(name: Query.api_key.rawValue, value: apiKey)]
        urlComponents?.queryItems?.append(contentsOf: params.map({URLQueryItem(name: $0.key.rawValue, value: $0.value)}))
        
        let request = URLRequest(url: urlComponents!.url!)
        
        do {
            return try await client.get(request)
        } catch {
            throw transformError(error)
        }
    }
    
    private func transformError(_ responseError: Error) -> Error {
        if let error = responseError as? NetworkError, case let .generic(data) = error {
            do {
                return try JSONDecoder().decode(ErrorResponse.self, from: data)
            } catch {
                return responseError
            }
        }
        return responseError
    }
}

extension MovieNetworkClient {
    struct QueryItem {
        let key: Query
        let value: String
    }
    
    enum Query: String {
        case page
        case api_key
        case size
        case appendToResponse = "append_to_response"
    }
    
    enum Paths {
        case popularMovies
        case moveDetail(id: Int)
        
        var path: String {
            switch self {
            case .popularMovies:
                return  "/movie/popular"
            case .moveDetail(let id):
                return "/movie/\(id)"
            }
        }
    }
}
