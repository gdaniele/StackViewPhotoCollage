//
//  ImageFeedViewController.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

public let kItemCornerRadius: CGFloat = 5
public let kNumberOfColumns = 2
public let kSideMargin: CGFloat = 4

class ImageFeedViewController: UICollectionViewController {
    let kCollectionViewTopInset: CGFloat = UIApplication.sharedApplication().statusBarFrame.height
    let kCollectionViewSideInset: CGFloat = 5
    let kCollectionViewBottomInset: CGFloat = 10
    
    var photos = Photo.allPhotos()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.contentInset = UIEdgeInsetsMake(kCollectionViewTopInset, kCollectionViewSideInset, kCollectionViewBottomInset, kCollectionViewSideInset)
        let size = CGRectGetWidth(collectionView!.bounds) / 2
        let layout = collectionViewLayout as! PinterestLayout
        layout.cellPadding = kCollectionViewSideInset
        layout.delegate = self
        layout.numberOfColumns = kNumberOfColumns
    }

}

extension ImageFeedViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AnnotatedPhotoCell", forIndexPath: indexPath) as! UICollectionViewCell
        cell.cornerRadius = kItemCornerRadius
        return cell
    }
    
}

extension ImageFeedViewController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat((arc4random_uniform(4) + 1) * 100)
    }
}