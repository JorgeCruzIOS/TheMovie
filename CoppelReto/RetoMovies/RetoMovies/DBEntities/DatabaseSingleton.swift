//
//  DatabaseServiceSingleton.swift
//  FilmMaker
//
//  Created by ehecatl2 on 21/07/20.
//  Copyright © 2020 ehecatl. All rights reserved.
//

import UIKit
import CoreData

class DatabaseSingleton: NSObject {
    
     static let shareInstance = DatabaseSingleton()
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "RetoMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
    
    
    func addFavoriteMovie(movie: MovieEntity)->Void{
        let managedContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteMovies", in: managedContext)!
        let rol = NSManagedObject(entity: entity, insertInto: managedContext)
        
        rol.setValue(movie.id, forKey: "id")
        rol.setValue(movie.type, forKey: "type")
        rol.setValue(movie.title, forKey: "title")
        rol.setValue(movie.overview, forKey: "overview")
        rol.setValue(movie.date, forKey: "date")
        rol.setValue(movie.poster_path, forKey: "poster_path")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func deleteFavoriteMovie(id:Int)->Void{
         let managedContext = self.persistentContainer.viewContext
         let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
         deleteFetch.predicate = NSPredicate(format: "id == %i", id)
         let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
         
         do {
             try managedContext.execute(deleteRequest)
             try managedContext.save()
         } catch {
             print ("There was an error")
         }
    }
    
    func fetchFavoriteMovieById(id:Int)->Bool{
        let managedContext = self.persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
        request.predicate = NSPredicate(format: "id == %i", id)
        request.resultType = .dictionaryResultType
        var result = NSArray()
        do {
            let requestDictionary = try managedContext.fetch(request)
            result = requestDictionary as NSArray
            print(result)
        } catch {
            print("Failed")
        }
        return result.count > 0 ? true : false
    }
    
    func fetchFavoriteMovie()->NSArray{
        let managedContext = self.persistentContainer.viewContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
        request.resultType = .dictionaryResultType
        var result = NSArray()
        do {
            let requestDictionary = try managedContext.fetch(request)
            result = requestDictionary as NSArray
        } catch {
            print("Failed")
        }
        return result
     }

}
