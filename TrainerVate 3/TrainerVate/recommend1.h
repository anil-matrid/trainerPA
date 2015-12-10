//
//  recommend.h
//  TrainerVate
//
//  Created by Matrid on 29/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface recommend1 : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *labelToHide;
@property (weak, nonatomic) IBOutlet UIButton *recommends;
- (IBAction)recommends:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblRecommend;
@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) NSMutableArray *bundelID;

@end
