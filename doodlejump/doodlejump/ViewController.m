//
//  ViewController.m
//  doodlejump
//
//  Created by 米拉 on 2/18/17.
//  Copyright © 2017 米拉. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()
//@synthesize score;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _displayLink = [CADisplayLink displayLinkWithTarget:_gameView selector:@selector(arrange:)];
    [_displayLink setPreferredFramesPerSecond:50];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
   /*/_gameView.leftSwipeGesture =[[UISwipeGestureRecognizer alloc] initWithTarget:[_gameView action:@selector(handleSwipes:)];
                                 
    //_gameView.rightSwipeGesture =[[UISwipeGestureRecognizer alloc] initWithTarget:[_gameView action:@selector(handleSwipes:)];
    //_gameView.leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    //_gameView.rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
                                  
         
                                  
    [_gameView.view addGestureRecognizer: self.leftSwipeGesture];
                                  
     [_gameView.view addGestureRecognizer: self.rightSwipeGesture];*/
                                  
                                  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)speedChange:(id)sender
{
    UISlider *s = (UISlider *)sender;
    // NSLog(@"tilt %f", (float)[s value]);
    [_gameView setTilt:(float)[s value]];
}

@end
