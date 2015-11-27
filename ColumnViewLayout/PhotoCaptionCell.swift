//
//  PhotoCaptionCell.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

// Inspired by http://www.raywenderlich.com/99146/video-tutorial-custom-collection-view-layouts-part-1-pinterest-basic-layout
class PhotoCaptionCell: UICollectionViewCell {
	// MARK:- Lazy UI
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .ScaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = UIColor.orangeColor()
		return imageView
	}()
	private lazy var mainView: UIView = {
		let view = UIStackView(arrangedSubviews: [self.imageView, self.titleLabel])
		
		view.axis = UILayoutConstraintAxis.Vertical
		view.distribution = UIStackViewDistribution.EqualCentering
		view.alignment = UIStackViewAlignment.Leading
		
		return view
	}()
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "AvenirMedium", size: 13)
		label.textAlignment = .Center
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = UIColor.purpleColor()
		return label
	}()
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                titleLabel.text = photo.caption
            }
        }
    }
	
	override func layoutSubviews() {
		self.backgroundColor = UIColor.yellowColor()
		
		// Add views to contentView
		self.addSubview(self.mainView)
		
		// Set mainViewContstraints
		self.addConstraints(
			NSLayoutConstraint.constraintsWithVisualFormat("V:[stackView]", options: .AlignAllLeft, metrics: nil, views: ["stackView": self.mainView])
		)
		
		self.addConstraints(
			NSLayoutConstraint.constraintsWithVisualFormat("H:[stackView]", options: .AlignAllLeft, metrics: nil, views: ["stackView": self.mainView])
		)
	}
	
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
//        let attributes = layoutAttributes as! TwoColumnLayoutAttributes
//		self.imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
}
