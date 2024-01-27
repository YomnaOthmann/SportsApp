//
//  LeagueModel.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

class League : Codable{
    var leagueName : String
    var leagueLogo : String
    var teams : [Team]
}
