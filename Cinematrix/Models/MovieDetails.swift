//
//  MovieDetails.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

struct MovieDetails: Identifiable {
	let genres: [String]
	let id: Int
	let overview: String
	let posterURL: URL
	let releaseDate: String
	let tagline: String
	let title: String
	let voteAverage: Double
    
    
	
    init(_ movie: MovieDetailsResponseDTO, imageBaseURL: URL) {
		self.genres = movie.genres.map({$0.name})
		self.id = movie.id
		self.overview = movie.overview
        self.posterURL = imageBaseURL.appendingPathComponent("original").appendingPathComponent(movie.posterPath)
		self.releaseDate = movie.releaseDate
		self.tagline = movie.tagline
		self.title = movie.title
		self.voteAverage = movie.voteAverage
	}
	
	internal init(genres: [String], id: Int, overview: String, posterURL: URL, releaseDate: String, tagline: String, title: String, voteAverage: Double) {
		self.genres = genres
		self.id = id
		self.overview = overview
		self.posterURL = posterURL
		self.releaseDate = releaseDate
		self.tagline = tagline
		self.title = title
		self.voteAverage = voteAverage
	}
}
