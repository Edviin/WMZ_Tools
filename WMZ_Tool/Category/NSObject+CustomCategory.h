//
//  NSObject+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callBackBlock)(id firstValue,...);


@interface NSObject (CustomCategory)
@property (nonatomic,copy) callBackBlock callBackBlock;

/**
 *  给某个类设置回调Block
 *
 *  @param callBack 回调的Block
 *  通过该方式可以不用使用代理了举例说明:
 
 Class A
 
 A *a = [A new];
 [a setCallBack:^(id firstValue, ...) {
 
 使用GetVariableParameterWithMutableArray  这个宏可得到传递过来的参数
 该宏中定义了一个array该array就是传递过来的参数
 array[0]
 array[1]
 }];
 
 在a中需要使用时 a.callBackBlock ? a.callBackBlock(param1,param2,param3,nil);
 *
 *
 */
-(void) setCallBack:(callBackBlock)callBack;

@end
