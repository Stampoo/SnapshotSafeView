# SnapshotSafeView

Used for hide view from system screenshots and video recording, iOS 11 required.

##### What working:

- Autolayout
- Position inside content with autolayout
- Hide content inside protected view
- Dinamicaly enable/disable hiding
- Provide gestures


##### In progress:

- ~~Dinamicaly enable/disable hiding from system screenshots and videorecordings(disabling not working yet)~~ Done
- Run from `init(coder:)`
- ~~position inside content with autolayout(now frame based only)~~ Done
- Improve API

<details><summary>Example code:</summary>
<p>
 
```swift
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

</p>
</details>

<details><summary>Example in work:</summary>
<p>


https://user-images.githubusercontent.com/44356536/156410609-bf9e2373-0fe9-4ace-ae58-73c2175d7b27.mov


</p>
</details>

