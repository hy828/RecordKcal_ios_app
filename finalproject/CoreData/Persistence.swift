//
//  Persistence.swift
//  finalproject
//
//  Created by lhy on 2023/6/17.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let data = Profile(context: viewContext)
        data.name = ""
        data.age = 123
        data.height = 123
        data.weight = 123
        data.bmi = 123
        data.goal = ""
        data.goalWeight = 123
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "finalproject")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
//        self.parseEntities(container: container)
//        self.insertRecord(container: container, foodName: "aaa", calories: 123, date: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 18))!)
//        self.insertProfile(container: container, name: "小明", age: 22, weight: 50, height: 175, goal: "gain", goalWeight: 55, bmi: 16.32)
        self.getRecords(container: container)
    }
    
    private func parseEntities(container: NSPersistentContainer) {
        let entities = container.managedObjectModel.entities
        print("Entity count = \(entities.count)\n")
        for entity in entities {
            print("Entity: \(entity.name!)")
//            for property in entities.description.propertyList() {
//                print("Property: \(property.name)")
//            }
            print("")
        }
    }
    
    private func insertRecord(container: NSPersistentContainer, foodName: String, calories: Int, date: Date) {
        let context = container.viewContext
        let food = NSEntityDescription.insertNewObject(forEntityName: "Food", into: context) as! Food
        food.foodName = foodName
        food.kcal = Int16(calories)
        food.date = date
        if context.hasChanges {
            do {
                try context.save()
                print("Insert record \(food) successful.")
            } catch {
                print("\(error)")
            }
        }
    }
    
    private func insertProfile(container: NSPersistentContainer, name: String, age: Int, weight: Float, height: Float, goal: String, goalWeight: Float, bmi: Float) {
        let context = container.viewContext
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as! Profile
        profile.name = name
        profile.age = Int16(age)
        profile.weight = weight
        profile.height = height
        profile.goal = goal
        profile.goalWeight = goalWeight
        profile.bmi = bmi
        if context.hasChanges {
            do {
                try context.save()
                print("Insert record \(profile) successful.")
            } catch {
                print("\(error)")
            }
        }
    }
    
    private func getRecords(container: NSPersistentContainer) {
        let context = container.viewContext
        let fetchRecords = NSFetchRequest<Food>(entityName: "Food")
        do {
            let records = try context.fetch(fetchRecords)
            print("Records count = \(records.count)")
//            for record in records {
//                print("\(record.foodName) - \(record.kcal) - \(record.date)")
//            }
        } catch {
            
        }
    }
}
