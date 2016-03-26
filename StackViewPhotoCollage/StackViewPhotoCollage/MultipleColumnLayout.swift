//
//  MultipleColumnLayout.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

// Inspired by http://www.raywenderlich.com/99146/video-tutorial-custom-collection-view-layouts-part-1-pinterest-basic-layout
protocol MultipleColumnLayoutDelegate: class {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class MultipleColumnLayoutAttributes: UICollectionViewLayoutAttributes {
	var annotationHeight: CGFloat = 0
    var photoHeight: CGFloat = 0
	
    override func copyWithZone(zone: NSZone) -> AnyObject {
		guard let copy = super.copyWithZone(zone) as? MultipleColumnLayoutAttributes else {
			fatalError()
		}
		copy.annotationHeight = annotationHeight
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
		guard let attributes = object as? MultipleColumnLayoutAttributes else {
			return false
		}
		if attributes.photoHeight == photoHeight && attributes.annotationHeight == annotationHeight {
			return super.isEqual(object)
		}
		return false
    }
}

class MultipleColumnLayout: UICollectionViewLayout {
	// MARK: Public API
    weak var delegate: MultipleColumnLayoutDelegate!
	var numberOfColumns = 1
	var cellPadding: CGFloat = 0
	
	// MARK: Layout Concerns
    private var cache = [MultipleColumnLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
			guard let collectionView = collectionView else {
				fatalError()
			}
            let insets = collectionView.contentInset
			let width = CGRectGetWidth(collectionView.bounds)
            return width - (insets.left + insets.right)
        }
    }
	
	convenience init(cellPadding: CGFloat, numberOfColumns: Int) {
		self.init()
		self.cellPadding = cellPadding
		self.numberOfColumns = numberOfColumns
	}
	
	// MARK: Public API
	
	func clearCache() {
		cache.removeAll()
	}

    override class func layoutAttributesClass() -> AnyClass {
        return MultipleColumnLayoutAttributes.self
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: width, height: contentHeight)
    }
	
	override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var layoutAttributes = [UICollectionViewLayoutAttributes]()
		for attributes in cache {
			if CGRectIntersectsRect(attributes.frame, rect) {
				layoutAttributes.append(attributes)
			}
		}
		return layoutAttributes
	}
	
	override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
		let attributes = MultipleColumnLayoutAttributes(forCellWithIndexPath: indexPath)
		let frame = CGRectInset(CGRect(x: -231, y: -231, width: 1, height: 1), cellPadding, cellPadding)
		attributes.frame = frame
		return attributes
	}
	
    override func prepareLayout() {
        if cache.isEmpty {
			guard let collectionView = collectionView else {
				return
			}
            let columnWidth = width / CGFloat(numberOfColumns)

            // Create arrays to hold x and y offsets of each
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append((CGFloat(column) * columnWidth))
            }
            
            var yOffsets = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            var column = 0
            for item in 0..<collectionView.numberOfItemsInSection(0) {
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                let width = columnWidth - (cellPadding * 2)
				
				// Calculate height
                let photoHeight = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath, withWidth: width)
                let annotationHeight = delegate.collectionView(collectionView, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                let height = cellPadding + photoHeight + annotationHeight + cellPadding

                let frame = CGRectInset(CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height), cellPadding, cellPadding)
				
                let attributes = MultipleColumnLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = frame
                attributes.photoHeight = photoHeight
				attributes.annotationHeight = annotationHeight
				
                cache.append(attributes)
				
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : ++column
            }
        }
    }
	
}
