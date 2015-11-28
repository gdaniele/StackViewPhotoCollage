//
//  ImageFeedViewController.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit
import AVFoundation

// Inspired by http://www.raywenderlich.com/99146/video-tutorial-custom-collection-view-layouts-part-1-pinterest-basic-layout
class ImageFeedViewController: UICollectionViewController {
	// MARK:- Layout Concerns
    private let kCollectionViewTopInset: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
    private let kCollectionViewSideInset: CGFloat = 5
    private let kCollectionViewBottomInset: CGFloat = 10
    private var numberOfColumns: Int = 1
	private let reuseIdentifier = "PhotoCaptionCell"
	private let titleFont: UIFont = UIFont(name: "Avenir", size: 15)!
	
	// MARK:- Data
    private let photos = Photo.allPhotos()
	
	override init(collectionViewLayout layout: UICollectionViewLayout) {
		super.init(collectionViewLayout: layout)		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		setUI()
    }
	
	private func setUI() {
		// Set background
		if let patternImage = UIImage(named: "pattern") {
			view.backgroundColor = UIColor(patternImage: patternImage)
		}
		
		// Set title
		title = "Variable height layout"
		
		// Set generic styling
		collectionView?.backgroundColor = UIColor.clearColor()
		collectionView?.contentInset = UIEdgeInsetsMake(kCollectionViewTopInset, kCollectionViewSideInset, kCollectionViewBottomInset, kCollectionViewSideInset)
		let layout = collectionViewLayout as! MultipleColumnLayout
		
		layout.cellPadding = kCollectionViewSideInset
		layout.delegate = self
		layout.numberOfColumns = numberOfColumns
		
		// Register cell identifier
		self.collectionView?.registerClass(PhotoCaptionCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
	}
}

extension ImageFeedViewController {
	// MARK:- UICollectionViewDelegate
	
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
	
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! PhotoCaptionCell
        cell.image = photos[indexPath.item].image
		cell.title = photos[indexPath.item].caption
        cell.cornerRadius = 5
		cell.titleFont = self.titleFont
		
        return cell
    }
}

extension ImageFeedViewController: MultipleColumnLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        return AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect).height
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
		
		let rect = NSString(string: photos[indexPath.item].caption).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: self.titleFont], context: nil)
		return ceil(rect.height)
    }
}
