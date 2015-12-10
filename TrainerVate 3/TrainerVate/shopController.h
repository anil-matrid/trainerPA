//
//  shopController.h
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface shopController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>


//@property (strong, nonatomic) IBOutlet UITableView *tblShop;
- (IBAction)back:(id)sender;
- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UIView *viewLblBack;
@property (weak, nonatomic) IBOutlet UIButton *btnCart;
@property (weak, nonatomic)  NSString *preClass;

@end
