//
//  UICollectionViewCell+CustomCategory.h
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (CustomCategory)
/**
 *  获取当前Cell所在的CollectionView
 *
 *  @return CollectionView对象
 */
-(UICollectionView *)collectionViewOfcurrentCell;
/**
 *  获取当前Cell的IndexPath
 *
 *  @return IndexPath对象
 */
-(NSIndexPath *)indexPathOfcurrentCell;

@end
