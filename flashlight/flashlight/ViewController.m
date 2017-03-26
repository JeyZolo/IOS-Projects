//
//  ViewController.m
//  flashlight
//
//  Created by 米拉 on 2/28/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Textbox;
@synthesize displayB;
@synthesize send,stop;
static bool haltBlinking = true;

- (void)viewDidLoad {
    
  
    [super viewDidLoad];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //NSLog(@"hi");
    [textField resignFirstResponder];
    self.Textbox.delegate = self;

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handlelight:(char) t
{
    int binary= (int) t;
    int i=0,mark=0;
    AVCaptureDevice * captDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];

    if ([captDevice hasFlash]&&[captDevice hasTorch]) {
        
        while(i<8&&haltBlinking){
            
            mark=binary & 128;
            binary=binary<<1;
            
            i++;
            NSLog(@"%d",mark);
            
            // mark=1;
            if(mark==128){
                self.displayB.text=@"1";
                displayB.tag=1;
                
                [captDevice lockForConfiguration:nil];
                [captDevice setTorchMode:AVCaptureTorchModeOn];
                [captDevice unlockForConfiguration];
               // sleep(3);
     
            }
            
            else{
                displayB.tag=0;
                self.displayB.text=@"0";

                [captDevice lockForConfiguration:nil];
                [captDevice setTorchMode:AVCaptureTorchModeOff];
                [captDevice unlockForConfiguration];
                                
            }
          
            [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.5]];
            sleep(3);
       
        }
   
    }
    //================end===============================
    if(!haltBlinking)    self.displayB.text=@"0";

    [captDevice lockForConfiguration:nil];
    [captDevice setTorchMode:AVCaptureTorchModeOff];
    [captDevice unlockForConfiguration];
    

}

- (IBAction)PressSend:(id)sender {
    //self.displayB.text=@"hi";
    
    haltBlinking = true;
    self.displayB.text=@"0";

    NSString *Text = [Textbox text];
    int j=0;
    const char *c = [Text UTF8String];
    while(j<[Text length]&&haltBlinking){
        NSLog(@"%c",c[j]);
        [self handlelight:c[j]];
       j++;
        
    }

  }


-(IBAction)stopBlinking:(id)sender
{
    haltBlinking = false;
    
}
/*- (IBAction)touchLight:(id)sender {
 [self turnTorchOn:1];
 }
 
 - (void) turnTorchOn: (bool) on {
 
 // check if flashlight available
 Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
 if (captureDeviceClass != nil) {
 AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
 if ([device hasTorch] && [device hasFlash]){
 
 [device lockForConfiguration:nil];
 if (on) {
 [device setTorchMode:AVCaptureTorchModeOn];
 [device setFlashMode:AVCaptureFlashModeOn];
 //torchIsOn = YES; //define as a variable/property if you need to know status
 } else {
 [device setTorchMode:AVCaptureTorchModeOff];
 [device setFlashMode:AVCaptureFlashModeOff];
 //torchIsOn = NO;
 }
 [device unlockForConfiguration];
 }
 } }
 */

@end
