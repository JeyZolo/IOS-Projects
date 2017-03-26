//
//  GameScene.m
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "GameScene.h"
#import "MLHero.h"
#import "MLWorldGenerator.h"
#import "MLPointsLabel.h"
#import "GameData.h"


@interface GameScene ()
@property BOOL isStarted;
@property BOOL isGameOver;
@end

@implementation GameScene
{
    MLHero *hero;
    SKNode *world;
    MLWorldGenerator *generator;
}
int mark=0;
static NSString *GAME_FONT = @"AmericanTypewriter-Bold";

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        mark++;
        /* Setup your scene here */
        self.anchorPoint = CGPointMake(0.5, 0.5);
        self.physicsWorld.contactDelegate = self;
       
        SKSpriteNode *sn = [SKSpriteNode spriteNodeWithImageNamed:@"CloudsBG.jpg"];
        sn.size = self.frame.size;
        sn.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
       sn.name = @"CloudsBG";
    //NSlog:@"log1";
        NSLog(@"log1");
        [self addChild:sn];
        
        if(mark==1){
        SKLabelNode *gameLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
        gameLabel.text = @"Hedgehog Running!";
        gameLabel.fontColor = [UIColor yellowColor];

        gameLabel.position = CGPointMake(0, 50);
        gameLabel.name=@"header";
        
        gameLabel.fontSize = 30;
            [self addChild:gameLabel];
        }
        [self createContent];
    }
    return self;
}

- (void)createContent
{
    //self.backgroundColor = [SKColor colorWithRed:0.54 green:0.7853 blue:1.0 alpha:1.0];
    
    self.backgroundColor = [SKColor colorWithRed:(176.0/255.0) green:(224.0/255.0) blue:(230.0/255.0) alpha:(100.0/100.0)];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3.png"]]];

    
    world = [SKNode node];
    [self addChild:world];
    
    generator = [MLWorldGenerator generatorWithWorld:world];
    [self addChild:generator];
    [generator populate];
    
    hero = [MLHero hero];
    [world addChild:hero];
    
    [self loadScoreLabels];
    
   
    
    SKLabelNode *tapToBeginLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToBeginLabel.name = @"tapToBeginLabel";
    tapToBeginLabel.text = @"tap to begin";
    tapToBeginLabel.fontSize = 20.0;
    tapToBeginLabel.fontColor = [UIColor whiteColor];
    [self addChild:tapToBeginLabel];
    [self animateWithPulse:tapToBeginLabel];
    
   // [self loadClouds];
}

- (void)loadScoreLabels
{
    MLPointsLabel *pointsLabel = [MLPointsLabel pointsLabelWithFontNamed:GAME_FONT];
    pointsLabel.name = @"pointsLabel";
    pointsLabel.position = CGPointMake(-150, 80);
    [self addChild:pointsLabel];
    
    GameData *data = [GameData data];
    [data load];
    
    MLPointsLabel *highscoreLabel = [MLPointsLabel pointsLabelWithFontNamed:GAME_FONT];
    highscoreLabel.name = @"highscoreLabel";
    highscoreLabel.position = CGPointMake(150, 80);
    [highscoreLabel setPoints:data.highscore];
    [self addChild:highscoreLabel];
    
    SKLabelNode *bestLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    bestLabel.text = @"best";
    bestLabel.fontSize = 16.0;
    bestLabel.fontColor = [UIColor whiteColor];
    bestLabel.position = CGPointMake(-50, 0);
    [highscoreLabel addChild:bestLabel];
}

/*- (void)loadClouds
{
    SKShapeNode *cloud1 = [SKShapeNode node];
    cloud1.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 65, 100, 40)].CGPath;
    cloud1.fillColor = [UIColor whiteColor];
    cloud1.strokeColor = [UIColor blackColor];
    [world addChild:cloud1];
    
    SKShapeNode *cloud2 = [SKShapeNode node];
    cloud2.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-250, 45, 100, 40)].CGPath;
    cloud2.fillColor = [UIColor whiteColor];
    cloud2.strokeColor = [UIColor blackColor];
    [world addChild:cloud2];
    
}*/

- (void)start
{
    self.isStarted = YES;
    [[self childNodeWithName:@"tapToBeginLabel"] removeFromParent];
    [[self childNodeWithName:@"header"] removeFromParent];
    [hero start];
}

- (void)clear
{
    GameScene *scene = [[GameScene alloc] initWithSize:self.frame.size];
    [[self childNodeWithName:@"header"] removeFromParent];

    [self.view presentScene:scene];
}

- (void)gameOver
{
    self.isGameOver = YES;
    [hero stop];
    [self runAction:[SKAction playSoundFileNamed:@"S3K_3E.wav" waitForCompletion:NO]];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 30;

    gameOverLabel.fontColor = [UIColor whiteColor];

    gameOverLabel.position = CGPointMake(0, 20);
    [self addChild:gameOverLabel];
    
    SKLabelNode *tapToResetLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToResetLabel.name = @"tapToResetLabel";
    tapToResetLabel.text = @"tap to reset";
    tapToResetLabel.fontColor = [UIColor whiteColor];
    tapToResetLabel.fontSize = 20.0;
    [self addChild:tapToResetLabel];
    [self animateWithPulse:tapToResetLabel];
    
    [self updateHighscore];
    [generator updateCount];
    [[self childNodeWithName:@"header"] removeFromParent];


}

- (void)updateHighscore
{
    MLPointsLabel *pointsLabel = (MLPointsLabel *)[self childNodeWithName:@"pointsLabel"];
    MLPointsLabel *highscoreLabel = (MLPointsLabel *)[self childNodeWithName:@"highscoreLabel"];
    
    pointsLabel.fontColor = [UIColor whiteColor];
    highscoreLabel.fontColor = [UIColor whiteColor];


    
    if (pointsLabel.number > highscoreLabel.number) {
        [highscoreLabel setPoints:pointsLabel.number];
        
        GameData *data = [GameData data];
        data.highscore = pointsLabel.number;
        [data save];
       // [generator generate2Obstacle];
    }
   
    
    
}

- (void)didSimulatePhysics
{
    [self centerOnNode:hero];
    [self handlePoints];
    [self handleGeneration];
    [self handleCleanup];
}

- (void)handlePoints
{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x) {
            MLPointsLabel *pointsLabel = (MLPointsLabel *)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel increment];
        }
    }];
}

- (void)handleGeneration
{
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x) {
            node.name = @"obstacle_cancelled";
            [generator generate];
            //[self loadClouds];
        }
    }];
}

- (void)handleCleanup
{
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    [world enumerateChildNodesWithName:@"clouds" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"obstacle_cancelled" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
}




- (void)centerOnNode:(SKNode *)node
{
    
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.isStarted)
        [self start];
    else if (self.isGameOver)
        [self clear];
    else
        [hero jump];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if ([contact.bodyA.node.name isEqualToString:@"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"]) {
        [hero land];
    } else {
        [self gameOver];
    }
}

// ** ANIMATION SECTION ** //
- (void)animateWithPulse:(SKNode *)node
{
    SKAction *disappear = [SKAction fadeAlphaTo:0.0 duration:0.6];
    SKAction *appear = [SKAction fadeAlphaTo:1.0 duration:0.6];
    SKAction *pulse = [SKAction sequence:@[disappear, appear]];
    [node runAction:[SKAction repeatActionForever:pulse]];
}


@end

