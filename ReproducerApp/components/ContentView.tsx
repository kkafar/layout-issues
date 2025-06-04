import React from 'react';
import {StyleSheet, type ViewProps} from 'react-native';
import {View} from 'react-native';
import LayoutAdjustmentContext from '../contexts/LayoutAdjustmentContext';

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
  const {insetTop} = React.useContext(LayoutAdjustmentContext);

  return (
    <View
      {...props}
      style={[
        props.style,
        styles.container,
        styles.centered,
        {backgroundColor: 'lightblue'},
        {marginTop: insetTop},
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
