//
//  dietPlanCustomDietPlan.h
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface dietPlanCustomDietPlan : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UITextField *txtFeildSeacrh;
@property (weak, nonatomic) IBOutlet UITableView *tblCustomiseDietPlan;

@property (weak, nonatomic) IBOutlet UILabel *lblError;

- (IBAction)btnAdd:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)search:(id)sender;
@end
