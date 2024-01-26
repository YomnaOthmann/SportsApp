

import UIKit

class TeamPlayerCustomCell: UITableViewCell {

    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    
    @IBOutlet weak var playerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static let teamCellId = "TeamPlayerCustomCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "TeamPlayerCustomCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
