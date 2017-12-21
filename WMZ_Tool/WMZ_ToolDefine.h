
//
//  WMZ_ToolDefine.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#ifndef WMZ_ToolDefine_h
#define WMZ_ToolDefine_h



#define isIphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)  //是否是iphone4
#define isIphone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphone5
#define isIphone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)  //是否是iphone4s
#define isIphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphone6
#define isIphone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO) //是否是iphone6p

//  当前系统的版本号
#define SysVersion      [[UIDevice currentDevice] systemVersion].doubleValue
#define Iphone_Bounds   [UIScreen mainScreen].bounds
#define Iphone_Height   [[UIScreen mainScreen ] bounds ].size.height
#define Iphone_Width    [[UIScreen mainScreen ] bounds ].size.width

#define Iphone_NavigationBarHeight   64
#define Iphone_TabBarHeight    49

//*******************默认值**********************//

#define NSStringInitDefalutValue(value1, value2) (value1) ? value1 : value2            //字符串
#define NSStringWithNSNullValue(value1) ([value1 isKindOfClass:[NSNull class]]) ? @"" : value1            //和nsnull做比较
#define NSStringWithNilValue(value1) (value1) ? value1 : @""            //和nil比较

#import "NSArray+CustomCategory.h"
#import "NSDate+CustomCategory.h"
#import "NSDateFormatter+CustomCategory.h"
#import "NSDictionary+CustomCategory.h"
#import "NSNumber+CustomCategory.h"
#import "NSObject+CustomCategory.h"
#import "NSString+AttributeStringCatagory.h"
#import "NSString+ConvertCatagory.h"
#import "NSString+RegexCatagory.h"
#import "NSString+DateCatagory.h"
#import "UIActionSheet+Blocks.h"
#import "UIAlertView+Blocks.h"
#import "UICollectionViewCell+CustomCategory.h"
#import "UIColor+CustomCatagory.h"
#import "UIImage+CustomCatagory.h"
#import "UILabel+LineHeight.h"
#import "UINavigationController+BackGesture.h"
#import "UINavigationController+CustomCatagory.h"
#import "UIResponder+CustomResponderEvent.h"
#import "UITableView+CustomCatagory.h"
#import "UITableViewCell+CustomCategory.h"
#import "UITextField+Shake.h"
#import "UITextField+CustomCatagory.h"
#import "UIView+ActionSheetAnimation.h"
#import "UIView+AlertAnimation.h"
#import "UIView+AboutSelf.h"
#import "UIView+AutoLayout.h"
#import "UIViewController+CustomCatagory.h"

#import "SystemHudView.h"





#endif /* WMZ_ToolDefine_h */
