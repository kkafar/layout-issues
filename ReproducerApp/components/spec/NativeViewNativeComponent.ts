'use client';

import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type {ViewProps} from 'react-native';
import type {
  DirectEventHandler,
  Int32,
} from 'react-native/Libraries/Types/CodegenTypes';

type NativeLayoutEvent = Readonly<{
  insetTop: Int32;
}>;

export interface NativeProps extends ViewProps {
  onNativeLayout?: DirectEventHandler<NativeLayoutEvent>;
}

export default codegenNativeComponent<NativeProps>('NativeView', {});
