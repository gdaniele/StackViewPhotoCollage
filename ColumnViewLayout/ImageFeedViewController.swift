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

class ImageFeedViewController: UICollectionViewController {
    var colors: [UIColor] {
        get {
            var colors = [UIColor]()
            let palette = [UIColor.greenColor(), UIColor.yellowColor(), UIColor.darkGrayColor(), UIColor.purpleColor(), UIColor.brownColor(), UIColor.blueColor()]
            var paletteIndex = 0
            for i in 0..<photos.count {
                colors.append(palette[paletteIndex])
                paletteIndex = paletteIndex == (palette.count - 1) ? 0 : ++paletteIndex
            }
            return colors
        }
    }
    var photos = Photo.allPhotos()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView!.backgroundColor = UIColor.clearColor()
        let size = CGRectGetWidth(collectionView!.bounds) / 2
        let layout = collectionViewLayout as! PinterestLayout
        layout.topMargin = UIApplication.sharedApplication().statusBarFrame.height
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
        cell.contentView.backgroundColor = colors[indexPath.item]
        cell.cornerRadius = kItemCornerRadius
        return cell
    }
    
}

extension ImageFeedViewController: PinterestLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat((arc4random_uniform(4) + 1) * 100)
    }
}