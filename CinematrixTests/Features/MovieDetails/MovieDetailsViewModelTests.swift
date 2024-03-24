//
//  MovieDetailsViewModel.swift
//  CinematrixTests
//
//  Created by Mateus on 24/03/2024.
//

import XCTest
@testable import Cinematrix

@MainActor
final class MovieDetailsViewModelTests: XCTestCase {
    
    func testGetMovieSuccessState() async {
        let movie = MovieDetailsResponseDTO(genres: [], id: 1, overview: String(), posterPath: String(), releaseDate: String(), tagline: String(), title: String(), voteAverage: 1, credits: .init(cast: []), images: .init(backdrops: []))
        let mockClient = MovieClientMock()
        mockClient.movie = movie
        
        let viewModel = MovieDetailsViewModel(id: 123, client: mockClient)
        
        await viewModel.getMovie()
        
        XCTAssertEqual(viewModel.state, .success(movie: .init(movie, imageBaseURL: mockClient.imageBaseURL)))
    }
    
    func testGetMovieErrorState() async {
        let testError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        let mockClient = MovieClientMock()
        mockClient.error = testError
        
        let viewModel = MovieDetailsViewModel(id: 123, client: mockClient)
        
        await viewModel.getMovie()
        
        
        XCTAssertEqual(viewModel.state, .error(error: testError))
    }
}
