//
//  CreateNewDietPlanController.h
//  TrainerVate
//
//  Created by Matrid on 18/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CreateNewDietPlanController : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtDietName;
@property (weak, nonatomic) IBOutlet UIView *viewTextBg;
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@end
