

import Foundation

class LeagueViewModel{
    
    var networkRequest:NetworkRequestProtocol = DependencyProvider.networkRequestHandler
    var bindResultToViewController : (()->()) = {}
    
    var result:Leagues = Leagues(leagues: [])  {
        didSet{
            bindResultToViewController()
        }
    }
    
    func fetchLeagues(sport:String){
        let url = APIHelper.baseURL + sport + APIHelper.EndPoints.leagues.rawValue + APIHelper.EndPointsParam.apiKey.rawValue + APIHelper.apiKey
        
        networkRequest.fetchData(url: url) { [weak self] leagues in
            guard let leagues:Leagues = leagues else{
                return
            }
            self?.result = leagues
        }
    }
    
    func getLeagues() -> Leagues{
        return result
    }
}
