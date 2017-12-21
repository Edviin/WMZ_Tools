//
//  NSNumber+CustomCategory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSNumber+CustomCategory.h"

@implementation NSNumber (CustomCategory)
-(NSString *) priceCNYValue{
    return [NSString stringWithFormat:@"￥%.2f",[self doubleValue] / 100];
}


-(NSString *) priceValue{
    return [NSString stringWithFormat:@"%.2f",[self doubleValue] / 100];
}

@end
