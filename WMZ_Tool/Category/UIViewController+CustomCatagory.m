//
//  UIViewController+CustomCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIViewController+CustomCatagory.h"
#define ToolKit_LogDebugInfo(info)  NSLog(@"类别: %@  \n方法: %@ \n行号:%d \n调试信息: %@",self,NSStringFromSelector(_cmd),__LINE__, info);
//子类未实现方法提示
#define ToolKit_SubClassNotPerformSelector(selector) NSLog(@"子类: %@  \n未实现方法: %@",self,NSStringFromSelector(selector));

@implementation UIViewController (CustomCatagory)


//最前面的视图控制器
-(UIViewController *) getCurrentViewController{
    if (self.presentedViewController == nil) {//当前ViewController没有present任何Controller
        return [self getCurrentViewController];
    }
    if([self isKindOfClass:[UITabBarController class]]){//如果是tabbar控制栏
        UIViewController *tabbarVC =  [(UITabBarController *) self selectedViewController];
        return [tabbarVC getCurrentViewController];
    }else if ([self isKindOfClass:[UINavigationController class]]){//如果是导航控制器
        UINavigationController *navigation = (UINavigationController *) self;
        return [navigation.visibleViewController getCurrentViewController];
    }
    return self;
}

-(NSInteger) getVCIndexInNavigationWith:(Class )viewcontroller{
    for (NSInteger index = 0; index < self.navigationController.childViewControllers.count; index ++) {
        if ([[self.navigationController.childViewControllers objectAtIndex:index] isKindOfClass:viewcontroller]) {
            return index;
        }
    }
    return NSNotFound;
}

-(UIViewController *) getViewControllerInNavigationWith:(Class)viewController{
    NSInteger index = [self getVCIndexInNavigationWith:viewController];
    if (index != NSNotFound)
    return [self.navigationController.childViewControllers objectAtIndex:index];
    return nil;
}

-(UIViewController *) getViewControllerBeforeIndex:(NSInteger)index{
    if (!self.navigationController) {
        ToolKit_LogDebugInfo(@"当前ViewController未被导航控制器管理");
        return nil;
    }
    NSInteger currentIndex = [self.navigationController.childViewControllers indexOfObject:self];
    if (currentIndex - index < 0) {
        ToolKit_LogDebugInfo(@"索引超出的导航控制器的childViewControllers范围");
        return nil;
    }
    return [self.navigationController.childViewControllers objectAtIndex:currentIndex - index];
}

-(void) registeKeyBoardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) unRegisteNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) keyBoardWillShow:(NSNotification *) notificatiton{
    NSDictionary *userInfo = [notificatiton userInfo];
    NSValue *keyboardEnd = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *keyboardBegin = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGRect keyboardEndRect = keyboardEnd.CGRectValue;
    CGRect keyboardBeginRect = keyboardBegin.CGRectValue;
    
    [self keyBoardWillShowBegin:keyboardBeginRect End:keyboardEndRect];
}

-(void) keyBoardWillHide:(NSNotification *) notificatiton{
    NSDictionary *userInfo = [notificatiton userInfo];
    NSValue *keyboardEnd = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue *keyboardBegin = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    
    CGRect keyboardEndRect = keyboardEnd.CGRectValue;
    CGRect keyboardBeginRect = keyboardBegin.CGRectValue;
    [self keyBoardWillHiddenBegin:keyboardBeginRect End:keyboardEndRect];
}

-(void) keyBoardWillShowBegin:(CGRect)beginRect End:(CGRect)endRect{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

-(void) keyBoardWillHiddenBegin:(CGRect)beginRect End:(CGRect)endRect{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

#pragma mark -
#pragma mark 导航栏
-(void) WMZ_CustomNaviBackButton{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:nil
                                                                        action:nil];
    self.navigationItem.backBarButtonItem = returnButtonItem;
}

-(void) WMZ_CustomNaviBackButton:(NSString *) title{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:nil
                                                                        action:nil];
    self.navigationItem.backBarButtonItem = returnButtonItem;
}

-(void) WMZ_CustomNaviLeftButton:(NSString *)title{
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(WMZ_CustomNaviLeftButtonClicked)];
    self.navigationItem.leftBarButtonItem = returnButtonItem;
}

-(void) WMZ_CustomNaviLeftButtonWithImage:(UIImage *)image{
    
    UIButton  *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    [imageView setImage:image forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(WMZ_CustomNaviLeftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
}
-(void) WMZ_CustomNaviRightButton{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:@"下一步"
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(WMZ_CustomNaviRightButtonClicked)];
    rightButton.tintColor = [UIColor blueColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) WMZ_CustomNaviRightButton:(NSString *)title{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]
                                     initWithTitle:title
                                     style:UIBarButtonItemStylePlain
                                     target:self
                                     action:@selector(WMZ_CustomNaviRightButtonClicked)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) WMZ_CustomNaviRightButtonWithImage:(UIImage *)image{
    UIButton  *imageView = [UIButton buttonWithType:UIButtonTypeCustom];
    imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    [imageView setImage:image forState:UIControlStateNormal];
    [imageView addTarget:self action:@selector(WMZ_CustomNaviRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void) WMZ_CustomNaviRightButtonWithCustomView:(UIButton *)customView{
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithCustomView:customView];
    [customView addTarget:self action:@selector(WMZ_CustomNaviRightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void) WMZ_CustomNaviRightButtonClicked{
    ToolKit_SubClassNotPerformSelector(_cmd);
}

-(void) WMZ_CustomNaviLeftButtonClicked{
    ToolKit_SubClassNotPerformSelector(_cmd);
}
@end
