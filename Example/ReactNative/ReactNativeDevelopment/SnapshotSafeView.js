// @flow
import React from 'react';
import { requireNativeComponent } from 'react-native';

const RCTSnapshotSafeView = requireNativeComponent('RCTReactNativeBridgeSnapshotSafeView', SnapshotSafeView, {});

class SnapshotSafeView {

  render() {
    return <RCTSnapshotSafeView/>
  }

}

export default SnapshotSafeView;
