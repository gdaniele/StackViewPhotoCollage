//
//  PhotoCaptionCell.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

class PhotoCaptionCell: UICollectionViewCell {
  // MARK: Layout Concerns
  private var didSetUpView: Bool = false
  private var calculatedTextHeight: CGFloat? {
    didSet {
      textHeightLayoutConstraint?.constant = calculatedTextHeight!
    }
  }

  // MARK: Constraints
  private var textHeightLayoutConstraint: NSLayoutConstraint?
  private var stackViewConstraints: [NSLayoutConstraint]! = nil
  private var titleLabelToCaptionViewConstraints: [NSLayoutConstraint]! = nil

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
    label.font = UIFont.systemFontOfSize(14)
    label.lineBreakMode = .ByWordWrapping
    label.numberOfLines = 0
    label.textAlignment = .Left
    label.translatesAutoresizingMaskIntoConstraints = false

    return label
  }()

  // MARK: Public init

  override init(frame: CGRect) {
    super.init(frame: CGRect.zero)

    self.stackViewConstraints = [
      NSLayoutConstraint(
        item: mainView,
        attribute: .CenterX,
        relatedBy: .Equal,
        toItem: self,
        attribute: .CenterX,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: mainView,
        attribute: .CenterY,
        relatedBy: .Equal,
        toItem: self,
        attribute: .CenterY,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: mainView,
        attribute: .Width,
        relatedBy: .Equal,
        toItem: self,
        attribute: .Width,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: mainView,
        attribute: .Height,
        relatedBy: .Equal,
        toItem: self,
        attribute: .Height,
        multiplier: 1,
        constant: 0)
    ]

    self.titleLabelToCaptionViewConstraints = [
      NSLayoutConstraint(
        item: titleLabel,
        attribute: .Leading,
        relatedBy: .Equal,
        toItem: captionView,
        attribute: .Leading,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: titleLabel,
        attribute: .Trailing,
        relatedBy: .Equal,
        toItem: captionView,
        attribute: .Trailing,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(
        item: titleLabel,
        attribute: .Top,
        relatedBy: .Equal,
        toItem: captionView,
        attribute: .Top,
        multiplier: 1,
        constant: 0),
      NSLayoutConstraint(item: titleLabel,
        attribute: .Bottom,
        relatedBy: .Equal,
        toItem: captionView,
        attribute: .Bottom,
        multiplier: 1,
        constant: 0)
    ]
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setUpWithImage(image: UIImage, title: String, style: PhotoCaptionCellStyle) {
    imageView.image = image
    titleLabel.text = title

    // Keep track of set up status, because we're reusing cells
    guard didSetUpView else {
      setUpView(style)
      return
    }

    applyStyle(style)
  }

  override func updateConstraints() {
    super.updateConstraints()
  }

  override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
    super.applyLayoutAttributes(layoutAttributes)
    guard let attributes = layoutAttributes as? MultipleColumnLayoutAttributes else {
      fatalError("Unexpected attributes class")
    }
    calculatedTextHeight = attributes.annotationHeight

    if didSetUpView {
      removeConstraints(stackViewConstraints)
      addConstraints(stackViewConstraints)
    }
  }

  // MARK: Private view

  private func applyStyle(style: PhotoCaptionCellStyle) {
    backgroundColor = style.backgroundColor
    cornerRadius = style.cornerRadius
    titleLabel.font = style.titleFont

    // Update constraint constants
    titleLabelToCaptionViewConstraints[0].constant = style.titleInsets.top
    titleLabelToCaptionViewConstraints[1].constant = -style.titleInsets.bottom
    titleLabelToCaptionViewConstraints[2].constant = style.titleInsets.left
    titleLabelToCaptionViewConstraints[3].constant = -style.titleInsets.right
  }

  private func setUpView(style: PhotoCaptionCellStyle) {
    // Add views to contentView
    addSubview(mainView)

    // Constraint stackView to cell's edges
    addConstraints(stackViewConstraints)

    // Add default padding around title label
    addConstraints(titleLabelToCaptionViewConstraints)

    /// Sets text height constraint
    textHeightLayoutConstraint = NSLayoutConstraint(item: captionView,
                                                    attribute: .Height,
                                                    relatedBy: .Equal,
                                                    toItem: nil,
                                                    attribute: .NotAnAttribute,
                                                    multiplier: 1,
                                                    constant: calculatedTextHeight ?? 30)
    if let textHeightLayoutConstraint = textHeightLayoutConstraint {
      addConstraint(textHeightLayoutConstraint)
    }

    // Apply style
    applyStyle(style)

    didSetUpView = true
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
