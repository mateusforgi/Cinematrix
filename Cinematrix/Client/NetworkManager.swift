//
//  NetworkManager.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

final class NetworkManager: NetworkClient {
	let session: URLSession
	
	init(session: URLSession = URLSession.shared) {
		self.session = session
	}
	
	func get<T: Codable>(_ urlRequest: URLRequest) async throws -> T {
		var request = urlRequest
		request.httpMethod = "GET"
		
		let (data, response) = try await session.data(for: request)
		
		if let response = response as? HTTPURLResponse {
			if response.statusCode == 200 {
				return try JSONDecoder().decode(T.self, from: data)
			}
			throw NetworkError.generic(data: data)
		}
		
		throw NetworkError.generic(data: data)
	}
}

enum NetworkError: Error, Equatable {
	case generic(data: Data)
}
