//
//  EditReminderController.h
//  My Client- Workout
//
//  Created by Matrid on 03/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditReminderController : UIViewController
- (IBAction)pickerBtns:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)addBtn:(id)sender;
- (IBAction)daysbtns:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sun;
@property (strong, nonatomic) IBOutlet UIButton *sat;
@property (strong, nonatomic) IBOutlet UIButton *fri;
@property (strong, nonatomic) IBOutlet UIButton *wed;

@property (strong, nonatomic) IBOutlet UIButton *thu;
@property (strong, nonatomic) IBOutlet UIButton *mon;
@property (strong, nonatomic) IBOutlet UIButton *tue;
@property (strong, nonatomic) IBOutlet UIButton *addbtn;
- (IBAction)donebtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *donebtn;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (strong, nonatomic) IBOutlet UIButton *daysbtn;
@property (strong, nonatomic) IBOutlet UIButton *occurencebtn;
@property (strong, nonatomic) IBOutlet UIButton *setTime1;
@property (strong, nonatomic) IBOutlet UIButton *setTime2;
@property (strong, nonatomic) IBOutlet UIButton *setTime3;
@property (strong, nonatomic) IBOutlet UIView *view2;

@end
