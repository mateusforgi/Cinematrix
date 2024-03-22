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
    let credits: [Credits]
	
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
	}
	
	struct Genre: Codable {
		let name: String
	}
}

extension MovieDetailsResponseDTO {
    struct CastMember: Codable {
        let adult: Bool
        let gender: Int
        let id: Int
        let knownForDepartment: String
        let name: String
        let originalName: String
        let popularity: Double
        let profilePath: String?
        let castId: Int
        let character: String
        let creditId: String
        let order: Int

        enum CodingKeys: String, CodingKey {
            case adult, gender, id, name, popularity, character, order
            case knownForDepartment = "known_for_department"
            case originalName = "original_name"
            case profilePath = "profile_path"
            case castId = "cast_id"
            case creditId = "credit_id"
        }
    }

    struct Credits: Codable {
        let cast: [CastMember]
    }

}
