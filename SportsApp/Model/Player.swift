//
//  Player.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

struct Player : Codable{
    
    var playerName : String
    var playerImage : String
    var playerPosition : String
    var playerAge : String
    
    init(playerName: String, playerImage: String, playerPosition: String, playerAge: String) {
        self.playerName = playerName
        self.playerImage = playerImage
        self.playerPosition = playerPosition
        self.playerAge = playerAge
    }
    
    enum CodingKeys : String, CodingKey{
        case playerName = "player_name"
        case playerImage = "player_image"
        case playerPosition = "player_type"
        case playerAge = "player_age"
    }
    
    
}
