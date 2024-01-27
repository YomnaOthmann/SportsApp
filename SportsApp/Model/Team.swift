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
    var teamPlayers : [Player]
    
    init(teamName: String, teamLogo: String, teamPlayers: [Player]) {
        self.teamName = teamName
        self.teamLogo = teamLogo
        self.teamPlayers = teamPlayers
    }
    
    enum CodingKeys : String, CodingKey{
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case teamPlayers = "players"
    }
    
}
