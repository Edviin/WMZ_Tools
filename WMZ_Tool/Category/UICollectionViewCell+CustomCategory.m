//
//  UICollectionViewCell+CustomCategory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UICollectionViewCell+CustomCategory.h"

@implementation UICollectionViewCell (CustomCategory)

-(UICollectionView *)collectionViewOfcurrentCell
{
    UIView *wrapperView=[self superview];
    UICollectionView *superCollectionView=(UICollectionView *)[wrapperView superview];
    return superCollectionView;
}
-(NSIndexPath *)indexPathOfcurrentCell
{
    UICollectionView *superTableView=[self collectionViewOfcurrentCell];
    NSIndexPath *index=[superTableView indexPathForCell:self];
    return index;
}
@end
