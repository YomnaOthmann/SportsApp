//
//  LeagueViewModel.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

class LeagueViewModel{
    
    var networkRequest:NetworkRequestProtocol = DependencyProvider.networkRequestHandler
    var bindResultToViewController : (()->()) = {}
    
    var result = Leagues(leagues: [])  {
        didSet{
            bindResultToViewController()
        }
    }
    
    func fetchLeagues(sport:String){
        let url = APIHelper.baseURL + sport + APIHelper.FootballEndPoints.leagues.rawValue + APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey
        
        networkRequest.fetchLeagues(url: url) {[weak self] leagues in
            guard let leagues = leagues else{
                return
            }
            self?.result = leagues
        }
    }
    
    func getLeagues() -> Leagues{
        return result
    }
}
