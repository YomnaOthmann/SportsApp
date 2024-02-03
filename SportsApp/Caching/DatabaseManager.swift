//
//  DatabaseManager.swift
//  SportsApp
//
//  Created by Mac on 03/02/2024.
//

import Foundation
import CoreData
import UIKit

protocol DatabaseManagerProtocol{
    func fetchData()->[League]
    func addToFavourites(league:League)
    func removeFromFavourites(leagueId:Int)
    func saveToDB(successMessage:String, failureMessage:String)
    
}

class DatabaseManager : DatabaseManagerProtocol{
    
    private let delegate = UIApplication.shared.delegate as! AppDelegate
    private let context : NSManagedObjectContext
    
    static private let database = DatabaseManager()
   
    static func getInstance() -> DatabaseManager{
        return database
    }
    private init(){
        context = delegate.persistentContainer.viewContext
    }
    
    func fetchData()->[League]{
        var data : [NSManagedObject] = []
        var leagues : [League] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
        
        do{
            data = try context.fetch(fetchRequest)
            
            for league in data {
                leagues.append(
                    League(
                        leagueId: (league.value(forKey: "id") as? Int) ?? 0,
                        leagueName: (league.value(forKey: "leagueName") as? String) ?? "",
                        leagueLogo: (league.value(forKey: "leagueLogo") as? String) ?? ""
                    )
                )
            }
        }
        catch let error{
            print(error.localizedDescription)
        }
        return leagues
    }
    
    func addToFavourites(league:League){
        guard let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: context)else{
            return
        }
        let newLeague = NSManagedObject(entity: entity, insertInto: context)
        
        newLeague.setValue(league.leagueId, forKey: "id")
        newLeague.setValue(league.leagueName, forKey: "leagueName")
        newLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
        
        saveToDB(successMessage: "League Added to Favourites", failureMessage: "Failed to Add League!!")
    }
    
    func removeFromFavourites(leagueId: Int) {
        
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "id == \(leagueId)")
        
        do{
            let leagues = try context.fetch(fetchRequest)
            guard let league = leagues.first else{
                return
            }
            context.delete(league)
            saveToDB(successMessage: "Deleted league from Favourites", failureMessage: "Failed to delete league")
            
        }
        catch let error{
            print(error.localizedDescription)
        }
        
    }
    
    func saveToDB(successMessage:String, failureMessage:String) {
        do{
            try context.save()
            print(successMessage)
        }
        catch {
            print(failureMessage)
        }
    }
    
    
}
