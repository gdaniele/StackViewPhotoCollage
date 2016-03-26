//
//  Photo.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

let comments = [
  "Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit" +
    "Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit" +
    "Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit" +
    "Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit" +
    "Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit" +
    "Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit" +
                "elit, sed do eiusmod tempor incididunt ut labore",
                "et dolore magna aliqua. Ut enim ad minim veniam",
                "quis nostrud exercitation ullamco laboris nisi ut",
                "aliquip ex ea commodo consequat. Duis aute irure",
                "dolor in reprehenderit in voluptate velit esse",
                "cillum dolore eu fugiat nulla pariatur. Excepteur",
                "sint occaecat cupidatat non proident, sunt in culpa",
                "qui officia deserunt mollit anim id est laborum"
]

// Inspired by: RayWenderlich.com pinterest-basic-layout
class Photo: NSObject {
  var caption: String
  var image: UIImage

  init(caption: String, image: UIImage) {
    self.caption = caption
    self.image = image
  }

  class func allPhotos() -> [Photo] {
    var photos = [Photo]()
    for i in 1..<10 {
      let caption = comments[Int(arc4random_uniform(UInt32(comments.count) - UInt32(1)))]
      photos.append(Photo(caption: caption, image: UIImage(named: "otter-\(i).jpg")!))
    }
    return photos
  }
}
