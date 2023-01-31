//
//  SnapshotSafeViewFlutterInterceptor.swift
//  
//
//  Created by Илья Князьков on 30.01.2023.
//

import UIKit

/** - Note: Should be retained, because the desired controller may not appear immediately

 **Usage:**
 ```swift
 import UIKit
 import Flutter
 import SnapshotSafeView

 @UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {

     private let snapshotSafeViewInterceptor = SnapshotSafeViewFlutterInterceptor()

     override func application(
         _ application: UIApplication,
         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
     ) -> Bool {
         GeneratedPluginRegistrant.register(with: self)
         snapshotSafeViewInterceptor.performSwitchView(in: window) /// Wait for ``FlutterViewController``
         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
     }

 }
 ```
 */
public final class SnapshotSafeViewFlutterInterceptor {

    // MARK: - Private Properties

    private let multiplatformSnapshotSafeView: UIView
    private let rootControllerInterceptor: RootControllerInterceptorProtocol

    // MARK: - Initialization

    public init() {
        self.multiplatformSnapshotSafeView = MultiplatformBridgeView()
        self.rootControllerInterceptor = RootControllerInterceptor()
    }

    // MARK: - Public Methods

    public func performSwitchView(in window: UIWindow) {
        rootControllerInterceptor.performSwitchView(
            in: window,
            expectedContainer: multiplatformSnapshotSafeView,
            waitWhenRootBecome: FlutterExpectation()
        )
    }

}
