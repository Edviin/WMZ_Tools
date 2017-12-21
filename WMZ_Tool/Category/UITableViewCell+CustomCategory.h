//
//  UITableViewCell+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CustomCategory)
/**
 *  获取当前Cell所在的TableView对象
 *
 */
-(UITableView *)tableViewOfcurrentCell;

/**
 *  获取当前Cell所在的NSIndexPath
 *
 *  @return NSIndexPath对象
 */
-(NSIndexPath *)indexPathOfcurrentCell;
@end
