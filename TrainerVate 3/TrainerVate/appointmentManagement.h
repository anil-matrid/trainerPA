//
//  appointmentManagement.h
//  TrainerVate
//
//  Created by Matrid on 20/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface appointmentManagement : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *table;

- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic)  NSMutableArray *pendingRequest;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
