//
//  MovieService.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation
import CoreData

protocol MovieProvider {
    func fetch(page: Int, pageSize: Int, deleteCache: Bool) async throws -> Int
}

final class MovieService: MovieProvider {
    let respository: MovieStorage
    let client: MovieClient
    let notifyOn: NSManagedObjectContext
    
    init(respository: MovieStorage = MovieRepository(context: PersistenceController.shared.nextbackgroundContext()),
         client: MovieClient = MovieNetworkClient(),
         notifyOn: NSManagedObjectContext = PersistenceController.shared.viewContext) {
        self.respository = respository
        self.client = client
        self.notifyOn = notifyOn
    }
    
    func fetch(page: Int, pageSize: Int, deleteCache: Bool) async throws -> Int {
        let result: MovieResponseDTO = try await client.popularMovies(page, size: pageSize)
        
        let movies = result.results
        let changes = try await add(movies, page: Int(page), pageSize: pageSize, deleteCache: deleteCache)
        
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes,
                                            into: [notifyOn])
        
        return result.totalPages
    }
    
    func add(_ movies: [MovieResponseDTO.Movie], page: Int, pageSize: Int, deleteCache: Bool) async throws -> [AnyHashable : Any] {
        var deletedIDs = [NSManagedObjectID] ()
       
        if deleteCache {
            deletedIDs = try await respository.deleteAllData()
        }
        
        var order = page * pageSize
        
        let eventsDic: [[String: Any]] = movies.map { item in
            order += 1
            return [#keyPath(Movie.id): item.id,
                    #keyPath(Movie.overview): item.overview,
                    #keyPath(Movie.title): item.title,
                    #keyPath(Movie.order): order,
                    #keyPath(Movie.posterURL): client.imageBaseURL.appendingPathComponent(item.posterPath).absoluteString,
                    #keyPath(Movie.voteAverage): item.voteAverage]}
        
        let addedIDs = try await respository.batch(eventsDic)
        
        let changes: [AnyHashable : Any] = [NSUpdatedObjectsKey: addedIDs, NSDeletedObjectsKey: deletedIDs]

        return changes
    }
}
