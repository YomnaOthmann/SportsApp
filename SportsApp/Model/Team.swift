//
//  TeamModel.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

struct Team : Codable{

    var teamName : String
    var teamLogo : String
    var teamPlayers : [Player]?
    var teamKey: Int
    
    init(teamName: String, teamLogo: String, teamKey: Int, teamPlayers: [Player]? = nil) {
        self.teamName = teamName
        self.teamLogo = teamLogo
        self.teamPlayers = teamPlayers
        self.teamKey = teamKey
    }
    
    enum CodingKeys : String, CodingKey{
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case teamPlayers = "players"
        case teamKey = "team_key"
    }
    
}
