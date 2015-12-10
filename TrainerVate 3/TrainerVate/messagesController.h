//
//  messagesController.h
//  TrainerVate
//
//  Created by Matrid on 29/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface messagesController : UIViewController<MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)back:(id)sender;
//@property (weak, nonatomic) IBOutlet UITableView *tblClientList;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
