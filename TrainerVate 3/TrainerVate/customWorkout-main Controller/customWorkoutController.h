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
@property (strong, nonatomic) IBOutlet UIView *view2;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *textlabel;

@end
