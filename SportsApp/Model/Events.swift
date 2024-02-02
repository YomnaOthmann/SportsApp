
import Foundation

struct Events : Codable{
    var events : [Event]
    
    init(events: [Event]) {
        self.events = events
    }
    
    enum CodingKeys :String , CodingKey{
        case events = "result"
    }
}
