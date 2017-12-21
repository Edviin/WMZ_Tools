//
//  UIView+AutoLayout.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

-(void) removeConstraintForAttribute:(NSLayoutAttribute)attribute{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == attribute) {
            [self removeConstraint:constraint];
            return;
        }
    }
    [self NSLayoutAttributeNotFound:attribute];
}
-(void) updateConstraintInSuperViewForAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant{
    if (!self.superview) {
        return;
    }
    for (NSLayoutConstraint *constraint in self.superview.constraints) {
        if ((constraint.firstAttribute == attribute && constraint.secondItem == self) ||(constraint.firstAttribute == attribute && constraint.firstItem == self)) {
            constraint.constant = constant;
            return;
        }
    }
    [self NSLayoutAttributeNotFound:attribute];
}

-(void) addConstraintFor:(NSLayoutAttribute)attribute superViewAttribute:(NSLayoutAttribute)superAttribute constant:(CGFloat)constant{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:superAttribute multiplier:1.0 constant:constant];
    [self.superview addConstraint:constraint];
}


-(void) updateConstraintForHeight:(CGFloat)height{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if ((constraint.firstAttribute == NSLayoutAttributeHeight && constraint.firstItem == self) || (constraint.firstAttribute == NSLayoutAttributeHeight && constraint.secondItem == self)) {
            constraint.constant = height;
            return;
        }
    }
    
    [self NSLayoutAttributeNotFound:NSLayoutAttributeHeight];
}

-(void) updateConstraintForWidth:(CGFloat)width{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeWidth && constraint.firstItem == self) {
            constraint.constant = width;
            return;
        }
    }
    [self NSLayoutAttributeNotFound:NSLayoutAttributeWidth];
}

-(void) updateConstraintForSize:(CGSize)size{
    [self updateConstraintForHeight:size.height];
    [self updateConstraintForWidth:size.width];
}

-(void) addConstraintToFillWithSuperView{
    
    //上
    [self addConstraintFor:NSLayoutAttributeTop superViewAttribute:NSLayoutAttributeTop constant:0];
    
    //下
    [self addConstraintFor:NSLayoutAttributeBottom superViewAttribute:NSLayoutAttributeBottom constant:0];
    
    //左
    [self addConstraintFor:NSLayoutAttributeLeading superViewAttribute:NSLayoutAttributeLeading constant:0];
    
    //右
    [self addConstraintFor:NSLayoutAttributeTrailing superViewAttribute:NSLayoutAttributeTrailing constant:0];
}

-(void) addConstraintForselfHeight:(CGFloat)height{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil  attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height];
    [self addConstraint:constraint];
}

-(void) addConstraintForselfWidth:(CGFloat)width{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil  attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:constraint];
}

//将枚举值转换为枚举值具体值，方便提示
-(NSString *)NSLayoutAttributeToStringName:(NSLayoutAttribute) attribute{
    NSArray *array = @[@"NSLayoutAttributeNotAnAttribute",
                       @"NSLayoutAttributeLeft",
                       @"NSLayoutAttributeRight",
                       @"NSLayoutAttributeTop",
                       @"NSLayoutAttributeBottom",
                       @"NSLayoutAttributeLeading",
                       @"NSLayoutAttributeTrailing",
                       @"NSLayoutAttributeWidth",
                       @"NSLayoutAttributeHeight",
                       @"NSLayoutAttributeCenterX",
                       @"NSLayoutAttributeCenterY",
                       @"NSLayoutAttributeBaseline",
                       @"NSLayoutAttributeLastBaseline",
                       @"NSLayoutAttributeFirstBaseline"];
    if (attribute > array.count) {//未找到对应的布局属性
        return [NSString stringWithFormat:@"%@",@(attribute)];
    }
    return [array objectAtIndex:attribute];
}

-(void) NSLayoutAttributeNotFound:(NSLayoutAttribute) attribute{
    NSLog(@"类别: %@  \n方法: %@ \n行号:%d \n 在%@中，未找到对应属性%@",self,NSStringFromSelector(_cmd),__LINE__, self,[self NSLayoutAttributeToStringName:attribute]);
}
@end
