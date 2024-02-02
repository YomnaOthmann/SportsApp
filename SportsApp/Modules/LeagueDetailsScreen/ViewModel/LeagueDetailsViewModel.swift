//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Mac on 29/01/2024.
//

import Foundation


class LeagueDetailsViewModel{
    
    let networkRequest: NetworkRequestProtocol
    
    let dateFormatter = DateFormatter()
    
    var isRetrieveUpcomingEvents : Observable<Bool>
    var upcoming : Events
    
    var isRetrieveLatestResult : Observable<Bool>
    var latest : Events
    
    var isRetrieveTeams : Observable<Bool>
    var teams : Teams
    
    init(networkRequest: NetworkRequestProtocol) {
        self.networkRequest = networkRequest
        
        isRetrieveUpcomingEvents = Observable(value: nil)
        upcoming = Events(events: [])
        
        isRetrieveTeams  = Observable(value: nil)
        teams = Teams(teams: [])
        
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
      
               
        networkRequest.fetchData(url: url) {[weak self] events in
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

        networkRequest.fetchData(url: url) {[weak self] events in
            guard let events:Events = events else{
                self?.isRetrieveLatestResult.value = false
                return
            }
            self?.latest = events
            self?.isRetrieveLatestResult.value = true

        }
    }
    
    func fetchTeams(sport:String, leagueID:Int ){
        let url = APIHelper.baseURL + sport + APIHelper.EndPoints.teams.rawValue + APIHelper.EndPointsParam.leagueId.rawValue + String(leagueID) + APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey
        
        let url2 = "https://apiv2.allsportsapi.com/football/?&met=Teams&leagueId=152&APIkey=fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
       print(url)
        networkRequest.fetchData(url: url2) {[weak self] data in
            guard let teams: Teams = data else{
                self?.isRetrieveTeams.value = false
                return
            }
            self?.teams = teams
            self?.isRetrieveTeams.value = true
        }
    }
    
}
