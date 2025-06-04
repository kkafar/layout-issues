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
#import <React/UIView+React.h>

namespace react = facebook::react;


@implementation NativeViewComponentView {
  UIViewController * _controller;
  UIView<RCTComponentViewProtocol> * _childView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    _childView = nil;
    _controller = [UIViewController new];
  }
  
  return self;
}

- (void)configureFormSheetPresentation
{
  _controller.modalPresentationStyle = UIModalPresentationFormSheet;
  UISheetPresentationController *sheetCtrl = _controller.sheetPresentationController;
  
  RCTAssert(sheetCtrl != nil, @"Sheet ctrl must not be nil here");
  
  [sheetCtrl setDetents:@[ UISheetPresentationControllerDetent.mediumDetent, UISheetPresentationControllerDetent.largeDetent]];
}

- (void)didMoveToWindow
{
  NSLog(@"NativeView [%ld] didMoveToWindow %@", self.tag, self.window);
  RCTAssert(_controller != nil, @"Controller must not be nil here");
  RCTAssert(_childView != nil, @"Child view must not be nil here");
  _controller.view = _childView;
  [self configureFormSheetPresentation];
  [self reactAddControllerToClosestParent:_controller];
  
}

- (void)reactAddControllerToClosestParent:(UIViewController *)controller
{
  if (!controller.parentViewController) {
    UIView *parentView = (UIView *)self.reactSuperview;
    while (parentView) {
      if (parentView.reactViewController) {
        [parentView.reactViewController presentViewController:_controller animated:YES completion:nil];
        [self addSubview:controller.view];
#if !TARGET_OS_TV
#endif
        [controller didMoveToParentViewController:parentView.reactViewController];
        break;
      }
      parentView = (UIView *)parentView.reactSuperview;
    }
    return;
  }
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

- (void)mountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  _childView = childComponentView;
}

- (void)unmountChildComponentView:(UIView<RCTComponentViewProtocol> *)childComponentView index:(NSInteger)index
{
  [_childView removeFromSuperview];
  _childView = nil;
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
