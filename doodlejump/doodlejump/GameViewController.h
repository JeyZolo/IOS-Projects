//
//  GameViewController.h
//  doodlejump
//
//  Created by 米拉 on 2/19/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <time.h>
#include <stdlib.h>
#import "Jumper.h"
#import "Brick.h"

@interface GameViewController : UIViewController
//@property (nonatomic, strong) IBOutlet GameView *gameView2;
@property (nonatomic,strong)IBOutlet UILabel  * score;

@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic) float tilt;

-(void)arrange:(CADisplayLink *)sender;

@end /* GameVIew_h */
//@end
