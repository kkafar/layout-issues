import type React from 'react';
import {StyleSheet, View} from 'react-native';
import NativeView from './components/NativeView';
import {ContentView} from './components/ContentView';
import SheetView from './components/SheetView';

function App(): React.JSX.Element {
  return (
    <View style={[styles.container]}>
      <NativeView style={[styles.container, {backgroundColor: 'lightsalmon'}]}>
        <SheetView>
          <ContentView />
        </SheetView>
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
