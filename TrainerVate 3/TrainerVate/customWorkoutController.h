//
//  customWorkoutController.h
//  My Client- Workout
//
//  Created by Matrid on 31/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customWorkoutController : UIViewController
- (IBAction)nextbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextbtn;
@property (strong, nonatomic) IBOutlet UITextField *textField;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewTextBg;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
