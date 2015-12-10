//
//  recommendShopController.h
//  TrainerVate
//
//  Created by Matrid on 25/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface recommendShopController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lablQty;
- (IBAction)btnCart:(id)sender;
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
//@property (weak, nonatomic) IBOutlet UITableView *tblSupplements;
@property (weak, nonatomic) IBOutlet UIView *viewLblBack;
@property (weak, nonatomic) IBOutlet UIButton *add;
//@property (weak, nonatomic) NSString *dietPlanIndexPath;
- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cart;
@property (strong, nonatomic) IBOutlet NSString *preClass;
@property (strong, nonatomic)  NSString *uid;
@property (strong, nonatomic) NSString *name;



@end
