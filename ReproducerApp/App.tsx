import type React from 'react';
import {StyleSheet, View} from 'react-native';
import NativeView from './components/NativeView';
import {ContentView} from './components/ContentView';

function App(): React.JSX.Element {
  return (
    <View style={[styles.container]}>
      <NativeView style={[styles.container, {backgroundColor: 'lightsalmon'}]}>
        <ContentView />
      </NativeView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});

export default App;
