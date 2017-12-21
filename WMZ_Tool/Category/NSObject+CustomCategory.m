//
//  NSObject+CustomCategory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSObject+CustomCategory.h"
#import <objc/runtime.h>

static char blockKey;

@implementation NSObject (CustomCategory)
-(void)setCallBackBlock:(callBackBlock)callBackBlock
{
    objc_setAssociatedObject(self, &blockKey, callBackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(callBackBlock)callBackBlock
{
    return objc_getAssociatedObject(self, &blockKey);
}
-(void)setCallBack:(callBackBlock)callBack
{
    if (callBack)
    {
        self.callBackBlock = callBack;
    }
    
}
@end
