//
//  Photo.swift
//  ColumnViewLayout
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

let comments = ["Lorem ipsum dolor sit amet", "consectetur adipiscing elit", "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", "Ut enim ad minim veniam", "quis nostrud exercitation ullamco", "laboris nisi ut aliquip ex ea commodo", "consequat"]

class Photo: NSObject {
    var caption: String
    var image: UIImage
    
    init(caption: String, image: UIImage) {
        self.caption = caption
        self.image = image
    }

    class func allPhotos() -> [Photo] {
        var photos = [Photo]()
        for i in 1..<14 {
            let caption = comments[Int(arc4random_uniform(UInt32(comments.count) - UInt32(1)))]
            photos.append(Photo(caption: caption, image: UIImage(named: "example-\(i).jpg")!))
        }
        return photos
    }
}