//
//  Event.swift
//  SportsApp
//
//  Created by Mac on 27/01/2024.
//

import Foundation

struct Event : Codable{
    
    var homeTeamName : String
    var homeTeamLogo : String
    var awayTeamName : String
    var awayTeamLogo : String
    
    var eventDate : String
    var eventTime : String
    
    var finalResult : String
    
    init(homeTeamName: String, homeTeamLogo: String, awayTeamName: String, awayTeamLogo: String, eventDate: String, eventTime: String, finalResult: String) {
        self.homeTeamName = homeTeamName
        self.homeTeamLogo = homeTeamLogo
        self.awayTeamName = awayTeamName
        self.awayTeamLogo = awayTeamLogo
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.finalResult = finalResult
    }
    enum CodingKeys : String , CodingKey{
        
        case homeTeamName = "event_home_team"
        case homeTeamLogo = "home_team_logo"
        case awayTeamName = "event_away_team"
        case awayTeamLogo = "away_team_logo"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case finalResult = "event_final_result"
    }
}
