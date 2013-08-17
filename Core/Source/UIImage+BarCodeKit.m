//
//  UIImage+BarCodeKit.m
//  BarCodeKit
//
//  Created by Oliver Drobnik on 8/17/13.
//  Copyright (c) 2013 Oliver Drobnik. All rights reserved.
//

#import "UIImage+BarCodeKit.h"
#import "BarCodeKit.h"

@implementation UIImage (BarCodeKit)

+ (UIImage *)imageWithBarCode:(BCKCode *)barCode options:(NSDictionary *)options
{
	CGSize neededSize = [barCode sizeWithRenderOptions:options];

	UIGraphicsBeginImageContextWithOptions(neededSize, NO, 0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
//	[[UIColor grayColor] set];
//	CGContextFillRect(ctx, CGRectMake(0, 0, neededSize.width, neededSize.height));
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[barCode renderInContext:context options:options];
	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

@end
