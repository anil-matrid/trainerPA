//
//  MyStats.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"


@interface MyStats : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UILabel *visceralFat;
- (IBAction)addBodyStats:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableGraph;




@end
