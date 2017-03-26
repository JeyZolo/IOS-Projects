//
//  MLWorldGenerator.m
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "MLWorldGenerator.h"

@interface MLWorldGenerator ()
@property double currentGroundX;
@property double currentObstacleX;
@property SKNode *world;
@end

@implementation MLWorldGenerator
int count=0;

static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;
static const uint32_t cloudsCategory = 0x1 << 3;


+ (id)generatorWithWorld:(SKNode *)world
{
    MLWorldGenerator *generator = [MLWorldGenerator node];
    generator.currentGroundX = 0;
    generator.currentObstacleX = 400;
    generator.world = world;
    return generator;
}

- (void)populate
{
    for (int i = 0; i < 3; i++)
        [self generate];
}

- (void)generate
{
    count++;
    //[self loadClouds];
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"ground"];
    ground.name = @"ground";
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/2 + ground.frame.size.height/2);
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    ground.physicsBody.categoryBitMask = groundCategory;
    ground.physicsBody.dynamic = NO;
    [self.world addChild:ground];
    
    self.currentGroundX += ground.frame.size.width;
    NSLog(@"%d",count);
   /* if(count%3==0){
        
        SKSpriteNode *ground2 = [SKSpriteNode spriteNodeWithImageNamed:@"ground02.png"];
        ground2.name = @"ground2";
        ground2.position = CGPointMake(-100,20);
        ground2.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground2.size];
        ground2.physicsBody.categoryBitMask = groundCategory;
        ground2.physicsBody.dynamic = NO;
        [self.world addChild:ground2];
        
        self.currentGroundX += ground2.frame.size.width;
    }*/
    
    SKSpriteNode *obstacle = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(40, 50)];
    if(count<20)
    {obstacle.texture = [SKTexture textureWithImageNamed:@"STONE01.jpg"];
      obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    }
    if(count>=10&&count<=20)
    {
        obstacle.texture = [SKTexture textureWithImageNamed:@"STONE02.jpg"];

         obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/1.8 + obstacle.frame.size.height/1.8);
        
    }
    if(count>30){
        obstacle.texture = [SKTexture textureWithImageNamed:@"STONE03.jpg"];
        
        obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/1.5 + obstacle.frame.size.height/1.5);
        
        
    }


    
    obstacle.name = @"obstacle";
    //obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    obstacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obstacle.size];
    obstacle.physicsBody.categoryBitMask = obstacleCategory;
    obstacle.physicsBody.dynamic = NO;
    [self.world addChild:obstacle];
    if(count<30)
    self.currentObstacleX += 250;
    
    if(count>=30)
        self.currentObstacleX += 200;
    
    

    
}

- (void)loadClouds
{
    SKSpriteNode *clouds = [SKSpriteNode spriteNodeWithImageNamed:@"Clouds01.jpg"];
    //  clouds.name = @"clouds";
    clouds.position = CGPointMake(-150, 80);
    //  clouds.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:clouds.size];
    clouds.physicsBody.categoryBitMask = cloudsCategory;
    // clouds.physicsBody.dynamic = NO;
    [self.world addChild:clouds];
    
    //self.currentGroundX += clouds.frame.size.width;
    /*SKShapeNode *cloud1 = [SKShapeNode node];
    cloud1.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 65, 100, 40)].CGPath;
    cloud1.fillColor = [UIColor whiteColor];
    cloud1.strokeColor = [UIColor blackColor];
    [self.world addChild:cloud1];
    
    SKShapeNode *cloud2 = [SKShapeNode node];
    cloud2.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-250, 45, 100, 40)].CGPath;
    cloud2.fillColor = [UIColor whiteColor];
    cloud2.strokeColor = [UIColor blackColor];
    [self.world addChild:cloud2];*/
    
}


- (void)updateCount{
    
    count=0;
}




/*- (UIColor *)getRandomColor
{
    int rand = arc4random() % 6;
    
    UIColor *color;
    switch (rand) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor orangeColor];
            break;
        case 2:
            color = [UIColor yellowColor];
            break;
        case 3:
            color = [UIColor greenColor];
            break;
        case 4:
            color = [UIColor purpleColor];
            break;
        case 5:
            color = [UIColor blueColor];
            break;
            
        default:
            break;
    }
    return color;
}*/

@end

