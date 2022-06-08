//
//  StorageService.swift
//  TestUnsplash
//
//  Created by Denis Svetlakov on 07.06.2022.
//

import Foundation
import CoreData

class StorageService {
    
    static let shared = StorageService()
    
    private init() {}
    
    static var viewContext: NSManagedObjectContext {
        return shared.persistentContainer.viewContext
    }
    
    static let managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: StorageService.self)])!
        return managedObjectModel
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Favorites", managedObjectModel: StorageService.managedObjectModel)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyStoreTrumpMergePolicyType)
        
        return container
    }()
    
    func saveContext() {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
    static func fetchAllFavorites() -> [CDPicture] {
        var results: [CDPicture] = []
        viewContext.performAndWait {
            let request: NSFetchRequest<CDPicture> = CDPicture.fetchRequest()
            do {
                results = try viewContext.fetch(request)
            } catch {
            print("Error fetch")
            }
        }
        return results
    }
    
    static func getBy(id: String) -> CDPicture? {
        var results: CDPicture?
        viewContext.performAndWait {
            let request: NSFetchRequest<CDPicture> = CDPicture.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            results = (try? viewContext.fetch(request))?.first
        }
        return results
    }
}
