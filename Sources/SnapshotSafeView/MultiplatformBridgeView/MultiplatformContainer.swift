//
//  MultiplatformContainer.swift
//  
//
//  Created by Илья Князьков on 21.02.2023.
//

import UIKit

final class MultiplatformContainer: ScreenshotInvincibleContainer {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return content.hitTest(point, with: event)
    }

}
