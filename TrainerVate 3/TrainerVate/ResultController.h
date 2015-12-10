//
//  ResultController.h
//  My Client- Workout
//
//  Created by Matrid on 01/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ResultController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViews;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *resultTextField;
- (IBAction)resultSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;



@end
