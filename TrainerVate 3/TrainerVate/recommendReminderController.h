//
//  recommendReminderController.h
//  TrainerVate
//
//  Created by Matrid on 03/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface recommendReminderController : UIViewController<MBProgressHUDDelegate>

//iboutlets

@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UITextView *lblDis;
@property (weak, nonatomic) IBOutlet UIButton *mon;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UILabel *errorLbl;
@property (weak, nonatomic) IBOutlet UIButton *tue;
@property (weak, nonatomic) IBOutlet UIButton *wed;
@property (weak, nonatomic) IBOutlet UIButton *thu;
@property (weak, nonatomic) IBOutlet UIButton *fri;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UIButton *sat;
@property (weak, nonatomic) IBOutlet UIButton *sun;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerQty;
@property (weak, nonatomic) IBOutlet UIButton *days;
@property (weak, nonatomic) IBOutlet UIButton *timePerDay;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *timePickerView;
@property (weak, nonatomic) IBOutlet UIButton *setTime;
@property (weak, nonatomic) IBOutlet UIButton *setTime1;
@property (weak, nonatomic) IBOutlet UIButton *setTime2;
@property (weak, nonatomic) IBOutlet UIButton *doneReminder;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (weak, nonatomic) IBOutlet UIButton *skip;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *time3;
@property (weak, nonatomic) IBOutlet UILabel *hide1;
@property (weak, nonatomic) IBOutlet UILabel *hide2;
@property (weak, nonatomic) IBOutlet UILabel *hide3;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic) NSString *bundelName;
@property (strong, nonatomic) NSMutableArray *clientID;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (strong, nonatomic) NSString *uidStr;

@property (weak, nonatomic) IBOutlet UIView *setTimeView2;
@property (weak, nonatomic) IBOutlet UIView *setTimeView3;



//buttons

- (IBAction)screenBtns:(id)sender;
- (IBAction)btnDays:(id)sender;
- (IBAction)btnPicker:(id)sender;

@end
