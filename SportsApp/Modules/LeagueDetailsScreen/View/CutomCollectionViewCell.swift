//
//  CutomCollectionViewCell.swift
//  SportsApp
//
//  Created by Mac on 25/01/2024.
//

import UIKit

class CutomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackground: UIImageView!
    
    @IBOutlet weak var homeTeamLogo: UIImageView!
    
    @IBOutlet weak var homeTeamName: UILabel!
    
    @IBOutlet weak var awayTemLogo: UIImageView!
    
    @IBOutlet weak var awayTeamName: UILabel!
    
    @IBOutlet weak var homeTeamScore: UILabel!
    
    @IBOutlet weak var awayTeamScore: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var eventTime: UILabel!
    
    
    static let cellId = "CutomCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "CutomCollectionViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    

}
