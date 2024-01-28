//
//  NetworkRequestHandler.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation
import Alamofire
protocol NetworkRequestProtocol{
    
    func fetchLeagues(url: String, completionHandler: @escaping(Leagues?)->Void)
    func fetchTeams(url:String)
    func fetchUpComingEvents(url:String)
    func fetchLatestResults(url:String)
    func fetchTeamPlayers(url:String)
    
}
class NetworkRequestHandler : NetworkRequestProtocol{
    var result = Leagues(leagues: [])

    func fetchLeagues(url: String, completionHandler:@escaping(Leagues?)->Void) {
        
        AF.request(url).validate().responseDecodable(of: Leagues.self){[weak self] (response) in
            guard let leagues = response.value else{
                completionHandler(nil)
                return
            }
            self?.result = leagues
            completionHandler(self?.result)
            

        }
    }
    
    func fetchTeams(url: String) {
        
    }
    
    func fetchUpComingEvents(url: String) {
        
    }
    
    func fetchLatestResults(url: String) {
        
    }
    
    func fetchTeamPlayers(url: String) {
        
    }
    
    
}
