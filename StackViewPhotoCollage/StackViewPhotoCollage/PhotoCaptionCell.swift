//
//  PhotoCaptionCell.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

// Inspired by http://www.raywenderlich.com/99146/video-tutorial-custom-collection-view-layouts-part-1-pinterest-basic-layout
class PhotoCaptionCell: UICollectionViewCell {
	// MARK:- Layout Concerns
	private var textHeightLayoutConstraint: NSLayoutConstraint?
	private var photoHeightLayoutConstraint: NSLayoutConstraint?

	// MARK:- Lazy UI
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .ScaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	private lazy var mainView: UIView = {
		let view = UIStackView(arrangedSubviews: [self.imageView, self.titleLabel])
		
		view.axis = UILayoutConstraintAxis.Vertical
		view.distribution = UIStackViewDistribution.EqualSpacing
		view.alignment = UIStackViewAlignment.Fill
		view.layoutMarginsRelativeArrangement = true
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	var titleFont: UIFont = UIFont(name: "Avenir", size: 15)! // set default font
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = self.titleFont
		label.textAlignment = .Left
		label.numberOfLines = 0
		label.lineBreakMode = .ByWordWrapping
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	// MARK:- Public API
	var image: UIImage? {
		didSet {
			if let uImage = image {
				imageView.image = uImage
			}
		}
	}
	var title: String? {
		didSet {
			if let uTitle = title {
				titleLabel.text = uTitle
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: CGRectZero)
		
		self.photoHeightLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 200)
		self.textHeightLayoutConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 30)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		self.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.2)
		
		// Add views to contentView
		self.addSubview(self.mainView)
		
		// Constraint stackView to cell's edges
		if let uSuperView = self.mainView.superview {
			self.addConstraints(
				[
					NSLayoutConstraint(item: self.mainView, attribute: .Top, relatedBy: .Equal, toItem: uSuperView, attribute: .Top, multiplier: 1, constant: 0),
					NSLayoutConstraint(item: self.mainView, attribute: .Bottom, relatedBy: .Equal, toItem: uSuperView, attribute: .Bottom, multiplier: 1, constant: 0),
					NSLayoutConstraint(item: self.mainView, attribute: .Leading, relatedBy: .Equal, toItem: uSuperView, attribute: .Leading, multiplier: 1, constant: 0),
					NSLayoutConstraint(item: self.mainView, attribute: .Trailing, relatedBy: .Equal, toItem: uSuperView, attribute: .Trailing, multiplier: 1, constant: 0)
				]
			)
		}
		
		// Add default padding around title label
		if let uSuperView = self.titleLabel.superview {
			self.addConstraints(
				[
					NSLayoutConstraint(item: self.titleLabel, attribute: .Leading, relatedBy: .Equal, toItem: uSuperView, attribute: .Leading, multiplier: 1, constant: 5),
					NSLayoutConstraint(item: self.titleLabel, attribute: .Trailing, relatedBy: .Equal, toItem: uSuperView, attribute: .Trailing, multiplier: 1, constant: -5)
				]
			)
		}
		
		if let uHeightConstraint = self.textHeightLayoutConstraint {
			self.addConstraint(uHeightConstraint)
		}
	}
	
	override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
		super.applyLayoutAttributes(layoutAttributes)
		
		if let attributes = layoutAttributes as? MultipleColumnLayoutAttributes {
			photoHeightLayoutConstraint?.constant = attributes.photoHeight
			textHeightLayoutConstraint?.constant = attributes.annotationHeight
		}
	}
}
