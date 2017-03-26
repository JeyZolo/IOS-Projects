//
//  MLWorldGenerator.h
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>

@interface MLWorldGenerator : SKNode
+ (id)generatorWithWorld:(SKNode *)world;
- (void)populate;
- (void)generate;
- (void)updateCount;

@end
