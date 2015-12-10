//
//  SetReminderController2.h
//  TrainerVate
//
//  Created by Matrid on 22/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SetReminderController2 : UIViewController<MBProgressHUDDelegate>

//outlets
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UILabel *lblViewTitle;
@property (weak, nonatomic) IBOutlet UIButton *reminder2Reminder;
@property (weak, nonatomic) IBOutlet UIButton *reminder2WaistSize;
@property (weak, nonatomic) IBOutlet UIButton *reminder2BodyFat;
@property (weak, nonatomic) IBOutlet UIButton *reminder2ArmSize;
@property (weak, nonatomic) IBOutlet UIButton *reminder2LegSize;
@property (weak, nonatomic) IBOutlet UIButton *reminder2Water;
@property (weak, nonatomic) IBOutlet UIButton *reminder2ChestSize;
@property (weak, nonatomic) IBOutlet UIButton *reminder2PhysicalRating;
@property (weak, nonatomic) IBOutlet UIButton *reminder2BoneMass;
@property (weak, nonatomic) IBOutlet UIButton *skip;
@property (weak, nonatomic) IBOutlet UIButton *next;

//buttons
- (IBAction)back:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)next:(id)sender;


@end
