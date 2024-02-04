//
//  TeamViewModel.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation


class TeamViewModel{
    
    let networkRequest: NetworkRequestProtocol
    
    var isRetrieveTeams : Observable<Bool>
    var teams : Teams
    
    init(networkRequest: NetworkRequestProtocol) {
        self.networkRequest = networkRequest
        
        isRetrieveTeams  = Observable(value: nil)
        teams = Teams(teams: [])
        
    }
    func fetchTeams(sport:String, leagueID:Int, teamId:Int ){
        
        let url = APIHelper.baseURL + sport + APIHelper.EndPoints.teams.rawValue + APIHelper.EndPointsParam.leagueId.rawValue + String(leagueID) + APIHelper.EndPointsParam.teamId.rawValue + String(teamId) + APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey
        
       print(url)
        networkRequest.fetchData(url: url) {[weak self] data , error in
            guard let teams: Teams = data else{
                self?.isRetrieveTeams.value = false
                return
            }
            self?.teams = teams
            self?.isRetrieveTeams.value = true
        }
    }
}
