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
	// MARK: Style
	private var style: PhotoCaptionCellStyle! = nil
	
	// MARK: Layout Concerns
	private var photoHeightLayoutConstraint: NSLayoutConstraint?
	private var textHeightLayoutConstraint: NSLayoutConstraint?
	private var calculatedPhotoHeight: CGFloat? {
		didSet {
			photoHeightLayoutConstraint?.constant = calculatedPhotoHeight!
		}
	}
	private var calculatedTextHeight: CGFloat? {
		didSet {
			textHeightLayoutConstraint?.constant = calculatedTextHeight!
		}
	}

	// MARK: Lazy UI
	private lazy var captionView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(self.titleLabel)
		
		return view
	}()
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .ScaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		return imageView
	}()
	private lazy var mainView: UIView = {
		let view = UIStackView(arrangedSubviews: [self.imageView, self.captionView])
		
		view.axis = UILayoutConstraintAxis.Vertical
		view.distribution = UIStackViewDistribution.EqualSpacing
		view.alignment = UIStackViewAlignment.Fill
		view.layoutMarginsRelativeArrangement = true
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = self.style.titleFont
		label.lineBreakMode = .ByWordWrapping
		label.numberOfLines = 0
		label.textAlignment = .Left
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	// MARK: Public init
	
	// Required initializer
	func setUpWithImage(image: UIImage, title: String, style: PhotoCaptionCellStyle) {
		self.style = style

		imageView.image = image
		titleLabel.text = title
		
		setUpUI()
	}
	
	override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
		super.applyLayoutAttributes(layoutAttributes)
		
		guard let attributes = layoutAttributes as? MultipleColumnLayoutAttributes else {
			fatalError("Unexpected attributes class")
		}
		
		calculatedPhotoHeight = attributes.photoHeight
		calculatedTextHeight = attributes.annotationHeight
	}
	
	// MARK: Private view
	
	private func setUpUI() {
		backgroundColor = style.backgroundColor
		cornerRadius = style.cornerRadius
		
		// Add views to contentView
		addSubview(mainView)
		
		// Constraint stackView to cell's edges
		if let uSuperView = mainView.superview {
			addConstraints(
				[
					NSLayoutConstraint(item: mainView, attribute: .Top, relatedBy: .Equal, toItem: uSuperView, attribute: .Top, multiplier: 1, constant: 0),
					NSLayoutConstraint(item: mainView, attribute: .Bottom, relatedBy: .Equal, toItem: uSuperView, attribute: .Bottom, multiplier: 1, constant: 0),
					NSLayoutConstraint(item: mainView, attribute: .Leading, relatedBy: .Equal, toItem: uSuperView, attribute: .Leading, multiplier: 1, constant: 0),
					NSLayoutConstraint(item: mainView, attribute: .Trailing, relatedBy: .Equal, toItem: uSuperView, attribute: .Trailing, multiplier: 1, constant: 0)
				]
			)
		}
		
		// Add default padding around title label
		if let uSuperView = titleLabel.superview {
			addConstraints(
				[
					NSLayoutConstraint(item: titleLabel, attribute: .Leading, relatedBy: .Equal, toItem: uSuperView, attribute: .Leading, multiplier: 1, constant: style.titleInsets.left),
					NSLayoutConstraint(item: titleLabel, attribute: .Trailing, relatedBy: .Equal, toItem: uSuperView, attribute: .Trailing, multiplier: 1, constant: -style.titleInsets.right),
					NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: uSuperView, attribute: .Top, multiplier: 1, constant: style.titleInsets.top),
					NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: uSuperView, attribute: .Bottom, multiplier: 1, constant: -style.titleInsets.bottom)
				]
			)
		}
		
		// Set dynamic constraints
		guard photoHeightLayoutConstraint == nil && textHeightLayoutConstraint == nil else {
			print("Dynamic constraints are already set. Move on")
			return
		}

		/// Sets text height constraint
		textHeightLayoutConstraint = NSLayoutConstraint(item: captionView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: calculatedTextHeight ?? 30)
		if let textHeightLayoutConstraint = textHeightLayoutConstraint {
			addConstraint(textHeightLayoutConstraint)
			print("Text - Set to \(calculatedTextHeight ?? 30)")
		}
	}
}

// MARK: Style

protocol PhotoCaptionCellStyle {
	var backgroundColor: UIColor { get }
	var cornerRadius: CGFloat { get }
	var titleFont: UIFont { get }
	var titleInsets: UIEdgeInsets { get }
}

struct BeigeRoundedPhotoCaptionCellStyle: PhotoCaptionCellStyle {
	let backgroundColor = UIColor.greenColor().colorWithAlphaComponent(0.2)
	let cornerRadius: CGFloat = 5
	let titleFont = UIFont(name: "Avenir", size: 12)!
	let titleInsets = UIEdgeInsetsMake(5, 5, 5, 5)
}
