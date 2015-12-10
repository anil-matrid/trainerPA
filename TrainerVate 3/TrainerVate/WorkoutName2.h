//
//  Workout Name 2.h
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReminderView.h"
#import "MBProgressHUD.h"

@interface WorkoutName2 : UIViewController<UITableViewDataSource,UITableViewDelegate,ReminderViewDelegate,MBProgressHUDDelegate>
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBAr;

@property (weak, nonatomic) IBOutlet UIView *viewApiPosterror;
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
@property (weak, nonatomic) IBOutlet UIView *viewForNoData;
- (IBAction)sendWorkoutbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sendWorkoutbtn;
- (IBAction)addbtn:(id)sender;
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (strong, nonatomic)  NSString *workoutName;
@property (strong, nonatomic) IBOutlet UIView *textBackground;
@property (strong, nonatomic) IBOutlet UITextField *textWorkoutName;
- (IBAction)okChangeName:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewDuplicate;
@property (weak, nonatomic) IBOutlet UILabel *lblMesage;

@property (weak, nonatomic) IBOutlet UIImageView *btnBg;
@property (weak, nonatomic) IBOutlet UILabel *viewToHide;
@property (weak, nonatomic) IBOutlet UILabel *lblWorkOutName;
@property (strong, nonatomic) IBOutlet UILabel *lblError;
@property (strong, nonatomic) IBOutlet UIView *successView;
- (IBAction)sucessReminderBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *successReminderBtn;
- (IBAction)finishBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendWorkout;
@property (weak, nonatomic) IBOutlet UIButton *addExercise;
@property (strong, nonatomic) NSString *exeName;
@end
