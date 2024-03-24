//
//  PopularMoviesViewModelTests.swift
//  CinematrixTests
//
//  Created by Mateus on 24/03/2024.
//

import XCTest
@testable import Cinematrix

@MainActor
class PopularMoviesViewModelTests: XCTestCase {

    override func setUp() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        super.setUp()
    }
    
    func testListInitializationWithMetadata() async throws {
        let mockProvider = MockMovieProvider()
        try UserDefaultWrapper.save(MovieListMetaData(lastPage: 1, totalPages: 20), for: .movieListMetaData)
        
        // Wait for listInitialization to complete
        let viewModel = PopularMoviesViewModel(provider: mockProvider, pageSize: 10)

        XCTAssertEqual(viewModel.metadata.lastPage, 1)
        XCTAssertEqual(viewModel.metadata.totalPages, 20)
    }

    func testRefresh() async throws {
        let mockProvider = MockMovieProvider()
        let viewModel = PopularMoviesViewModel(provider: mockProvider, pageSize: 10)

        // Trigger a refresh
        await viewModel.refresh()

        XCTAssertFalse(viewModel.refreshing)
        XCTAssertEqual(viewModel.metadata.lastPage, 1)
    }
    
    func testRefreshThrowError() async throws {
        let mockProvider = MockMovieProvider()
        let viewModel = PopularMoviesViewModel(provider: mockProvider, pageSize: 10)
        mockProvider.error = NSError(domain: #function, code: 0)
       
        // Trigger a refresh
        await viewModel.refresh()

        XCTAssertNotNil(viewModel.error)
        XCTAssertFalse(viewModel.refreshing)
        XCTAssertEqual(viewModel.metadata.lastPage, 0)
    }

    func testFetchMore() async throws {
        let mockProvider = MockMovieProvider()
        let viewModel = PopularMoviesViewModel(provider: mockProvider, pageSize: 10)

        // Trigger fetchMore
        await viewModel.fetchMore()

        XCTAssertFalse(viewModel.loading)
        XCTAssertEqual(viewModel.metadata.lastPage, 1)
    }
    
    func testFetchMoreThrowError() async throws {
        let mockProvider = MockMovieProvider()
        let viewModel = PopularMoviesViewModel(provider: mockProvider, pageSize: 10)
        mockProvider.error = NSError(domain: #function, code: 0)

        // Trigger fetchMore
        await viewModel.fetchMore()

        XCTAssertFalse(viewModel.loading)
        XCTAssertEqual(viewModel.metadata.lastPage, 0)
        XCTAssertNotNil(viewModel.error)
    }
}
