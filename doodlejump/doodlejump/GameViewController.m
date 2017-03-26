//
//  GameViewController.m
//  doodlejump
//
//  Created by 米拉 on 2/19/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()
//

@end
@implementation GameViewController
//@implementation GameView

@synthesize jumper, bricks;
@synthesize tilt;
@synthesize score;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    //playagain.hidden = YES;
    /*CADisplayLink * displayL = [CADisplayLink displayLinkWithTarget:_gameView2 selector:@selector(arrange:)];
     [displayL setPreferredFramesPerSecond:30];
     [displayL addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];*/
    
    //UIColor * colorgreen = [UIColor colorWithRed:(50.0/255.0) green:(205.0/255.0) blue:(50.0/255.0) alpha:(100.0/100.0)];
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        CGRect bounds = [self bounds];
        
        jumper = [[Jumper alloc] initWithFrame:CGRectMake(bounds.size.width/2, bounds.size.height - 20, 20, 20)];
        [jumper setBackgroundColor:[UIColor clearColor]];
        //[jumper setBackgroundColor:colorgreen];
        [jumper setDx:0];
        [jumper setDy:10];
        [self addSubview:jumper];
        [self makeBricks:nil];
        self.score.tag=0;
    }
    return self;
}

- (void) changeBricks{
    
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    UIColor * colorbrick = [UIColor colorWithRed:(135.0/255.0) green:(206.0/255.0) blue:(235.0/255.0) alpha:(100.0/100.0)];
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    int mark=2;
    for (int i = 0; i < 12; ++i)
    {
        Brick * b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        //[b setBackgroundColor:[UIColor clearColor]];
        [b setBackgroundColor:colorbrick];
        [self addSubview:b];
        [b setCenter:CGPointMake(arc4random()% (int)(bounds.size.width * .9), arc4random() % (int)(bounds.size.height * .9))];
        if(i==7) mark=1;
        [bricks addObject:b];
    }
    
    
    
}

-(IBAction)makeBricks:(id)sender
{
    CGRect bounds = [self bounds];
    float width = bounds.size.width * .2;
    float height = 20;
    UIColor * colorbrick = [UIColor colorWithRed:(135.0/255.0) green:(206.0/255.0) blue:(235.0/255.0) alpha:(100.0/100.0)];
    if (bricks)
    {
        for (Brick *brick in bricks)
        {
            [brick removeFromSuperview];
        }
    }
    
    bricks = [[NSMutableArray alloc] init];
    int mark=2;
    for (int i = 0; i < 12; ++i)
    {
        Brick * b = [[Brick alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        //[b setBackgroundColor:[UIColor clearColor]];
        [b setBackgroundColor:colorbrick];
        [self addSubview:b];
        [b setCenter:CGPointMake(arc4random()% (int)(bounds.size.width * .9), arc4random() % (int)(bounds.size.height * .9))];
        if(i==7) mark=1;
        [bricks addObject:b];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void)arrange:(CADisplayLink *)sender
{
    //CFTimeInterval ts = [sender timestamp];
    
    CGRect bounds = [self bounds];
    
    // Apply gravity to the acceleration of the jumper
    [jumper setDy:[jumper dy] - .3];
    
    // Apply the tilt.  Limit maximum tilt to + or - 5
    //NSLog(@"dx %f", (float)[jumper dx]);
    //  NSLog(@"dy %f", (float)[jumper dy]);
    // NSLog(@"tilt %f", (float)tilt);
    
    
    if (tilt > 0.5)
        [jumper setDx:5];
    if (tilt < 0.5)
        [jumper setDx:-5];
    
    // Jumper moves in the direction of gravity
    CGPoint p = [jumper center];
    p.x += [jumper dx];
    p.y -= [jumper dy];
    
    // If the jumper has fallen below the bottom of the screen,
    // add a positive velocity to move him
    if (p.y > bounds.size.height)
    {
        [jumper setDy:10];
        p.y = bounds.size.height;
    }
    
    // If we've gone past the top of the screen, wrap around
    if (p.y < 0){
        
        p.y += bounds.size.height;
        
        [self changeBricks];
        score.tag+=1000;
        [score setText:[NSString stringWithFormat:@"%ld",(long)score.tag]];
        
    }
    
    
    
    // If we have gone too far left, or too far right, wrap around
    if (p.x < 0)
        p.x += bounds.size.width;
    if (p.x > bounds.size.width)
        p.x -= bounds.size.width;
    
    // If we are moving down, and we touch a brick, we get
    // a jump to push us up.
    if ([jumper dy] < 0)
    {
        for (Brick *brick in bricks)
        {
            CGRect b = [brick frame];
            if (CGRectContainsPoint(b, p))
            {
                // Yay!  Bounce!
                self.score.tag+=500;
                [score setText:[NSString stringWithFormat:@"%ld",(long)score.tag]];
                NSLog(@"Bounce!");
                [jumper setDy:10];
            }
        }
    }
    
    [jumper setCenter:p];
    // NSLog(@"Timestamp %f", ts);
}

@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//@end
