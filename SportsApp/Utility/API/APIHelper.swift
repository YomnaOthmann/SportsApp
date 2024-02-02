//
//  APIHandler.swift
//  SportsApp
//
//  Created by Mac on 23/01/2024.
//

import Foundation

class APIHelper{
    
    // APIHelper.baseURL + sport + APIHelper.EndPoints.fixtures.rawValue + APIHelper.EndPointsParam.leagueId.rawValue + String(leagueID)  + APIHelper.EndPointsParam.from.rawValue + setDate().currentYearDate + APIHelper.EndPointsParam.to.rawValue + setDate().afterOneYearDate +  APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey
    
    //https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=145&from
    //https://apiv2.allsportsapi.com/football/?met=Fixtures&leagueId=145&from=2024-02-02&to=2025-02-02&APIkey=fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee&
    
    static let apiKey = "fed3a52ea9f8c40c84d5bb10a9be1930aa2702de4bb0b9bc4e2f6f94858fa3ee"
    static let baseURL = "https://apiv2.allsportsapi.com/"
    
    enum Sports : String{
        case football = "football/"
        case basketball = "basketball/"
        case tennis = "tennis/"
        case cricket = "cricket/"
    }
    
    enum EndPoints : String{
        case leagues = "?met=Leagues"
        case fixtures = "?met=Fixtures"
        case teams = "?&met=Teams"
        
    }
    
    enum EndPointsParam : String{
        case apiKey = "&APIkey="
        case teamId = "&teamId="
        case leagueId = "&leagueId="
        case from = "&from="
        case to = "&to="
    }
    

}
