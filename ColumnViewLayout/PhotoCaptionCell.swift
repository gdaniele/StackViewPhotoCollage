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
	// MARK:- Layout Concerns
	private var imageViewHeightLayoutConstraint: NSLayoutConstraint

	// MARK:- Lazy UI
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .ScaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = UIColor.orangeColor()
		return imageView
	}()
	
	private let mainView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	private let titleLabel: UILabel = {
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
	
	override init(frame: CGRect) {
		self.imageViewHeightLayoutConstraint = NSLayoutConstraint(item: self.imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 200)
		super.init(frame: CGRectZero)
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		self.backgroundColor = UIColor.yellowColor()
		// Construct mainView
		self.mainView.addSubview(self.imageView)
		self.mainView.addSubview(self.titleLabel)
		
		// Add views to contentView
		self.contentView.addSubview(self.mainView)
		self.contentView.translatesAutoresizingMaskIntoConstraints = false
		
		// Set mainViewContstraints
		self.addConstraint(NSLayoutConstraint(item: self.mainView, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.mainView, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.mainView, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.mainView, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1, constant: 0))

		/// Set imageView constraints
		self.addConstraint(self.imageViewHeightLayoutConstraint)
		self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .Top, relatedBy: .Equal, toItem: self.contentView, attribute: .Top, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1, constant: 0))
		
		/// Set titleLabel constraints
		self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .Leading, relatedBy: .Equal, toItem: self.contentView, attribute: .Leading, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .Trailing, relatedBy: .Equal, toItem: self.contentView, attribute: .Trailing, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1, constant: 0))
		self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .Top, relatedBy: .Equal, toItem: self.imageView, attribute: .Bottom, multiplier: 1, constant: 0))
	}
	
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let attributes = layoutAttributes as! TwoColumnLayoutAttributes
		self.imageViewHeightLayoutConstraint.constant = attributes.photoHeight
    }
}
