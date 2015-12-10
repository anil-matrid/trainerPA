//
//  SetReminderController.h
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SetReminderController : UIViewController<MBProgressHUDDelegate>
//outlets..........

@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *reminderWeight;
@property (weak, nonatomic) IBOutlet UIButton *reminderWaistSize;
@property (weak, nonatomic) IBOutlet UIButton *reminderBodyFat;
@property (weak, nonatomic) IBOutlet UIButton *reminderArmSize;
@property (weak, nonatomic) IBOutlet UIButton *reminderLegSize;
@property (weak, nonatomic) IBOutlet UIButton *reminderWater;
@property (weak, nonatomic) IBOutlet UIButton *reminderChestSize;
@property (weak, nonatomic) IBOutlet UIButton *reminderPhysicalrating;
@property (weak, nonatomic) IBOutlet UIButton *reminderBoneMass;
@property (weak, nonatomic) IBOutlet UILabel *lblViewTitle;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UIButton *skip;
@property (weak, nonatomic) IBOutlet UIButton *next;

//buttons.........
- (IBAction)done:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)reminder:(id)sender;
@end