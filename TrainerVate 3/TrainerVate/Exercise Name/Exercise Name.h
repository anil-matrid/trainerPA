//
//  Exercise Name.h
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exercise_Name : UIViewController
- (IBAction)savebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *savebtn;
- (IBAction)removebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *removebtn;
- (IBAction)addbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addbtn;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtfield1;
@property (strong, nonatomic) IBOutlet UITextField *textfield2;
@property (strong, nonatomic) IBOutlet UITextField *textfield3;
@property (strong, nonatomic) IBOutlet UITextField *textfield4;

@end
