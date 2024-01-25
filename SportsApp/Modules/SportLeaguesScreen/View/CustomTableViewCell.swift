//
//  CustomTableViewCell.swift
//  SportsApp
//
//  Created by Mac on 25/01/2024.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var leagueImage: UIImageView!
    
    @IBOutlet weak var leagueName: UILabel!
    
    static let cellReuseIdentifier = "cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
}
