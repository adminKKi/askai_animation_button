#import "AskaiAnimationButtonPlugin.h"
#if __has_include(<askai_animation_button/askai_animation_button-Swift.h>)
#import <askai_animation_button/askai_animation_button-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "askai_animation_button-Swift.h"
#endif

@implementation AskaiAnimationButtonPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAskaiAnimationButtonPlugin registerWithRegistrar:registrar];
}
@end
