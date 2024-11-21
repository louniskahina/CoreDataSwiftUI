//
//  PersistenceController.swift
//  MyCoreDataProject
//
//  Created by Kahina Lounis on 21/11/2024.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Erreur lors du chargement du store Core Data : \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }
}