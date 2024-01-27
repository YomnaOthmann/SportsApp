
import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let id = "HeaderCollectionReusableView"
   
    @IBOutlet weak var hederTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
