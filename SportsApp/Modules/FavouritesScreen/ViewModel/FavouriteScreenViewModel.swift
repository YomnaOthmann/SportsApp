//
//  FavouriteScreenViewModel.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

class FavouriteScreenViewModel{
    
    let database : DatabaseManagerProtocol
    
    init(database: DatabaseManagerProtocol) {
        self.database = database
    }
    
    func fetchData()->[League]{
        var leagues = database.fetchData()
        return leagues
    }
    
    func removeLeague(id:Int){
        database.removeFromFavourites(leagueId: id)
    }
    func addLeague(league:League){
        database.addToFavourites(league: league)
    }
    
}
