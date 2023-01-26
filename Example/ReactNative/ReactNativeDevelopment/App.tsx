/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 */

 // @flow
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