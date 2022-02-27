# SnapshotSafeView

Used for hide view from system screenshots and video recording, iOS 11 required.

##### What working:

- Autolayout
- Hide content inside protected view
- Provide gestures

##### In progress:

- Dinamicaly enable/disable hiding from system screenshots and videorecordings(disabling not working yet)
- Run from `init(coder:)`
- position inside content with autolayout(now frame based only)

<details><summary>Example code:</summary>
<p>
 
```swift
import UIKit
import SnapshotSafeView
import WrappingAnchor

final class ExampleSecureViewController: UIViewController {
    
    let simpleLable = UILabel()
    
    let securedBlueView = FromScreenshotProtectedView()
    lazy var secureBlueViewController = SnapshotSafeContentController(content: securedBlueView)
    
    let securedRedButton = FromScreenshotProtectedButton(type: .system)
    lazy var secureRedButtonController = SnapshotSafeContentController(content: securedRedButton)
    
    let nonSecuredGreenView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(secureBlueViewController.commonContainer)
        securedBlueView.backgroundColor = .blue
        
        view.addSubview(secureRedButtonController.commonContainer)
        securedRedButton.backgroundColor = .red
        
        view.addSubview(nonSecuredGreenView)
        nonSecuredGreenView.backgroundColor = .green
        
        secureBlueViewController.setupAsHiddenFromSnapshots()
        secureRedButtonController.setupAsHiddenFromSnapshots()
        
        layoutBlueView()
        layoutRedButton()
        layoutGreenView()
    }
    
}

// MARK: - Layout

private extension ExampleSecureViewController {
    
    func layoutBlueView() {
        secureBlueViewController.commonContainer
            // Simple wrapper on NSLayoutAnchor API
            .position
            .top(to: view, const: 30)
            .left(to: view, const: 30)
            .right(to: view, const: 30)
            .height(const: 200)
    }
    
    func layoutRedButton() {
        secureRedButtonController.commonContainer
            .position
            .top(to: securedBlueView, const: 30, dir: .bottom)
            .left(to: view, const: 30)
            .width(const: 115)
            .height(const: 115)
    }
    
    func layoutGreenView() {
        nonSecuredGreenView
            .position
            .top(to: securedBlueView, const: 30, dir: .bottom)
            .left(to: securedRedButton, const: 30, dir: .right)
            .right(to: view, const: 30)
            .height(to: securedRedButton)
    }

}
```

</p>
</details>

<details><summary>Example in work:</summary>
<p>
 
https://user-images.githubusercontent.com/44356536/156046148-59c7837d-c73d-4dec-b9d2-5c062b981b64.mov

</p>
</details>

