//
//  TraineeregisterController.h
//  TrainerVate
//
//  Created by Matrid on 08/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraineeregisterController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *trainnePhoneNum;
@property (strong, nonatomic) IBOutlet UITextField *traineeEmail;
@property (strong, nonatomic) IBOutlet UITextField *traineePassword;
@property (strong, nonatomic) IBOutlet UITextField *traineeGymCode;
- (IBAction)backMainScreen:(id)sender;

- (IBAction)next:(id)sender;
- (IBAction)termsCondition:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *termsCondition;

@end
