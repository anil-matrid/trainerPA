//
//  SetReminderController3.h
//  TrainerVate
//
//  Created by Matrid on 22/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface SetReminderController3 : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reminder3;
- (IBAction)reminder:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reminder3WaistSize;

@property (weak, nonatomic) IBOutlet UIButton *reminder3BodyFat;

@property (weak, nonatomic) IBOutlet UIButton *reminder3ArmSize;

@property (weak, nonatomic) IBOutlet UIButton *reminder3LegSize;

@property (weak, nonatomic) IBOutlet UIButton *reminder3Water;

@property (weak, nonatomic) IBOutlet UIButton *reminder3ChestSize;

@property (weak, nonatomic) IBOutlet UIButton *reminder3PhysicalRating;

@property (weak, nonatomic) IBOutlet UIButton *reminder3BoneMass;

- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *done;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblViewTitle;

@end
