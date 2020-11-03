#import "FlutterCPtrPlugin.h"
#if __has_include(<flutter_c_ptr/flutter_c_ptr-Swift.h>)
#import <flutter_c_ptr/flutter_c_ptr-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_c_ptr-Swift.h"
#endif

@implementation FlutterCPtrPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCPtrPlugin registerWithRegistrar:registrar];
}
@end
