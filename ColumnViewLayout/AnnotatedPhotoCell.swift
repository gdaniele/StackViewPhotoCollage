//
//  AnnotatedPhotoCell.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                titleLabel.text = photo.caption
            }
        }
    }
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes!) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        
        imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
}