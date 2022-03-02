//
//  ScreenshotInvincibleContainerProtocol.swift.swift
//  
//
//  Created by Князьков Илья on 02.03.2022.
//

import Foundation
import UIKit

public protocol ScreenshotInvincibleContainerProtocol: UIView {

    func eraseOldAndAddnewContent(_ newContent: UIView)
    func setupContanerAsHideContentInScreenshots()
    func setupContanerAsDisplayContentInScreenshots()
    
}
