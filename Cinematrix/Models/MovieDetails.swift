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
	let releaseDate: String
	let tagline: String
	let title: String
	let voteAverage: Double
    let cast: [CastMember]
    let backdrops: [Backdrops]

    init(_ movie: MovieDetailsResponseDTO, imageBaseURL: URL) {
		self.genres = movie.genres.map({$0.name})
		self.id = movie.id
		self.overview = movie.overview
		self.releaseDate = movie.releaseDate
		self.tagline = movie.tagline
		self.title = movie.title
		self.voteAverage = movie.voteAverage
        self.cast = movie.credits.cast.map({CastMember(cast: $0, imageBaseURL: imageBaseURL)})

        let languageID = Locale.current.language.languageCode?.identifier ?? "en"
        let filteredCode: String?
        
        if movie.images.backdrops.first(where: {$0.iso6391 == languageID}) != nil {
            filteredCode = languageID
        } else if movie.images.backdrops.first(where: {$0.iso6391 == "en"}) != nil {
            filteredCode = "en"
        } else {
            filteredCode = nil
        }
        
        self.backdrops = movie.images.backdrops.filter({$0.iso6391 == filteredCode}).map({Backdrops(backdrop: $0, imageBaseURL: imageBaseURL)})
	}
	
    internal init(genres: [String], id: Int, overview: String, releaseDate: String, tagline: String, title: String, voteAverage: Double, cast: [CastMember] = [], backdrops: [Backdrops] = []) {
		self.genres = genres
		self.id = id
		self.overview = overview
		self.releaseDate = releaseDate
		self.tagline = tagline
		self.title = title
		self.voteAverage = voteAverage
        self.cast = cast
        self.backdrops = backdrops
	}
}

extension MovieDetails {
    struct CastMember: Codable {
        let id: Int
        let name: String
        let profileURL: URL?
        let character: String
        let order: Int
        
        init(cast: MovieDetailsResponseDTO.CastMember, imageBaseURL: URL) {
            self.id = cast.id
            self.name = cast.name
            self.profileURL = cast.profilePath == nil ? nil : imageBaseURL.appendingPathComponent("w300").appendingPathComponent(cast.profilePath!)
            self.character = cast.character
            self.order = cast.order
        }
    }
    
    struct Backdrops: Codable {
        let id: String
        let aspectRatio: Double
        let url: URL
        
        init(backdrop: MovieDetailsResponseDTO.Backdrops, imageBaseURL: URL) {
            self.aspectRatio = backdrop.aspectRatio
            self.id = backdrop.filePath
            self.url = imageBaseURL.appendingPathComponent("w780").appendingPathComponent(backdrop.filePath)
        }
    }
}
