//
//  NSString+AttributeStringCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "NSString+AttributeStringCatagory.h"

@implementation NSString (AttributeStringCatagory)

-(NSAttributedString *) toAttributedStringWithRanges:(NSArray *)ranges attributes:(NSArray *)attributes{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    for (NSInteger index = 0; index < ranges.count; index ++) {
        NSRange range = NSRangeFromString([ranges objectAtIndex:index]);
        NSDictionary *dict = [attributes objectAtIndex:index];
        [attributedString addAttributes:dict range:range];
    }
    return attributedString;
}

-(NSAttributedString *) toAttributedStringWithRanges:(NSArray *)ranges textColor:(UIColor *)color{
    NSMutableArray *attributes = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0 ; index < ranges.count; index ++) {
        [attributes addObject:@{NSForegroundColorAttributeName: color}];
    }
    return [self toAttributedStringWithRanges:ranges attributes:attributes];
}
@end
