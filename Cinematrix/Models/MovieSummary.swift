//
//  MovieSummary.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

struct MovieSummary: Identifiable {
    let id: Int
    let overview: String
    let title: String
    let voteAverage: Double
    let thumbnailURL: URL

    var isPopular: Bool {
        voteAverage > 7.5
    }

    init(_ movie: Movie, imageBaseURL: URL) {
        self.id = movie.id
        self.overview = movie.overview
        self.title = movie.title
        self.voteAverage = movie.voteAverage
        self.thumbnailURL = imageBaseURL.appendingPathComponent("w185").appendingPathComponent(movie.posterPath)
    }
    
    internal init(id: Int, overview: String, title: String, voteAverage: Double, thumbnailURL: URL) {
        self.id = id
        self.overview = overview
        self.title = title
        self.voteAverage = voteAverage
        self.thumbnailURL = thumbnailURL
    }
}
