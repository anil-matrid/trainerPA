///Users/matrid/Desktop/TrainerVate 2/TrainerVate.xcodeproj
//  SentToClientController.h
//  TrainerVate
//
//  Created by Matrid on 09/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface SentToClientController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myClientsList;
- (IBAction)backBtn:(id)sender;
- (IBAction)send:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ok;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *reminderView;
- (IBAction)setREminder:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *setREminder;
- (IBAction)finish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *finish;
@property (strong, nonatomic) NSString *preClass;
@property (strong, nonatomic) NSString *bundleName;
@property (strong, nonatomic) NSString *recommendId;

@end
