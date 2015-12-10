//
//  removeClients.h
//  TrainerVate
//
//  Created by Matrid on 08/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface removeClients : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView2;
- (IBAction)optionsBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
- (IBAction)navBtn:(id)sender;
- (IBAction)connectBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *connectBtn;
@property (strong, nonatomic) IBOutlet UIButton *disconnectBtn;
- (IBAction)disconnectBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end
