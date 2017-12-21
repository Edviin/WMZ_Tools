//
//  UITableView+CustomCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UITableView+CustomCatagory.h"
#import <objc/runtime.h>

static NSString *TableViewCacheHeights = @"TableViewCacheRowHeights";//row高度缓存

@implementation UITableView (CustomCatagory)

-(void) setTableViewFooterNil{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    self.tableFooterView = view;
}

-(CGFloat) heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = [self cacheHeightForIndexPath:indexPath];
    if (cellHeight != CGFLOAT_MIN) {
        return cellHeight;
    }
    
    //默认高度40
    cellHeight = 40.0;
    
    if ([self.dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        UITableViewCell *cell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
        
        cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 2000);
        [cell setNeedsLayout];
        
        // 得到cell的contentView需要的真实高度
        cellHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        
        //判断是否有分割线，有的话，需要加上，没有则直接使用
        if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
            cellHeight += 1.0 / [UIScreen mainScreen].scale;
        }
        
        [self setCacheHeight:cellHeight forIndexPath:indexPath];
    }
    
    return cellHeight;
}

#pragma mark -
#pragma mark tableView，cell高度缓存
//高度缓存,高度缓存本地
-(CGFloat ) cacheHeightForIndexPath:(NSIndexPath *)indexPath{
    NSNumber *height = [self.cacheHeights objectForKey:NSStringFromRange(NSMakeRange(indexPath.section, indexPath.row))];
    if (height) {
        return height.floatValue;
    }
    return CGFLOAT_MIN;
}
//设置高度缓存
-(void) setCacheHeight:(CGFloat)cacheHeight forIndexPath:(NSIndexPath *)indexPath{
    [self.cacheHeights setObject:[NSNumber numberWithFloat:cacheHeight] forKey:NSStringFromRange(NSMakeRange(indexPath.section, indexPath.row))];
}

//移除所有高度
-(void) removeCacheHeights{
    [self.cacheHeights removeAllObjects];
}

//移除指定indexPaths数组的高度值
-(void) removeCacheHeightsWithIndexPaths:(NSArray *)indexPaths{
    NSMutableArray *deleteIndexPaths = [NSMutableArray array];
    for (NSIndexPath *indexPath in indexPaths) {
        [deleteIndexPaths addObject:NSStringFromRange(NSMakeRange(indexPath.section, indexPath.row))];
    }
    [self.cacheHeights removeObjectsForKeys:deleteIndexPaths];
}

//当tableView增加，删除cell时，执行的删除指定行以后(包括指定行在内)的所有indexPath数组高度
-(void) removeCacheHeightsWithDeleteAndInsertCell:(NSIndexPath *)indexPath{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSInteger row = indexPath.row; row < [self numberOfRowsInSection:0]; row ++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:row inSection:0]];
    }
    [self removeCacheHeightsWithIndexPaths:indexPaths];
}

-(NSMutableDictionary *) cacheHeights{
    id object =  objc_getAssociatedObject(self, [TableViewCacheHeights cStringUsingEncoding:NSUTF8StringEncoding]);
    if (object) {
        return object;
    }
    NSMutableDictionary *cacheHeights = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, [TableViewCacheHeights cStringUsingEncoding:NSUTF8StringEncoding],cacheHeights , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return cacheHeights;
}
@end
