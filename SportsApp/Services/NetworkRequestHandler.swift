

import Foundation
import Alamofire

protocol NetworkRequestProtocol{
    
    func fetchData<T:Decodable>(url: String, completionHandler: @escaping(T?, Error?)->Void)
       
}

class NetworkRequestHandler : NetworkRequestProtocol{
    
    func fetchData<T:Decodable>(url: String, completionHandler:@escaping(T?, Error?)->Void) {
        var data : T?
        
        AF.request(url).validate().responseDecodable(of: T.self){ (response) in
            guard let result = response.value else{
                completionHandler(nil, response.error)
                return
            }
            data = result
            completionHandler(data, nil)

        }
    }
    
    
}
