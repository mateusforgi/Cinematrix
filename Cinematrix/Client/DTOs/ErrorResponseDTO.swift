//
//  ErrorResponseDTO.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation
struct ErrorResponse: Codable, Error, LocalizedError {
    let statusCode: Int
    let statusMessage: String
    
    
    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
    
    var errorDescription: String? {
        statusMessage
    }
}
