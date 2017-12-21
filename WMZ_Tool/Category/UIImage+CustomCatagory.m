//
//  UIImage+CustomCatagory.m
//  WMZ_Tools
//
//  Created by WMZ on 2017/12/21.
//  Copyright © 2017年 WMZ. All rights reserved.
//

#import "UIImage+CustomCatagory.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (CustomCatagory)
/**
 *  将图片旋转给定的角度
 *
 *  @param degrees 角度
 *
 *  @return 旋转后的图片
 */
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees{
    CGSize imgSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CGSize outputSize = imgSize;
    //    if (cropMode == enSvCropExpand) {
    //        CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    //        rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(radian));
    //        outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    //    }
    
    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, degrees * M_PI / 180);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    
    [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  按（给定高度）比例变化后得到的尺寸
 *
 *  @param height 给定的高度
 *
 *  @return 新的尺寸
 */
-(CGSize) imageGetSizeWithHeight:(CGFloat)height{
    float ratio = self.size.width / self.size.height;
    CGFloat newWidth = ratio * height;
    return CGSizeMake(newWidth, height);
}

/**
 *  按（给定宽度）比例变化后得到的尺寸
 *
 *  @param width 给定的宽度
 *
 *  @return 新的尺寸
 */
-(CGSize) imageGetSizeWithWidth:(CGFloat)width{
    float ratio = self.size.height / self.size.width;
    CGFloat newHeight = ratio * width;
    return CGSizeMake(width, newHeight);
}

-(CGSize) imageFillSizeWithRect:(CGSize)size{
    CGSize widthSize = [self imageGetSizeWithWidth:size.width];
    if (widthSize.height > size.height) {
        CGSize heightSize = [self imageGetSizeWithHeight:size.height];
        return heightSize;
    }
    return widthSize;
}
#pragma mark 图片，颜色相关
//图片放大缩小
-(UIImage *) getImageWithScale:(float) scale{
    
    CGFloat width = self.size.width ;
    CGFloat height = self.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(width * scale, height * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    //要进行坐标转换
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width * scale , height * scale), self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//截取图片中某块区域
-(UIImage *) takeSubImagewithRect:(CGRect) rect{
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    UIGraphicsBeginImageContext(CGSizeMake(width,height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1, -1);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(rect.origin.x, rect.origin.y, width, height));
    CGContextDrawImage(context, CGRectMake(0, 0, width, height) , newImageRef);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(newImageRef);
    return newImage;
}

//切取圆形图片
-(UIImage *) takeArcImageWithStart:(CGPoint) start widthRadius:(CGFloat) radius{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddArc(context, start.x, start.y, radius, 0, M_PI * 2, 1);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextDrawImage(context,CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage *) takeArcImageWithRadius:(CGFloat)radius{
    CGFloat height = self.size.height;
    CGFloat width = self.size.width;
    CGFloat minwidth = MIN(height, width);
    
    CGPoint center = CGPointMake(minwidth / 2, minwidth / 2);
    return [self takeArcImageWithStart:center widthRadius:radius];
}

#pragma mark 图片，颜色相关
//绘制颜色的背景图片
+(UIImage *) imageWithColor:(UIColor *) color size:(CGSize) size{
    UIGraphicsBeginImageContext(size);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//为图片着色
-(UIImage *) tintColorWith:(UIColor *)color blendMode:(CGBlendMode)blendMode{
    if (!color) {
        
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [color setFill];
    
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(rect);
    
    [self drawInRect:rect blendMode:blendMode alpha:1.0];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//返回图片某个像素点的颜色
-(UIColor *) imagePixelColorWithPoint:(CGPoint)point{
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.size.width, self.size.height), point)) {
        
        return nil;
    }
    unsigned char colors[4];
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    //只绘制一个像素点
    CGContextRef context = CGBitmapContextCreate(colors, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextTranslateCTM(context, -point.x, point.y - self.size.height);
    CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    
    CGFloat red = (CGFloat)colors[0];
    CGFloat yellow = (CGFloat)colors[1];
    CGFloat green = (CGFloat)colors[2];
    CGFloat alpha = (CGFloat)colors[3];
    
    return [UIColor colorWithRed:red green:yellow blue:green alpha:alpha];
}

//压缩至指定精度
-(NSData *) imageCompressWithDataMaxLength:(NSUInteger)maxLength{
    NSData *data = UIImageJPEGRepresentation(self, 1);
    NSUInteger imageDataLength = data.length;
    if (imageDataLength < maxLength) {
        return data;
    }
    CGFloat ratio = imageDataLength / maxLength;
    return UIImageJPEGRepresentation(self, ratio);
}

- (UIImage *)blurryImageWithBlurLevel:(CGFloat)blur{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer, outBuffer2;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
    return self;
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    outBuffer2.data = pixelBuffer;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,&outBuffer2,NULL,0,0,boxSize,boxSize,NULL,kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2,&inBuffer,NULL,0,0,boxSize,boxSize,NULL,kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer,&outBuffer,NULL,0,0,boxSize,boxSize,NULL,kvImageEdgeExtend);
    
    if (error) {
        return self;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end
