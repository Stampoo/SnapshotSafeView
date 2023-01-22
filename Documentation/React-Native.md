## React-Native

1. In `Xcode`, go to `File` → `Add Packages...` OR select your project in the `Project Editor`, go to the `Package Dependencies` tab, and press the `+`.

![](/Resources/AddingViaSPM.png)

2. Enter a `Package URL` (e.g. a `GitHub` repository `URL`) or a search term in the search field in the upper right.

![](/Resources/AddingViaSPM1.png)

3. Select the package you want to add. Select a `Dependency Rule`. In most cases, you probably want to set this to `Up to Next Major Version`.
Click `Add Package`.

4. Add three files for bridging package to `React-Native`.

![](/Resources/AddingFiles.png)

for `Swift` files:
![](/Resources/AddingFiles1.png)

for `Obj-c` files:
![](/Resources/AddingFiles2.png)

`Bridge`:
```swift
import UIKit
import SnapshotSafeView

final class ReactNativeBridgeSnapshotSafeView: MultiplatformBridgeView { }
```

`Obj-c bridge`:
```objc
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(RCTReactNativeBridgeSnapshotSafeViewManager, RCTViewManager)
@end
```

`React-native fabric`:
```swift
#if canImport(React)
import React

@objc (RCTReactNativeBridgeSnapshotSafeViewManager)
class ReactNativeBridgeSnapshotSafeViewManager: RCTViewManager {

  override static func requiresMainQueueSetup() -> Bool {
    return true
  }

  override func view() -> UIView! {
    let view = ReactNativeBridgeSnapshotSafeView()
    return view
  }

}
#endif
```

5. After build you can use the view in `React-Native`

```javascript
import React, { Component } from 'react';
import { StyleSheet, View, Text, requireNativeComponent } from 'react-native';

const SnapshotSafeView = requireNativeComponent('RCTReactNativeBridgeSnapshotSafeView');

const ViewBoxesWithColorAndText = () => {
  return (
    <SnapshotSafeView>
    <View
      style={{
        flexDirection: 'row',
        height: 100,
        padding: 20,
      }}>
      <View style={{backgroundColor: 'blue', flex: 0.3}} />
      <View style={{backgroundColor: 'red', flex: 0.5}} />
      <Text>Hello World!</Text>
    </View>
    </SnapshotSafeView>
  );
};

export default ViewBoxesWithColorAndText;
```