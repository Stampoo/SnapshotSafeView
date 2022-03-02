//
//  ScreenshotProtectControllerProtocol.swift
//  
//
//  Created by Князьков Илья on 02.03.2022.
//

import UIKit

public protocol ScreenshotProtectControllerProtocol {
    
    associatedtype Content
    associatedtype ProtectiveContainer
    
    var content: Content { get set }
    var container: ProtectiveContainer { get set }
    
    func eraseOldAndAddnewContent(_ newContent: Content)
    func setupContentAsHiddenInScreenshotMode()
    func setupContentAsDisplayedInScreenshotMode()
    
}

extension ScreenshotProtectControllerProtocol where Self: ScreenshotInvincibleContainerProtocol {
    
    func setupContentAsHiddenInScreenshotMode() {
        setupContentAsDisplayedInScreenshotMode()
    }
    
    func setupContentAsDisplayedInScreenshotMode() {
        setupContentAsDisplayedInScreenshotMode()
    }
    
}


