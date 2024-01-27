//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Mac on 25/01/2024.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamImage: UIImageView!
    
    
    @IBOutlet weak var teamName: UILabel!
    
    static let teamCellId = "TeamCollectionViewCell"
    
    @IBOutlet weak var cellView: UIView!
    
    static func nib() -> UINib{
        return UINib(nibName: "TeamCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
