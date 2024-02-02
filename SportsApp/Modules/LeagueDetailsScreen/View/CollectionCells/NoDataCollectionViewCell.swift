//
//  NoDataCollectionViewCell.swift
//  SportsApp
//
//  Created by Mac on 03/02/2024.
//

import UIKit

class NoDataCollectionViewCell: UICollectionViewCell {

    static let id = "nodata"
    static func nib()->UINib{
        return UINib(nibName: "NoDataCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
