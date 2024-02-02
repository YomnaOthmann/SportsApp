

import Foundation
import Alamofire

protocol NetworkRequestProtocol{
    
    func fetchData<T:Decodable>(url: String, completionHandler: @escaping(T?)->Void)
       
}

class NetworkRequestHandler : NetworkRequestProtocol{
    
    func fetchData<T:Decodable>(url: String, completionHandler:@escaping(T?)->Void) {
        var data : T?
        
        AF.request(url).validate().responseDecodable(of: T.self){ (response) in
            guard let result = response.value else{
                completionHandler(nil)
                return
            }
            data = result
            
            completionHandler(data)

        }
    }
    
    
}
