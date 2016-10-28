//
//  CoreDataStack.swift
//  CoreDataPractice
//
//  Created by Sau Chung Loh on 10/20/16.
//  Copyright © 2016 Matthew Loh. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    func seedCoreDataIfNeeded() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "House")
        do {
            let count = try self.persistentContainer.viewContext.count(for: fetchRequest)
            print("******Count of Fetched Objects: \(count) *******")
            if count == 0 {
                self.parseJSON()
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    // MARK: - JSON File Parsing to Seed Data
    func parseJSON() {
        //Locate Path of file
        //Get date from Path of file
        //Serialize Data
        //Parse into objects
        if let jsonPath = Bundle.main.path(forResource: "houses", ofType: "json") {
            do {
                let jsonData = try NSData(contentsOfFile: jsonPath, options: NSData.ReadingOptions.mappedIfSafe)
                do {
                    let jsonResult : NSDictionary = try JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    if let houses : [NSDictionary] = jsonResult["Houses"] as? [NSDictionary] { //RootObject
                        for house : NSDictionary in houses { //
                            let newHouse = House(context: self.persistentContainer.viewContext)
//                            guard let name = house["name"] as? String else {
//                                //For now handle with nil should probably do custom error
//                                return
//                            }
//                            
//                            print(name)
//                            newHouse.name = name
//                            
//                            guard let motto = house["motto"] as? String else {
//                                return
//                            }
//                            
//                            print(motto)
//                            newHouse.motto = motto
//                            
//                            guard let location = house["location"] as? String else {
//                                return
//                            }
//                            print(location)
//                            newHouse.location = location
                            guard let name = house["name"] as? String,
                                let motto = house["motto"] as? String,
                                let location = house["location"] as? String else {
                                    return // should I keep them separate so I know which part specifically was missing in the error?
                            }
                            
                            newHouse.name = name
                            newHouse.motto = motto
                            newHouse.location = location

                            
                            if let members : [NSDictionary] = house["members"] as? [NSDictionary] {
                                for member : NSDictionary in members {
                                    let newMember = Member(context: self.persistentContainer.viewContext)
                                    guard let firstName = member["firstName"] as? String else {
                                        return
                                    }
                                    
                                    //print(firstName)
                                    newMember.firstName = firstName
                                    
                                    guard let lastName = member["lastName"] as? String else {
                                        return
                                    }
                                    
                                    //print(lastName)
                                    newMember.lastName = lastName
                                    
                                    newMember.house = newHouse
                                }
                            }
                            
                        }
                        //Save?
                        do {
                            try self.persistentContainer.viewContext.save()
                        } catch let error as NSError {
                            print("Could not save \(error), \(error.userInfo)")
                        }

                    }
                    
                } catch{}
            } catch {}
        }
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CoreDataPractice")
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
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
