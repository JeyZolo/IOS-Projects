//
//  MLPointsLabel.m
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//


#import "MLPointsLabel.h"

@implementation MLPointsLabel

+ (id)pointsLabelWithFontNamed:(NSString *)fontName
{
    MLPointsLabel *pointsLabel = [MLPointsLabel labelNodeWithFontNamed:fontName];
    pointsLabel.text = @"0";
    pointsLabel.number = 0;
    return pointsLabel;
}

- (void)increment
{
    self.number++;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

- (void)setPoints:(int)points
{
    self.number = points;
    self.text = [NSString stringWithFormat:@"%i", self.number];
}

- (void)reset
{
    self.number = 0;
    self.text = @"0";
}

@end
