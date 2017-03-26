//
//  GameVIew.m
//  doodlejump
//
//  Created by 米拉 on 2/18/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "GameView.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface GameView(){
    AVAudioPlayer *_audioPlayer;
    AVAudioPlayer *_groudaudio;
    
}
@end

@implementation GameView
@synthesize jumper, bricks;
@synthesize tilt;
@synthesize score,replay,yourscore,highscore,gameover;


-(id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CGRect bounds = [self bounds];
        
       jumper= [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width, bounds.size.height, 40, 45)];
        //jumper= [[Jumper alloc] initWithFrame:CGRectMake(40, 50, 35, 35)];
        
       // [jumper setBackgroundColor:[UIColor blueColor]];
        UIImage *image = [UIImage imageNamed:@"doodle8.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame=jumper.bounds;
        [jumper addSubview:imageView];
        
        [jumper sizeToFit];
        
        [jumper setDx:0];
        [jumper setDy:10];
        [self addSubview:jumper];
        [self makeBricks:nil];
        self.score.tag=0;
        highscore.tag=0;
        yourscore.tag=0;
        gameover.tag=0;
        
        
        
        // Construct URL to sound file
        NSString *path = [NSString stringWithFormat:@"%@/collect.mp3", [[NSBundle mainBundle] resourcePath]];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        
        
        // Create audio player object and initialize with URL to sound
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        
        
        NSString *path2 = [NSString stringWithFormat:@"%@/springshoes.mp3", [[NSBundle mainBundle] resourcePath]];
        NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
        
        
        // Create audio player object and initialize with URL to sound
        _groudaudio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    }
    return self;
}


/*-(void)handleSwipes:(UISwipeGestureRecognizer *)sender{
    
    if(sender.direction = UISwipeGestureRecognizerDirectionRight){
        
    }
    
    if(sender.direction = UISwipeGestureRecognizerDirectionLeft){
        
    }
}*/


- (void) changeBricks{
    
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    //UIColor * colorbrick = [UIColor colorWithRed:(135.0/255.0) green:(206.0/255.0) blue:(235.0/255.0) alpha:(100.0/100.0)];
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    int mark=2;
    int H=bounds.size.height* .08;
    for (int i = 0; i < 10; ++i)
    {
        Brick * b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        //[b setBackgroundColor:[UIColor clearColor]];
        UIImage *image = [UIImage imageNamed:@"bricks.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame=b.bounds;
        
        [b addSubview:imageView];
        //[b setBackgroundColor:colorbrick];
        [self addSubview:b];
        //[b setCenter:CGPointMake(arc4random()% (int)(bounds.size.width * .6), arc4random() % (int)(bounds.size.height * .8))];
        [b setCenter:CGPointMake(arc4random()% (int)(bounds.size.width * .6),(i+1)* H)];
                                 //H=2*H;

        if(i==7) mark=1;
        [bricks addObject:b];
    }

    
    
}


- (void) disBricks{
    
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    
}
-(IBAction)tryagain:(id)sender
{
    gameover.tag=0;
    score.tag=0;
    [score setText:@"0"];
    yourscore.hidden = YES;
    highscore.hidden = YES;
    replay.hidden = YES;
    gameover.hidden = YES;
    score.hidden = NO;
    
    [self changeBricks];
    //[jumper setBackgroundColor:[UIColor blueColor]];
}



-(IBAction)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
   // UIColor * colorbrick = [UIColor colorWithRed:(135.0/255.0) green:(206.0/255.0) blue:(235.0/255.0) alpha:(100.0/100.0)];
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    int mark=2;
    int H=bounds.size.height* .08;

    for (int i = 0; i < 12; ++i)
    {
        Brick * b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        //[b setBackgroundColor:[UIColor clearColor]];
         //[b setBackgroundColor:colorbrick];
        UIImage *image = [UIImage imageNamed:@"bricks.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        [b addSubview:imageView];
        [self addSubview:b];
        [b setCenter:CGPointMake(arc4random()% (int)(bounds.size.width * .9), (i+1)*H)];
        if(i==7) mark=1;
        [bricks addObject:b];
    }
}

/*- (void)mouseDown:(NSEvent *)theEvent {
    // Get the mouse location in window coordinates.
    begin = [theEvent locationInWindow];
}*/


-(void)arrange:(CADisplayLink *)sender
{
    //CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
    // Apply the tilt.  Limit maximum tilt to + or - 5
    //NSLog(@"dx %f", (float)[jumper dx]);
    //NSLog(@"dy %f", (float)[jumper dy]);
   // NSLog(@"tilt %f", (float)tilt);

    if(gameover.tag==10) return;
    UIImage *image = [UIImage imageNamed:@"doodle3.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    if (tilt > 0.5){
       
        imageView.frame=jumper.bounds;
        [jumper addSubview:imageView];
        
        [jumper sizeToFit];

        
        
         [jumper setDx:5];
        
    }
       
    if (tilt < 0.5){
        image = [UIImage imageNamed:@"doodle8.png"];
        imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame=jumper.bounds;
        [jumper addSubview:imageView];
        
        [jumper sizeToFit];
        [jumper setDx:-5];
        
    }
        
    
    // Jumper moves in the direction of gravity
    CGPoint p = [jumper center];
    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    // If the jumper has fallen below the bottom of the screen,
    // add a positive velocity to move him
    if (p.y > bounds.size.height-10)
    {       NSLog(@"p.y=dx %f", (float)p.y);
            NSLog(@"bound=dx %f", (float)bounds.size.height);
        [_groudaudio play];
        [jumper setDy:10];
        gameover.tag++;
        //score.tag-=1500;
        if(gameover.tag>3){
            gameover.tag=10;
            yourscore.hidden =NO;
            highscore.hidden = NO;
            replay.hidden = NO;
            gameover.hidden = NO;
            score.hidden = YES;
            yourscore.tag=score.tag;
            if(highscore.tag<yourscore.tag)
                highscore.tag=yourscore.tag;
            [yourscore setText:[NSString stringWithFormat:@"Your Score:%ld",(long)score.tag]];
            [highscore setText:[NSString stringWithFormat:@"High Score:%ld",(long)highscore.tag]];

            
            
            NSLog(@"game over!");
            [self disBricks];
            //[jumper setBackgroundColor:clearcolor];
            [jumper setBackgroundColor:[UIColor clearColor]];
            p.y = bounds.size.height-20;

            [jumper setCenter:p];

            return ;
        }
        
        [score setText:[NSString stringWithFormat:@"%ld",(long)score.tag]];

        p.y = bounds.size.height-10;
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < 0){
    
        p.y += bounds.size.height;
        
         [self changeBricks];
        score.tag+=1000;
        gameover.tag+=1;
        [score setText:[NSString stringWithFormat:@"%ld",(long)score.tag]];
        [jumper setDy:10];
    }
    
        
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0){
        p.x += bounds.size.width;
        //[self changeBricks];
    
    }
        
    if (p.x > bounds.size.width){
        p.x -= bounds.size.width;
        //[self changeBricks];
    }
      
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {

        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
            if (CGRectContainsPoint(b, p))
            {   [_audioPlayer play];
                // Yay!  Bounce!
                self.score.tag+=500;
                [score setText:[NSString stringWithFormat:@"%ld",(long)score.tag]];
                NSLog(@"Bounce!");
                [jumper setDy:10];
            }
        }
    }
    //p.y-=10;
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}

@end

