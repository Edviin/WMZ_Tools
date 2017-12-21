//
//  UIView+AboutSelf.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIView+AboutSelf.h"

@implementation UIView (AboutSelf)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


#pragma mark -
#pragma mark 设置视图的边框，阴影
-(void) CustomUI_setBorderColor:(UIColor *) color with:(CGFloat) width{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}


-(void) removeBorderColor{
    self.layer.borderWidth = 0;
    self.layer.borderColor = NULL;
}

-(void) CustomUI_setCornerWith:(CGFloat) radios{
    self.layer.cornerRadius = radios;
    //消除边界
    self.layer.masksToBounds = YES;
}

-(void) ZJ_SetShadowPathRound:(CGFloat)offset{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-offset, -offset)];
    [path addLineToPoint:CGPointMake( self.width + offset,  -offset)];
    [path addLineToPoint:CGPointMake( self.width + offset, self.height + 2 * offset)];
    [path addLineToPoint:CGPointMake(-offset, self.height + 2 * offset)];
    [path closePath];
    path.lineJoinStyle = kCGLineJoinRound;
    
    self.layer.shadowPath = path.CGPath;
}

//截屏
-(UIImage *) takeViewShot{
    UIGraphicsBeginImageContext(self.bounds.size);
    if([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]){
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (UINavigationController *)navigationController
{
    for (UIView * next = [self superview]; next; next = next.superview)
    {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}

-(UIViewController *)viewController
{
    for (UIView * next = [self superview]; next; next = next.superview)
    {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+(id ) loadCurrentViewFromNib{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    if (array.count == 0) {
        NSString *info = [NSString stringWithFormat:@"找不到%@.xib",NSStringFromClass(self)];
        NSLog(@"类别: %@  \n方法: %@ \n行号:%d \n调试信息: %@",self,NSStringFromSelector(_cmd),__LINE__, info);
        return nil;
    }
    return [array firstObject];
}
//移除所有子视图
-(void) RemoveAllSubViews{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

-(void) RemoveSubview:(NSUInteger) tag{
    [[self viewWithTag:tag] removeFromSuperview];
}
@end
