//
//  AccountTypeController.h
//  TrainerVate
//
//  Created by Matrid on 08/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ReminderView.h"

@interface AccountTypeController : UIViewController

{

    IBOutlet UIButton *BtnTrainer;
    IBOutlet UIButton *BtnClient;
    IBOutlet  UIImageView *splashImageView;
    IBOutlet UIView *splashView;

}
- (IBAction)trainner:(id)sender;
- (IBAction)trainne:(id)sender;
@property (nonatomic, strong) AVPlayer *player;


@end
