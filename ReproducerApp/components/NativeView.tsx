import React from 'react';
import NativeViewNativeComponent from './spec/NativeViewNativeComponent';
import type {ViewProps} from 'react-native';
import LayoutAdjustmentContext from '../contexts/LayoutAdjustmentContext';

function NativeView(props: ViewProps) {
  const [insetTop, setInsetTop] = React.useState({
    insetTop: 0,
  });

  return (
    <NativeViewNativeComponent
      {...props}
      onNativeLayout={event => {
        console.debug(
          `Received layout adjustment from native: ${event.nativeEvent}`,
        );
        setInsetTop({insetTop: event.nativeEvent.insetTop});
      }}>
      <LayoutAdjustmentContext.Provider value={insetTop}>
        {props.children}
      </LayoutAdjustmentContext.Provider>
    </NativeViewNativeComponent>
  );
}

export default NativeView;
