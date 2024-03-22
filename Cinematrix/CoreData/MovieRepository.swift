//
//  MovieRepository.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation
import CoreData

final class MovieRepository: BaseRepository<Movie>, MovieStorage {}

protocol MovieStorage {
    func batch(_ events: [[String : Any]]) async throws -> [NSManagedObjectID]
    func deleteAllData() async throws -> [NSManagedObjectID]
}
