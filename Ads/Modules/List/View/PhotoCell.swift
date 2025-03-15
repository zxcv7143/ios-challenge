//
//  PhotoTableViewCell.swift
//  Ads
//
//  Created by Anton Zuev on 15/3/25.
//

import UIKit

final class PhotoCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    
    static let cellId: String = "PhotoCellId"
    
    func load(url: String?) {
        self.imageView.loadImage(from: url)
    }
    
    // MARK: Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }

}
