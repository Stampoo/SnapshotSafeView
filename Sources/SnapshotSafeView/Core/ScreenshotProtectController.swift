//
//  ScreenshotProtectController.swift
//  
//
//  Created by Князьков Илья on 02.03.2022.
//

import class UIKit.UIView

/**
Controller on hide from screenshot and screen recording states of content
 
 Example usage:
```
 final class ExampleSecureViewController: UIViewController {
     
     let hiddenFromScreenshotButtonController = ScreenshotProtectController(content: UIButton())

     override func viewDidLoad() {
         super.viewDidLoad()
         hiddenFromScreenshotButtonController.content.backgroundColor = .red // UI customization apply to content
         hiddenFromScreenshotButtonController.content.layer.cornerRadius = 16
         
         view.addSubview(hiddenFromScreenshotButtonController.container)
         hiddenFromScreenshotButtonController.container // Layout control apply to container
             .position
             .pin(to: view.safeAreaLayoutGuide, const: 65)
         
         hiddenFromScreenshotButtonController.setupContentAsHiddenInScreenshotMode() // apply hidden mode
         // content will be removed from system screenshots and screen recording
     }
     
 }

```
*/
open class ScreenshotProtectController<Content: UIView>: ScreenshotProtectControllerProtocol {
    
    public typealias ProtectiveContainer = ScreenshotInvincibleContainerProtocol
    
    /// - View, which will be hidden on screenshots and screen recording
    /// - All operation with UI customization need perform at content
    public var content: Content
    
    /// - Container view, all operation with layout need perform at container
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
