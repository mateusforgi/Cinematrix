//
//  BaseRepository.swift
//  Cinematrix
//
//  Created by Mateus on 22/03/2024.
//

import Foundation
import CoreData

class BaseRepository<T: NSManagedObject> {
    
    let context: NSManagedObjectContext
    let entityName = String(describing: T.self)
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func batch(_ events: [[String : Any]]) async throws -> [NSManagedObjectID] {
        return try await context.perform({ [weak self] in
            guard let self else {
                return []
            }
            
            let batchInsertRequest = NSBatchInsertRequest(entity: T.entity(), objects: events)
            batchInsertRequest.resultType = .objectIDs
            
            let result  = try self.context.execute(batchInsertRequest) as? NSBatchInsertResult
            let addedIDs = result?.result as? [NSManagedObjectID] ?? []
            
            try self.context.save()
            
            return addedIDs
        })
    }
    
    func deleteAllData() async throws -> [NSManagedObjectID] {
        return try await context.perform{ [weak self] in
            guard let self else {
                return []
            }
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: self.entityName)
            
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeObjectIDs
            
            let result = try self.context.execute(batchDeleteRequest) as? NSBatchDeleteResult
            let ids = result?.result as? [NSManagedObjectID] ?? []
            
            try self.context.save()
            
            return ids
        }
    }
}
