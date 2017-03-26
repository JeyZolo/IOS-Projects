//
//  ViewController.h
//  flashlight
//
//  Created by 米拉 on 2/28/17.
//  Copyright © 2017 米拉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ViewController : UIViewController <UITextFieldDelegate>

//@end
//@interface YourViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic,strong)IBOutlet UILabel  *displayB;
@property (weak, nonatomic) IBOutlet UIButton *send,*stop;
@property (weak, nonatomic) IBOutlet UITextField *Textbox;



- (IBAction)PressSend:(id)sender;
-(IBAction)stopBlinking:(id)sender;


@end

