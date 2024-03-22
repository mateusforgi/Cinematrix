//
//  UserDefaultWrapper.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation

struct UserDefaultWrapper {
    enum Key: String {
        case movieListMetaData
    }
    
    static let defaults = UserDefaults.standard
    
    static func save<T: Codable>(_ data: T, for key: Key) throws {
        let json = try JSONEncoder().encode(data)
        defaults.set(json, forKey: key.rawValue)
    }
    
    static func get<T: Codable>(_ key: Key) throws -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
