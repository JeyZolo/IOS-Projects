//
//  Jumper.m
//  doodlejump
//
//  Created by 米拉 on 2/18/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "Jumper.h"
//@interface Jumper : UIView

@implementation Jumper
@synthesize dx, dy;
//@synthesize jumperImage;
/*- (void)drawRect:(CGRect)rect
{
    //UIColor * colorgreen = [UIColor colorWithRed:(127.0/255.0) green:(255.0/255.0) blue:(0.0/255.0) alpha:(100.0/100.0)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //UIImage *img = [UIImage imageNamed:@"dj.png"];
   CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    CGFloat locations[2] = { 0.0, 1.0};
    
    NSArray *colors = @[(id)[UIColor whiteColor].CGColor,
                        (id)[UIColor brownColor].CGColor];
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    
    gradient = CGGradientCreateWithColors(colorspace,
                                          (CFArrayRef)colors, locations);
    
    CGPoint startPoint, endPoint;
    CGFloat startRadius, endRadius;
    startPoint.x = 10;
    startPoint.y = 10;
    endPoint.x = 10;
    endPoint.y = 10;
    startRadius = 0;
    endRadius = 10;
    
    CGContextDrawRadialGradient (context, gradient, startPoint,
                                 startRadius, endPoint, endRadius,
                                 0);
    //[img drawInRect:rect];
    
}

*//*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
