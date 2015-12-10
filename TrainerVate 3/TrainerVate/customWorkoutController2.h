//
//  customWorkoutController2.h
//  My Client- Workout
//
//  Created by Matrid on 02/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface customWorkoutController2 : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableVIew;
@property (strong, nonatomic) IBOutlet UIView *errorView;
- (IBAction)createbtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblmsg;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;


@end
