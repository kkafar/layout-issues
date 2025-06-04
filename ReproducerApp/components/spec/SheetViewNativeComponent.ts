import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type {ViewProps} from 'react-native';
import type {
  DirectEventHandler,
  Float,
} from 'react-native/Libraries/Types/CodegenTypes';

export type NativeLayoutEvent = Readonly<{
  origin: Readonly<{
    x: Float;
    y: Float;
  }>;
  size: Readonly<{
    width: Float;
    height: Float;
  }>;
}>;

export interface NativeProps extends ViewProps {
  onNativeLayout?: DirectEventHandler<NativeLayoutEvent>;
}

export default codegenNativeComponent<NativeProps>('SheetView', {});
