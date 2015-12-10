//
//  clearChatTrainer.h
//  TrainerVate
//
//  Created by Matrid on 10/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface clearChatTrainer : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableVIew3;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (strong, nonatomic) IBOutlet UIView *view2;
- (IBAction)todayBtn:(id)sender;
- (IBAction)monthBtn:(id)sender;
- (IBAction)allBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *todayBtn;
- (IBAction)crossBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *warningView;
- (IBAction)yes:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *yes;
@property (weak, nonatomic) IBOutlet UIButton *no;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)okError:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UIView *view4;

@end
