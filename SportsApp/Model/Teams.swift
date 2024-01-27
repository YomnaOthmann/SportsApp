//
//  Teams.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

struct Teams : Codable{
    var teams : [Team]
    
    init(teams: [Team]) {
        self.teams = teams
    }
    
    enum CodingKeys : String , CodingKey{
        case teams = "result"
    }
}
