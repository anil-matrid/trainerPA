//
//  ViewController.h
//  My Client- Workout
//
//  Created by Matrid on 21/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface workoutController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnYes;
@property (weak, nonatomic) IBOutlet UIButton *btnNo;

@property (weak, nonatomic) IBOutlet UIView *confirmationView;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)btnYes:(id)sender;
- (IBAction)btnNo:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;
- (IBAction)addBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
- (IBAction)librarybtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *librarybtn;
@property (strong, nonatomic) IBOutlet UIButton *custombtn;
- (IBAction)custombtn:(id)sender;
- (IBAction)crossbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *crossbtn;
@property (strong, nonatomic) IBOutlet UIView *messagebox;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *errorView1;
@property (weak, nonatomic) IBOutlet UILabel *errorLbl;
- (IBAction)ok:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *lblmsg;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) NSString *headerName;

@end
