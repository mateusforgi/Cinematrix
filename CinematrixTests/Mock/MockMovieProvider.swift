//
//  MockMovieProvider.swift
//  CinematrixTests
//
//  Created by Mateus on 24/03/2024.
//

import Foundation
@testable import Cinematrix
import XCTest

final class MockMovieProvider: MovieProvider {
    var imageBaseURL: URL {
        return mockURL!
    }
    var mockURL: URL?
    var error: Error?
    var fetchExpectation: XCTestExpectation?
    
    func fetch(page: Int, pageSize: Int, deleteCache: Bool) async throws -> Int {
        fetchExpectation?.fulfill()
        if let error {
            throw error
        }
        return page + 1
    }
}
