//
//  MovieResponseDTO.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

struct MovieResponseDTO: Codable {
        let page: Int
        let results: [Movie]
        let totalPages: Int
        let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension MovieResponseDTO {
    struct Movie: Codable {
        let id: Int
        let overview: String
        let posterPath: String
        let title: String
        let voteAverage: Double
        
        enum CodingKeys: String, CodingKey {
            case id
            case overview
            case posterPath = "poster_path"
            case title
            case voteAverage = "vote_average"
        }
    }
}
