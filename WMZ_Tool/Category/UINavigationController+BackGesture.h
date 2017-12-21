//
//  UINavigationController+BackGesture.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#define BackGestureOffsetXToBack 80//>80 show pre vc
#import <UIKit/UIKit.h>

@interface UINavigationController (BackGesture)

@property (assign,nonatomic) BOOL enableBackGesture;
@end
