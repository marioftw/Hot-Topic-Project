//
//  CoreDataStack.swift
//  Vitality
//
//  Created by Mario Aguirre on 29/06/20.
//  Copyright © 2020 Mario & Simran. All rights reserved.
//
// Code reference:
// https://github.com/jrasmusson/swift-arcade/blob/master/CoreData/1-GettingStarted.md

import CoreData

struct SurgeryCoreDataManager {
    
    static let shared = SurgeryCoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Vitality")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        return container
    }()
    
    @discardableResult
    func addSurgery(name: String, about: String) -> Surgery? {
        let context = persistentContainer.viewContext
        let surgery = NSEntityDescription.insertNewObject(forEntityName: "Surgery", into: context) as! Surgery // NSManagedObject

        surgery.name = name

        do {
            try context.save()
            return surgery
        } catch let createError {
            print("Failed to add: \(createError)")
        }
        return nil
    }

    func fetchSurgery() -> [Surgery]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Surgery>(entityName: "Surgery")

        do {
            let surgeries = try context.fetch(fetchRequest)
            return surgeries
        } catch let fetchError {
            print("Failed to fetch surgeries: \(fetchError)")
        }
        return nil
    }
    
    func fetchSurgeryByName(withName name: String) -> Surgery? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Surgery>(entityName: "Surgery")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let surgeries = try context.fetch(fetchRequest)
            return surgeries.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
        return nil
    }

    func updateSurgery(surgery: Surgery) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteSurgery(surgery: Surgery) {
        let context = persistentContainer.viewContext
        context.delete(surgery)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }

}
