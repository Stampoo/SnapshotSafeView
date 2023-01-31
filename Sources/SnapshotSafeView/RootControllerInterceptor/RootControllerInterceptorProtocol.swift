//
//  RootControllerInterceptorProtocol.swift
//  
//
//  Created by Илья Князьков on 30.01.2023.
//

import UIKit
import Foundation

/// - Note: Should be retained, because the desired controller may not appear immediately
public protocol RootControllerInterceptorProtocol {

    /// Method waiting desired controller in ``UIWindow.rootViewController`` and will try to switch him at `view`
    ///
    /// - Parameters:
    ///   - window: ``UIWindow``
    ///   - view: ``UIView`` for switching
    ///   - rootExpectation: Swappable view ``RootControllerExpectation``
    func performSwitchView(
        in window: UIWindow,
        expectedContainer view: UIView,
        waitWhenRootBecome rootExpectation: RootControllerExpectation
    )

}
