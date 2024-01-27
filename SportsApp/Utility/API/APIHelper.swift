//
//  APIHandler.swift
//  SportsApp
//
//  Created by Mac on 23/01/2024.
//

import Foundation

class APIHelper{
    
    static let apiKey = "fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
    static let baseURL = "https://apiv2.allsportsapi.com/"
    
    enum Sports : String{
        case football = "football/"
        case basketball = "basketball/"
        case tennis = "tennis/"
        case cricket = "cricket/"
    }
    
    enum FootballEndPoints : String{
        case leagues = "?met=Leagues"
        case fixtures = "met=Fixtures"
        case teams = "?&met=Teams"
        
    }
    
    enum BasketballEndPoints{
    }
    
    enum TennisEndPoints{
    }
    enum CricketEndPoints{
    }
    
    enum EndPointsParam : String{
      
        case apiKey = "&APIkey="
        case teamId = "&teamId="
        case leagueId = "&leagueId="
    }
    
    enum FixturesDateParam : String{
        case from = "&from="
        case to = "&to="
    }
}
