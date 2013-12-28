#import <Foundation/Foundation.h>
#include <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <Firmware.h>

@interface PLYoukuActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1;
@end

@interface PLTudouActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1;
@end

@interface PUYoukuActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1;
@end

@interface PUTudouActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1;
@end

//----------------------------------------------------------------------

%hook PSListController
-(void)viewDidLoad
{
	[self removeSpecifierID:@"WEIBO"];
	[self removeSpecifierID:@"SINAWEIBO"];
  [self removeSpecifierID:@"TENCENT_WEIBO"];
  [self removeSpecifierID:@"TENCENTWEIBO"];
  //NSArray* list = MSHookIvar<NSArray *>(self, "_specifiers");
  //NSLog(@"%@",list);
	%orig;
}
%end

//----------------------------------------------------------------------

%group iOS6
%hook PLYoukuActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1
{
	return NO;
}
%end

%hook PLTudouActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1
{
	return NO;
}
%end
%end

//----------------------------------------------------------------------

%group iOS7
%hook PUYoukuActivity
- (BOOL)canPerformWithActivityItems:(id)arg1
{
  return NO;
}
%end

%hook PUTudouActivity
- (BOOL)canPerformWithActivityItems:(id)arg1
{
  return NO;
}
%end

//----------------------------------------------------------------------

%hook UIActivityViewController
-(NSArray *)excludedActivityTypes
{
  NSArray *array = %orig;
  NSMutableArray *clean = [NSMutableArray arrayWithArray:array];

  [clean addObject:UIActivityTypePostToWeibo];
  [clean addObject:UIActivityTypePostToTencentWeibo];
  //NSArray *clean2 = [NSArray arrayWithArray:clean];
  return clean; 
}
%end


%ctor
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    %init;

    if (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)
      %init(iOS7);
    else
      %init(iOS6);

    [pool release];
}
