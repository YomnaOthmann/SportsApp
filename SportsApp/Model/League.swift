import Foundation

struct League : Codable{
    
    var leagueId : Int
    var leagueName : String
    var leagueLogo : String?
    var category : String?
    
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
