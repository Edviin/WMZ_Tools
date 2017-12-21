//
//  UINavigationController+CustomCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UINavigationController+CustomCatagory.h"
#import <objc/runtime.h>
static const void *UINavigationBlock = &UINavigationBlock;
//调试信息
#define ToolKit_LogDebugInfo(info)  NSLog(@"类别: %@  \n方法: %@ \n行号:%d \n调试信息: %@",self,NSStringFromSelector(_cmd),__LINE__, info);

@implementation UINavigationController (CustomCatagory)

-(void) setNavigationCurrentWithBlock:(UINavigationViewControllerBlock)block{
    NSInteger currentIndex = [self.childViewControllers indexOfObject:self.childViewControllers.lastObject];
    [self setNavigationOtherWithBlock:block with:currentIndex];
}

-(void) setNavigationOtherWithBlock:(UINavigationViewControllerBlock)block
                               with:(NSInteger)otherIndex{
    if (otherIndex > self.childViewControllers.count - 1 ) {//超出范围了
        ToolKit_LogDebugInfo(@"索引超出的导航控制器的childViewControllers范围");
        return;
    }
    
    NSString *viewControllerName = [NSString stringWithFormat:@"%@%@",NSStringFromClass([[self.childViewControllers objectAtIndex:otherIndex] class]),@(otherIndex)];
    
    UINavigationViewControllerBlock beforeBlock = objc_getAssociatedObject(self, [viewControllerName cStringUsingEncoding:NSUTF8StringEncoding]);
    if (beforeBlock) {
        beforeBlock = nil;
    }
    objc_setAssociatedObject(self, [viewControllerName cStringUsingEncoding:NSUTF8StringEncoding], block, OBJC_ASSOCIATION_COPY);
}

-(void) passWithValue:(id)value otherChildIndex:(NSInteger)index{
    if (index > self.childViewControllers.count - 1) {//超出范围了
        ToolKit_LogDebugInfo(@"索引超出的导航控制器的childViewControllers范围");
        return;
    }
    NSString *viewControllerName = [NSString stringWithFormat:@"%@%@",NSStringFromClass([[self.childViewControllers objectAtIndex:index] class]),@(index)];
    
    UINavigationViewControllerBlock beforeBlock = objc_getAssociatedObject(self, [viewControllerName cStringUsingEncoding:NSUTF8StringEncoding]);
    if (beforeBlock) {
        beforeBlock(value);
    }else{
        NSString *info = [NSString stringWithFormat:@"%@未设置跳转回调block",viewControllerName];
        ToolKit_LogDebugInfo(info);
    }
}

@end
