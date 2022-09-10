//
//  View+SnaphotSafeViewSwiftUIBridge.swift
//  
//
//  Created by Илья Князьков on 10.09.2022.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, *)
public extension View {

    // MARK: - Private Properties

    private var snapshotBridge: SnaphotSafeViewSwiftUIBridge<Self> {
        SnaphotSafeViewSwiftUIBridge(content: self)
    }

    // MARK: - Public Methods

    /// Wrapped `View` in`ScreenshotProtectController`, will be hidden from system screenshots, during ``condition`` is true
    /// - Parameter condition: During condittion is true, return wrapped `View`
    /// - Returns: Wrapped `View` or just `Self`, depend at condition
    @ViewBuilder
    func hiddenFromSystemSnaphot(when condition: @autoclosure () -> Bool) -> some View {
        if condition() {
            snapshotBridge.hiddenFromSystemSnaphot()
        } else {
            self
        }
    }

    /// Wrapped `View` in`ScreenshotProtectController` with default padding, will be hidden from system screenshots, during ``condition`` is true
    /// - Parameter condition: During condittion is true, return wrapped `View`
    /// - Returns: Wrapped `View` or just `Self`, depend at condition
    @ViewBuilder
    func hiddenFromSystemSnaphotWithDefaultPadding(when condition: @autoclosure () -> Bool) -> some View {
        if condition() {
            snapshotBridge.hiddenFromSystemSnaphot()
                .padding(.vertical)
        } else {
            self
        }
    }

}
#endif
