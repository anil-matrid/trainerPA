//
//  Workout Name.h
//  My Client- Workout
//
//  Created by Matrid on 24/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReminderView.h"
#import "MBProgressHUD.h"

@interface WorkoutName : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,ReminderViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
- (IBAction)backbtn:(id)sender;
- (IBAction)addbtn:(id)sender;
- (IBAction)editbtn:(id)sender;
- (IBAction)sendbtn:(id)sender;
@property (strong, nonatomic)  NSString *workoutName;
@property(strong,nonatomic) NSMutableDictionary *DicCurrentDic;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;

@property (weak, nonatomic) IBOutlet UIView *confirmationView;
- (IBAction)btnOk:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewMessages;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTOHide;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (weak, nonatomic) IBOutlet UILabel *lblmsg;
@property (strong,nonatomic) NSDictionary *ndict;
@property (weak, nonatomic) IBOutlet UIView *errorVIew;
@property (weak, nonatomic) IBOutlet UILabel *lblMessages;
@property (strong, nonatomic) IBOutlet UILabel *lblWorkout;




@end
