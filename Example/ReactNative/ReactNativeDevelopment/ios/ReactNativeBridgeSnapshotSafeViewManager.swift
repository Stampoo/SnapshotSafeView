//
//  ReactNativeBridgeManager.swift
//  ReactNativeDevelopment
//
//  Created by Илья Князьков on 19.01.2023.
//

#if canImport(React)
import React

@objc (RCTReactNativeBridgeSnapshotSafeViewManager)
class ReactNativeBridgeSnapshotSafeViewManager: RCTViewManager {

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
    let view = ReactNativeBridgeSnapshotSafeView()
    return view
  }

}
#endif
