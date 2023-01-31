## Flutter
>**Warning**: Experimental feature

1. In `Xcode`, go to `File` → `Add Packages...` OR select your project in the `Project Editor`, go to the `Package Dependencies` tab, and press the `+`.

![](/Resources/AddingViaSPM.png)

2. Enter a `Package URL` (e.g. a `GitHub` repository `URL`) or a search term in the search field in the upper right.

![](/Resources/AddingViaSPM1.png)

3. Select the package you want to add. Select a `Dependency Rule`. In most cases, you probably want to set this to `Up to Next Major Version`.
Click `Add Package`.

4. Instantiate  `SnapshotSafeViewFlutterInterceptor` and call `performSwitchView` for intercepting root view:

```swift
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    private let snapshotSafeViewInterceptor = SnapshotSafeViewFlutterInterceptor()

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        snapshotSafeViewInterceptor.performSwitchView(in: window)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

}
```

## Example:

<p>
<img src=/Resources/flutterExample.mov width=200>
</p>