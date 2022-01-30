//
//  ThumbnailCell.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 12
        
    }

}
