import React from 'react';
import SheetViewNativeComponent, {
  type NativeLayoutEvent,
} from './spec/SheetViewNativeComponent';
import type {ViewProps} from 'react-native';

function SheetView(props: ViewProps) {
  const [nativeLayout, setNativeLayout] = React.useState<NativeLayoutEvent>({
    origin: {x: 0, y: 0},
    size: {width: 0, height: 0},
  });

  const {size} = nativeLayout;

  return (
    <SheetViewNativeComponent
      collapsable={false}
      collapsableChildren={false}
      {...props}
      style={{
        width: size.width !== 0 ? size.width : undefined,
        height: size.height !== 0 ? size.height : undefined,
      }}
      onNativeLayout={event => {
        console.debug(
          `Received layout from native: ${JSON.stringify(event.nativeEvent)}`,
        );
        setNativeLayout(event.nativeEvent);
      }}>
      {props.children}
    </SheetViewNativeComponent>
  );
}

export default SheetView;
