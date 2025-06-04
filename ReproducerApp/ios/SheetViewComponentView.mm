#import "SheetViewComponentView.h"

#import <React/RCTConversions.h>
#import <React/RCTFabricComponentsPlugins.h>
#import <React/RCTRootComponentView.h>
#import <React/RCTScrollViewComponentView.h>
#import <React/RCTSurfaceTouchHandler.h>
#import <react/renderer/components/appcomponents/EventEmitters.h>
#import <react/renderer/components/appcomponents/Props.h>
#import <react/renderer/components/appcomponents/RCTComponentViewHelpers.h>
#import <react/renderer/components/appcomponents/ComponentDescriptors.h>
#import <React/UIView+React.h>

namespace react = facebook::react;

@implementation SheetViewComponentView

- (void)layoutSubviews
{
  NSLog(@"SheetView [%ld] layoutSubviews", self.tag);
  [super layoutSubviews];
  [self emitOnNativeLayout];
}

- (void)emitOnNativeLayout
{
  if (_eventEmitter != nil) {
    NSLog(@"SheetView [%ld] emitOnNativeLayout", self.tag);
    auto emitter = std::dynamic_pointer_cast<const react::SheetViewEventEmitter>(_eventEmitter);
    emitter->onNativeLayout({ .origin = { self.frame.origin.x, self.frame.origin.y }, .size = { self.frame.size.width, self.frame.size.height }});
  }
}

+ (react::ComponentDescriptorProvider)componentDescriptorProvider
{
  return react::concreteComponentDescriptorProvider<react::SheetViewComponentDescriptor>();
}

@end

Class<RCTComponentViewProtocol> SheetViewCls(void)
{
  return SheetViewComponentView.class;
}
