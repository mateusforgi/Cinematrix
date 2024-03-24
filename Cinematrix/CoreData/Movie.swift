//
//  Movie.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import CoreData

@objc(Movie)
class Movie: NSManagedObject {
    @NSManaged var overview: String
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var posterPath: String
    @NSManaged var voteAverage: Double
    @NSManaged var order: Int
}

extension Movie {
    static func pageSizeRequest(of pageSize: Int) -> NSFetchRequest<Movie> {
        let request = Self.fetchRequest() as! NSFetchRequest<Movie>
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Movie.order, ascending: true)]
        request.fetchBatchSize = pageSize
       
        return request
    }
}
