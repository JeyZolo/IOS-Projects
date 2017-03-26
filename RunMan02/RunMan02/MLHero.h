
//
//  MLHero.h
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLHero : SKSpriteNode

+ (id)hero;
- (void)jump;
- (void)land;
- (void)start;
- (void)stop;

@end

