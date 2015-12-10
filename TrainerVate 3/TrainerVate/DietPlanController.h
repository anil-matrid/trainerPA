//
//  DietPlanController.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface DietPlanController : UIViewController <UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) NSMutableArray *discriptions;
@property (strong, nonatomic) NSMutableArray *titles;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (strong, nonatomic) NSMutableArray *images;
//@property (strong, nonatomic) IBOutlet UITableView *dietPlan;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *addDietPlanView;
- (IBAction)Library:(id)sender;
- (IBAction)workout:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Library;
@property (strong, nonatomic) IBOutlet UIButton *workout;
- (IBAction)addNewDietPlan:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)BtnCrossPopView:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *errorVIewDIetPlan;
@property (strong, nonatomic) IBOutlet UIView *confirmationView;
- (IBAction)yes:(id)sender;
- (IBAction)no:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *yes;
@property (strong, nonatomic) IBOutlet UIButton *no;



@end
