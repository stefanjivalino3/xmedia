//
//  AlbumCell.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import UIKit
import Kingfisher

protocol AlbumCellDelegate: AnyObject {
    func goToPhotoDetail (for cell: AlbumCell, url: String, title: String)
}

class AlbumCell: UITableViewCell {
    weak var delegate: AlbumCellDelegate?
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbnailCollectionView: UICollectionView!
    
    var photos: [Photos] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 12
        thumbnailCollectionView.register(UINib.init(nibName: "ThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "ThumbnailCell")
        thumbnailCollectionView.delegate = self
        thumbnailCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AlbumCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailCell", for: indexPath) as! ThumbnailCell
        cell.photoImage.kf.setImage(with: URL(string: photos[indexPath.row].thumbnailUrl ?? ""), placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = self
        delegate?.goToPhotoDetail(for: currentCell, url: photos[indexPath.row].url ?? "", title: photos[indexPath.row].title ?? "")
    }
    
    
}
