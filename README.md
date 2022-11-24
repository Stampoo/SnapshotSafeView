# SnapshotSafeView

Used for hide view from system screenshots and video recording.

## Requirements

- Xcode version: `12.5.1` or higher
- Deployment target `iOS v12` or higher
- Swift toolchain `5.5`

### What working:

- Autolayout
- Position inside content with autolayout
- Hide content inside protected view
- Dinamicaly enable/disable hiding
- Provide gestures
- SwiftUI


### In progress:

- ~~Dinamicaly enable/disable hiding from system screenshots and videorecordings(disabling not working yet)~~ Done
- Run from `init(coder:)`
- ~~position inside content with autolayout(now frame based only)~~ Done
- ~~Support SwiftUI~~
- Improve API

## How usage:
### `SwiftUI`
```swift
import SwiftUI
import SnapshotSafeView

struct ContentView: View {

    @State var isNeedHiddenContentFromScreenshots: Bool = false

    var body: some View {
        Text("Hello, world!")
            .padding()
            .background(Color.brown)
        Text("Hello, world!")
            .padding()
            .background(Color.blue)
            .hiddenFromSystemSnaphotWithDefaultPadding(when: isNeedHiddenContentFromScreenshots)
        Text("Hello, world!")
            .padding()
            .background(Color.orange)
        Button("Toggle hide from screenshots condition") {
            isNeedHiddenContentFromScreenshots.toggle()
        }

        Spacer()

        Text(isNeedHiddenContentFromScreenshots ? "Will be hidden from snapshots" : "Will be appear in snapshots")
            .padding()
            .background(isNeedHiddenContentFromScreenshots ? Color.green : Color.red)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

### Example:

<p>
<img src="https://user-images.githubusercontent.com/44356536/189480958-191b7fa3-e6b2-4ac8-b222-00a38e21311c.mov" width=200/>
</p>


### `UIKit`
```swift
final class ExampleViewController: UIViewController {

    var hiddenFromScreenshotButtonController = ScreenshotProtectController(content: UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        hiddenFromScreenshotButtonController.content.backgroundColor = .systemRed // UI customization apply to content
        hiddenFromScreenshotButtonController.content.layer.cornerRadius = 20

        view.addSubview(hiddenFromScreenshotButtonController.container)
        hiddenFromScreenshotButtonController.container.translatesAutoresizingMaskIntoConstraints = false

        [
            hiddenFromScreenshotButtonController.container.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            hiddenFromScreenshotButtonController.container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65),
            hiddenFromScreenshotButtonController.container.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -65),
            hiddenFromScreenshotButtonController.container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65)
        ].forEach { $0.isActive = true } // Layout control apply to container

        hiddenFromScreenshotButtonController.setupContentAsHiddenInScreenshotMode() // apply hidden mode
        // content will be removed from system screenshots and screen recording
    }

}
```

### Example:

<p>
<img src="https://user-images.githubusercontent.com/44356536/156410609-bf9e2373-0fe9-4ace-ae58-73c2175d7b27.mov" width=200/>
</p>
