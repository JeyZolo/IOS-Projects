//
//  GameVIew.h
//  doodlejump
//
//  Created by 米拉 on 2/18/17.
//  Copyright © 2017 米拉. All rights reserved.
//
#include <time.h>
#include <stdlib.h>
#import <UIKit/UIKit.h>
#import "Jumper.h"
#import "Brick.h"

@interface GameView : UIView {
    
     //AVAudioPlayer *_audioPlayer;//add sound
    
}
//@property (nonatomic, strong) IBOutlet GameView *gameView2;
@property (nonatomic,strong)IBOutlet UILabel  * score,* gameover,* highscore,* yourscore;
@property (nonatomic,strong)IBOutlet UIButton * replay;
@property (nonatomic, strong) Jumper *jumper;
@property (nonatomic, strong) NSMutableArray *bricks;
@property (nonatomic) float tilt;
//@property (nonatomic, strong) UISwpeGestureRecognizer * leftSwipeGesture;
//@property (nonatomic, strong) UISwpeGestureRecognizer * rightSwipeGesture;


-(void)arrange:(CADisplayLink *)sender;
//-(void)handleSwipes:(UISwipeGestureRecognizer *)sender;

@end /* GameVIew_h */
