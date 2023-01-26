//
//  MyCustomViewManager.swift
//  AwesomeProject
//
//  Created by Carlos Thurber on 12/4/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import React
import UIKit
import Foundation

@objc (RCTMyCustomViewManager)
class MyCustomViewManager: RCTViewManager {

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
    return MyCustomView()
  }

}
