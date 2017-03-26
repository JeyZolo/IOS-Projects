//
//  MLPointsLabel.h
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLPointsLabel : SKLabelNode
@property int number;

+ (id)pointsLabelWithFontNamed:(NSString *)fontName;
- (void)increment;
- (void)setPoints:(int)points;
- (void)reset;
@end
