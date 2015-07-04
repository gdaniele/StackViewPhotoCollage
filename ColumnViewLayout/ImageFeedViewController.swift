//
//  ImageFeedViewController.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

class ImageFeedViewController: UICollectionViewController {
    var colors: [UIColor] {
        get {
            var colors = [UIColor]()
            let palette = [UIColor.greenColor(), UIColor.yellowColor(), UIColor.whiteColor(), UIColor.purpleColor(), UIColor.blackColor(), UIColor.blueColor()]
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
    }

}

extension ImageFeedViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
}
