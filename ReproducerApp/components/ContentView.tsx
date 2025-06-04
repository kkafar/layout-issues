import React from 'react';
import {StyleSheet, type ViewProps} from 'react-native';
import {View} from 'react-native';

export type ContentViewProps = ViewProps;

function Rect(props: {size: number}) {
  return (
    <View
      style={{
        backgroundColor: 'darkorange',
        width: props.size,
        height: props.size,
      }}
    />
  );
}

export function ContentView(props: ContentViewProps) {
  return (
    <View
      collapsable={false}
      {...props}
      style={[
        props.style,
        styles.container,
        styles.centered,
        {backgroundColor: 'lightblue'},
      ]}>
      <Rect size={128} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  centered: {
    justifyContent: 'center',
    alignItems: 'center',
  },
});
