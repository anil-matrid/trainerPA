//
//  recommend.h
//  TrainerVate
//
//  Created by Matrid on 29/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface recommend : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *labelToHide;
@property (weak, nonatomic) IBOutlet UIButton *recommends;
@property (weak, nonatomic) IBOutlet UIButton *yes;
- (IBAction)yes:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *no;
- (IBAction)no:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *warningView;
- (IBAction)recommends:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *blurdView;
@property (weak, nonatomic) IBOutlet UIView *recommendView;
@property (weak, nonatomic) IBOutlet UIButton *yourBundel;
- (IBAction)bundelSelection:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *premadeBundel;
@property (weak, nonatomic) IBOutlet UIButton *Bundle;
@property (weak, nonatomic) IBOutlet UITableView *tblRecommend;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
- (IBAction)cross:(id)sender;

@end
