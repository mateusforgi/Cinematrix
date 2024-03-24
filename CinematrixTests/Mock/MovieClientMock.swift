//
//  MovieClientMock.swift
//  CinematrixTests
//
//  Created by Mateus on 24/03/2024.
//

import Foundation
@testable import Cinematrix

final class MovieClientMock: MovieClient {
    var imageBaseURL: URL = .init(string: "https://api.themoviedb.org/3")!
    var error: Error?
    var movie: MovieDetailsResponseDTO?
    var movies: MovieResponseDTO?
    
    func popularMovies(_ page: Int, size: Int) async throws -> MovieResponseDTO {
        if let error {
            throw error
        }
        return movies!
    }
    
    func movieDetails(_ id: Int) async throws -> MovieDetailsResponseDTO {
        if let error {
            throw error
        }
        return movie!
    }
}
