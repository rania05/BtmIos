//
//  CoreDataManager.swift
//  BTMFINAL
//
//  Created by macbook on 12/28/20.
//

import Foundation

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "app")
            container.loadPersistentStores(completionHandler: { _, error in
                _ = error.map { fatalError("Unresolved error \($0)") }
            })
            return container
        }()
        
        var mainContext: NSManagedObjectContext {
            return persistentContainer.viewContext
        }
        
        func backgroundContext() -> NSManagedObjectContext {
            return persistentContainer.newBackgroundContext()

}
}
