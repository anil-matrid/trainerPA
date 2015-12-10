//
//  clientSideRecommendation.h
//  TrainerVate
//
//  Created by Matrid on 30/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface clientSideRecommendation : UIViewController<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
