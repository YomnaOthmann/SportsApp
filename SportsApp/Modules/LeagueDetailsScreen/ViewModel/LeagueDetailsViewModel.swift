//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Mac on 29/01/2024.
//

import Foundation


class LeagueDetailsViewModel{
    
    let database = DependencyProvider.database
    
    let networkRequest: NetworkRequestProtocol
    
    let dateFormatter = DateFormatter()
    
    var isRetrieveUpcomingEvents : Observable<Bool>
    var upcoming : Events
    
    var isRetrieveLatestResult : Observable<Bool>
    var latest : Events
        
    init(networkRequest: NetworkRequestProtocol) {
        self.networkRequest = networkRequest
        
        isRetrieveUpcomingEvents = Observable(value: nil)
        upcoming = Events(events: [])
        
        isRetrieveLatestResult  = Observable(value: nil)
        latest = Events(events: [])
    }
    
    func setDate()->(oneYearBeforeDate:String,afterOneYearDate:String,currentYearDate:String){
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        let startDate = dateFormatter.string(
            from: Calendar.current.date(
                byAdding: .year,
                value: -1,
                to: Date()
            ) ?? Date()
        )
        let endDate = dateFormatter.string(
            from: Calendar.current.date(
                byAdding: .year,
                value: 1,
                to: Date()
            ) ?? Date()
        )
        let currentDate = dateFormatter.string(
            from: Date()
            )
        
        return (startDate , endDate, currentDate)
    }

    
    func fetchUpcomingEvents(sport:String,leagueID:Int){

        let url = APIHelper.baseURL + sport + APIHelper.EndPoints.fixtures.rawValue + APIHelper.EndPointsParam.leagueId.rawValue + String(leagueID)  + APIHelper.EndPointsParam.from.rawValue + setDate().currentYearDate + APIHelper.EndPointsParam.to.rawValue + setDate().afterOneYearDate +  APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey
      
               
        networkRequest.fetchData(url: url) {[weak self] events, error  in
            guard let events:Events = events else{
                self?.isRetrieveUpcomingEvents.value = false
                return
            }
            self?.upcoming = events
            self?.isRetrieveUpcomingEvents.value = true
        }
    }
    func fetchLatestResults(sport:String,leagueID:Int){
      
        let url = APIHelper.baseURL + sport  + APIHelper.EndPoints.fixtures.rawValue + APIHelper.EndPointsParam.leagueId.rawValue + String(leagueID) + APIHelper.EndPointsParam.from.rawValue + setDate().oneYearBeforeDate + APIHelper.EndPointsParam.to.rawValue + setDate().currentYearDate +  APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey

        networkRequest.fetchData(url: url) {[weak self] events, error in
            guard let events:Events = events else{
                self?.isRetrieveLatestResult.value = false
                return
            }
            self?.latest = events
            self?.isRetrieveLatestResult.value = true

        }
    }
    
    func addToFavourites(league:League){
        database.addToFavourites(league: league)
    }
    func removeFromFavourites(id:Int){
        database.removeFromFavourites(leagueId: id)
    }
    func isFavourite(league:League)->Bool{
        return database.fetchData().contains(){
            $0.leagueId == league.leagueId
        }
    }
    
}
