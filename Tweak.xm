#import <Foundation/Foundation.h>
#include <objc/runtime.h>
#import <UIKit/UIKit.h>

@interface PLYoukuActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1;
@end

@interface PLTudouActivity
- (BOOL)_canPerformWithSuppliedActivityItems:(id)arg1;
@end

%hook PSListController
-(void)viewDidLoad
{
	[self removeSpecifierID:@"WEIBO"];
	[self removeSpecifierID:@"SINAWEIBO"];
	%orig;
}
%end

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

%hook UIActivityViewController
-(NSArray *)excludedActivityTypes
{
  NSArray *array = %orig;
  NSMutableArray *clean = [NSMutableArray arrayWithArray:array];

  [clean addObject:UIActivityTypePostToWeibo];
  //NSArray *clean2 = [NSArray arrayWithArray:clean];
  return clean; 
}
%end


__attribute__((constructor)) static void init()
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    %init;

    [pool release];
}
