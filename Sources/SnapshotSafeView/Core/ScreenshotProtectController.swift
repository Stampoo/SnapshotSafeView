//
//  ScreenshotProtectController.swift
//  
//
//  Created by Князьков Илья on 02.03.2022.
//

import class UIKit.UIView

open class ScreenshotProtectController<Content: UIView>: ScreenshotProtectControllerProtocol {
    
    public typealias ProtectiveContainer = ScreenshotInvincibleContainerProtocol
    
    public var content: Content
    public lazy var container: ProtectiveContainer = ScreenshotInvincibleContainer(content: content)
    
    public init(content: Content) {
        self.content = content
    }
    
    public func eraseOldAndAddnewContent(_ newContent: Content) {
        container.eraseOldAndAddnewContent(newContent)
    }
    
    public func setupContentAsHiddenInScreenshotMode() {
        container.setupContanerAsHideContentInScreenshots()
    }
    
    public func setupContentAsDisplayedInScreenshotMode() {
        container.setupContanerAsDisplayContentInScreenshots()
    }

}
