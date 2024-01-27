
import Foundation

import Alamofire
protocol NetworkReachabilityProtocol{
    func startNetworkMonitoring()
    func getReachable()->Bool
}
class NetworkReachabilityHandler : NetworkReachabilityProtocol{
    
    let reachabilityManager =  NetworkReachabilityManager()
   
    var reachable = false
    
    func startNetworkMonitoring(){
        
        reachabilityManager?.startListening(onUpdatePerforming: {[weak self] status in
            switch status {
                case .notReachable:
                    print("not reachable")
                    self?.reachable = false
                
                case .reachable, .unknown:
                    print("reachable")
                    self?.reachable = true
            }
        })
     
    }
    
    func getReachable()->Bool{
        return self.reachable
    }
    
}
