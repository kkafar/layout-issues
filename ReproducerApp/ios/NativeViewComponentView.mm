#import "NativeViewComponentView.h"
#import <React/RCTConversions.h>
#import <React/RCTFabricComponentsPlugins.h>
#import <React/RCTRootComponentView.h>
#import <React/RCTScrollViewComponentView.h>
#import <React/RCTSurfaceTouchHandler.h>
#import <react/renderer/components/appcomponents/EventEmitters.h>
#import <react/renderer/components/appcomponents/Props.h>
#import <react/renderer/components/appcomponents/RCTComponentViewHelpers.h>
#import <react/renderer/components/appcomponents/ComponentDescriptors.h>

namespace react = facebook::react;


@implementation NativeViewComponentView

- (void)didMoveToWindow
{
  NSLog(@"NativeView [%ld] didMoveToWindow %@", self.tag, self.window);
  [super didMoveToWindow];
}

- (void)layoutSubviews
{
  NSLog(@"NativeView [%ld] layoutSubviews", self.tag);
  [super layoutSubviews];
  [self emitOnNativeLayout];
}

- (void)emitOnNativeLayout
{
  if (_eventEmitter != nullptr) {
    NSLog(@"NativeView [%ld] emitOnNativeLayout", self.tag);
    auto emitter = std::dynamic_pointer_cast<const react::NativeViewEventEmitter>(_eventEmitter);
    emitter->onNativeLayout(react::NativeViewEventEmitter::OnNativeLayout { .insetTop = 192 });
  }
}

+ (react::ComponentDescriptorProvider)componentDescriptorProvider
{
  return react::concreteComponentDescriptorProvider<react::NativeViewComponentDescriptor>();
}

@end

Class<RCTComponentViewProtocol> NativeViewCls(void)
{
  return NativeViewComponentView.class;
}
