//
//  UINavigationController+CustomCatagory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UINavigationViewControllerBlock) (id object);

@interface UINavigationController (CustomCatagory)
/**
 *  这里主要是在UINavigationController中，需要多个childViewController中传值，这里是为当前ViewController统一写上block回调
 *
 *  @param block   bock
 */
-(void) setNavigationCurrentWithBlock:(UINavigationViewControllerBlock) block;
/**
 *  这里主要是在UINavigationController中，需要多个childViewController中传值，这里是为指定ChildViewController统一写上block回调
 *
 *  @param block   bock
 */
-(void) setNavigationOtherWithBlock:(UINavigationViewControllerBlock) block with:(NSInteger) otherIndex;

/**
 *  这里主要是在UINavigationController中，需要多个childViewController中传值，当前VC向指定索引的VC船只
 *
 *  @param value   数据
 *  @param index   指定索引的VC
 */
-(void) passWithValue:(id) value otherChildIndex:(NSInteger) index;

@end
