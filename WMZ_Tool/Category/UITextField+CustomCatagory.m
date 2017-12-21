//
//  UITextField+CustomCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UITextField+CustomCatagory.h"

@implementation UITextField (CustomCatagory)
//判断是否为空
-(BOOL) isEmpty{
    return (self.text.length == 0);
}
@end
