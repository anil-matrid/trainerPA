//
//  Search Exercise Controller.h
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SearchExerciseController : UIViewController<MBProgressHUDDelegate>
- (IBAction)searchbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *searchbtn;

@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *resultTextFIeld;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
@end
