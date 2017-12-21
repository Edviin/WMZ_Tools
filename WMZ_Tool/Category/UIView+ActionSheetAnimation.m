//
//  UIView+ActionSheetAnimation.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIView+ActionSheetAnimation.h"
#import <objc/runtime.h>


#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.5
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]

const static char isTapBackDissmissKey;
const static char tempBackViewKey;
const static char actionSheetBackViewKey;


@interface UIView()

@property (nonatomic,strong) UIView *tempBackView;
@property (nonatomic,strong) UIView *actionSheetBackView;

@end
@implementation UIView (ActionSheetAnimation)

-(void)setIsTapBackDismiss:(BOOL)isTapBackDismiss
{
    objc_setAssociatedObject(self, &isTapBackDissmissKey, @(isTapBackDismiss), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)isTapBackDismiss
{
    return [objc_getAssociatedObject(self, &isTapBackDissmissKey) boolValue];
}

-(void)setTempBackView:(UIView *)tempBackView
{
    objc_setAssociatedObject(self, &tempBackViewKey, tempBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)tempBackView
{
    return objc_getAssociatedObject(self, &tempBackViewKey);
}

-(void)setActionSheetBackView:(UIView *)actionSheetBackView
{
    objc_setAssociatedObject(self, &actionSheetBackViewKey, actionSheetBackView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)actionSheetBackView
{
    return objc_getAssociatedObject(self, &actionSheetBackViewKey);
}
-(void) showActionSheetAnimation
{
    CGRect rect = self.frame;
    rect.origin.x = 0;
    rect.origin.y = 0;
    self.frame = rect;
    [self createTempView];
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self.tempBackView];
}

-(UIView *)createTempView
{
    UIView *tempBackView = [[UIView alloc] init];
    tempBackView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    tempBackView.backgroundColor = WINDOW_COLOR;
    tempBackView.userInteractionEnabled = YES;
    self.tempBackView = tempBackView;
    
    
    UIView *tapView = [[UIView alloc] init];
    tapView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - self.bounds.size.height);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [tapView addGestureRecognizer:tapGesture];
    
    [tempBackView addSubview:tapView];
    
    
    UIView *actionSheetBackView = [[UIView alloc] init];
    actionSheetBackView.frame = CGRectMake(0, ([UIScreen mainScreen].bounds.size.height), [UIScreen mainScreen].bounds.size.width, self.bounds.size.height);
    actionSheetBackView.backgroundColor = ACTIONSHEET_BACKGROUNDCOLOR;
    self.actionSheetBackView = actionSheetBackView;
    
    [tempBackView addSubview:actionSheetBackView];
    
    [actionSheetBackView addSubview:self];
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [actionSheetBackView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - self.bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height)];
        
    } completion:^(BOOL finished) {
        
    }];
    
    return tempBackView;
}

- (void)tappedCancel
{
    if (self.isTapBackDismiss)
    {
        [self dismiss];
        
    }
}

-(void)dismiss
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.actionSheetBackView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.tempBackView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.tempBackView removeFromSuperview];
        }
    }];
}
@end
