//
//  UIResponder+CustomResponderEvent.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIResponder+CustomResponderEvent.h"
static __weak id currentFirstResponder;

@implementation UIResponder (CustomResponderEvent)

-(void) routerEventWithName:(NSString *)eventName dataInfo:(NSDictionary *)dataInfo{
    [[self nextResponder] routerEventWithName:eventName dataInfo:dataInfo];
}

+(id)currentFirstResponder {
    currentFirstResponder = nil;
    [[UIApplication sharedApplication] sendAction:@selector(findFirstResponder:) to:nil from:nil forEvent:nil];
    return currentFirstResponder;
}

-(void)findFirstResponder:(id)sender {
    currentFirstResponder = self;
}
@end
