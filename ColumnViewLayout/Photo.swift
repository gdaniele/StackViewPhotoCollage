//
//  Photo.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

class Photo: NSObject {
    var caption: String
    var comment: String
    var image: UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }

    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        for i in 0..<10 {
            photos.append(Photo(caption: "asds", comment: "asdas", image: UIImage(named: "img")!))
        }
        return photos
    }
}