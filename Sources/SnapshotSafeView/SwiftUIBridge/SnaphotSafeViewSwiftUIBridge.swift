//
//  SnaphotSafeViewSwiftUIBridge.swift
//  
//
//  Created by Илья Князьков on 10.09.2022.
//


#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13, *)
struct SnaphotSafeViewSwiftUIBridge<Content: View>: SnaphotSafeViewSwiftUIBridgeProtocol {

    // MARK: - Private Properties

    private let content: () -> Content

    // MARK: - Initialization

    init(content: @autoclosure @escaping () -> Content) {
        self.content = content
    }

    // MARK: - SnaphotSafeViewSwiftUIBridgeProtocol

    typealias ProtectedView = ProtectedViewRepresentable

    func hiddenFromSystemSnaphot() -> ProtectedView {
        let hostingController = UIHostingController(rootView: content())
        return ProtectedViewRepresentable(content: hostingController.view)
    }

}

// MARK: - Nested Types

@available(iOS 13, *)
extension SnaphotSafeViewSwiftUIBridge {

    struct ProtectedViewRepresentable: UIViewRepresentable {

        // MARK: - Internal Properties

        let viewContent: UIView

        // MARK: - Initialization

        init(content: UIView) {
            self.viewContent = content
        }

        // MARK: - UIViewRepresentable

        func makeUIView(context: Context) -> UIView {
            let snapshotController = ScreenshotProtectController(content: viewContent)
            snapshotController.setupContentAsHiddenInScreenshotMode()
            snapshotController.container.setContentHuggingPriority(.required, for: .vertical)
            snapshotController.container.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
            return snapshotController.container
        }

        func updateUIView(_ uiView: UIView, context: Context) { }
        
    }

}
#endif
