//
//  MovieDetailsResponseDTO.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

struct MovieDetailsResponseDTO: Codable {
	let genres: [Genre]
	let id: Int
	let overview: String
	let posterPath: String
	let releaseDate: String
	let tagline: String
	let title: String
	let voteAverage: Double
    let credits: Credits
    let images: MovieDetailsResponseDTO.Images

	enum CodingKeys: String, CodingKey {
		case genres
		case id
		case overview
		case posterPath = "poster_path"
		case releaseDate = "release_date"
		case tagline
		case title
		case voteAverage = "vote_average"
        case credits
        case images
	}
	
	struct Genre: Codable {
		let name: String
	}
}

extension MovieDetailsResponseDTO {
    struct CastMember: Codable {
        let id: Int
        let name: String
        let profilePath: String?
        let character: String
        let order: Int

        enum CodingKeys: String, CodingKey {
            case id, name, character, order
            case profilePath = "profile_path"
        }
    }

    struct Credits: Codable {
        let cast: [CastMember]
    }
    
    struct Backdrops: Codable {
        let aspectRatio: Double
        let filePath: String
        let iso6391: String?

        enum CodingKeys: String, CodingKey {
            case aspectRatio = "aspect_ratio"
            case filePath = "file_path"
            case iso6391 = "iso_639_1"
        }
    }

    struct Images: Codable {
        let backdrops: [Backdrops]
    }
}
