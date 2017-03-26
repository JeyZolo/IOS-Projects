//
//  MLHero.m
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "MLHero.h"

@interface MLHero ()
@property BOOL isJumping;
@end

@implementation MLHero

static const uint32_t heroCategory = 0x1 << 0;
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t cloudsCategory = 0x1 << 3;


+ (id)hero
{
    MLHero *hero = [MLHero spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(40, 40)];
    hero.texture = [SKTexture textureWithImageNamed:@"pp2.png"];
  
    
    hero.name = @"hero";
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    hero.physicsBody.categoryBitMask = heroCategory;
    hero.physicsBody.contactTestBitMask = obstacleCategory | groundCategory ;
    
    return hero;
}

- (void)jump
{
    if (!self.isJumping) {
        [self.physicsBody applyImpulse:CGVectorMake(0, 40)];
        [self runAction:[SKAction playSoundFileNamed:@"onJump.wav" waitForCompletion:NO]];
        self.isJumping = YES;
    }
}

- (void)land
{
    self.physicsBody.velocity = CGVectorMake(0, 0);
    self.isJumping = NO;
}

- (void)start
{
    SKAction *incrementRight = [SKAction moveByX:1.0 y:0 duration:0.004];
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    [self runAction:moveRight];
}

- (void)stop
{
    [self removeAllActions];
}

@end

