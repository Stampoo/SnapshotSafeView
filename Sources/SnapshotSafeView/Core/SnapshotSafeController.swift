//
//  SnapshotSafeController.swift
//  
//
//  Created by Князьков Илья on 27.02.2022.
//

import UIKit

open class SnapshotSafeContentController<ProtectedContent: UIView>: SnapshotSafeProtocol {
    
    // MARK: - Private properties
    
    private lazy var secureContainer: SecureContainerProtocol = SecureContainer(securedContent: content)
    
    // MARK: - Internal properties
    
    var content: ProtectedContent
    
    // MARK: - Initialization
    
    public init(content: ProtectedContent) {
        self.content = content
    }
    
    // MARK: - Public methods
    
    public func setContent(content: ProtectedContent) {
        self.content = content
    }
    
    public func setupAsHiddenFromSnapshots() {
        secureContainer.enableProtect()
        drawAfterAddingNewContent()
    }

    public func setupAsVisibleInSnapshots() {
        secureContainer.disableProtect()
    }
    
}

// MARK: - Private methods

private extension SnapshotSafeContentController {
    
    func drawAfterAddingNewContent() {
        secureContainer.protectedView.center = content.center
        content.layer.position = .zero
        content.layer.frame.origin = .zero
    }
    
}
