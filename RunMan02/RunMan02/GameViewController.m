//
//  GameViewController.m
//  RunMan02
//
//  Created by 米拉 on 3/11/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3.png"]]];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [GameScene sceneWithSize:CGSizeMake(skView.frame.size.height, skView.frame.size.width)];
   scene.scaleMode = SKSceneScaleModeAspectFill;
   // NSlog:@"log2";
    NSLog(@"log2");


    // Present the scene.
    [skView presentScene:scene];}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end
