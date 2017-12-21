//
//  UITableViewCell+CustomCategory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UITableViewCell+CustomCategory.h"

@implementation UITableViewCell (CustomCategory)
-(UITableView *)tableViewOfcurrentCell
{
    UIView *wrapperView=[self superview];
    UITableView *superTableView=(UITableView *)[wrapperView superview];
    return superTableView;
}

-(NSIndexPath *)indexPathOfcurrentCell
{
    UITableView *superTableView=[self tableViewOfcurrentCell];
    NSIndexPath *index=[superTableView indexPathForCell:self];
    return index;
}
@end
