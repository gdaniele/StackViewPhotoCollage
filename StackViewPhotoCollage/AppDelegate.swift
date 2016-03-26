//
//  AppDelegate.swift
//  StackViewPhotoCollage
//
//  Created by Giancarlo on 7/4/15.
//  Copyright (c) 2015 Giancarlo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    if self.window == nil {
      self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
    }

    if let uWindow = self.window {
      uWindow.rootViewController = UINavigationController(
        rootViewController: ImageFeedViewController())
      uWindow.makeKeyAndVisible()
    }

    return true
  }
}
