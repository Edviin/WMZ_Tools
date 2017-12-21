//
//  UILabel+LineHeight.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UILabel+LineHeight.h"

@implementation UILabel (LineHeight)
-(void)setLineLineSpacing:(NSInteger)lineSpacing
{
    NSString *text = [self.text copy];
    self.text = @"";
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle1 setLineSpacing:8];
    
    [paragraphStyle1 setLineBreakMode:NSLineBreakByTruncatingTail];
    
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    
    [self setAttributedText:attributedString1];
}

@end
