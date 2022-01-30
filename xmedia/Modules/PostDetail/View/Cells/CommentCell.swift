//
//  CommentCell.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import UIKit

class CommentCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.roundedImage()
        let image = profileImageView.image?.imageWithInsets(insets: UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3))
        profileImageView.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
