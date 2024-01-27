//
//  LeagueModel.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

struct League : Codable{
    
    var leagueId : Int
    var leagueName : String
    var leagueLogo : String?
    
    init(leagueId: Int, leagueName: String, leagueLogo: String? = nil) {
        self.leagueId = leagueId
        self.leagueName = leagueName
        self.leagueLogo = leagueLogo
    }
    
    enum CodingKeys : String, CodingKey{
        case leagueId = "league_key"
        case leagueName = "league_name"
        case leagueLogo = "league_logo"
    }
}
