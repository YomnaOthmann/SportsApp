//
//  Leagues.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

struct Leagues : Codable{
    var leagues : [League]
    
    init(leagues: [League]) {
        self.leagues = leagues
    }
    
    enum CodingKeys : String, CodingKey{
        case leagues = "result"
    }
}
