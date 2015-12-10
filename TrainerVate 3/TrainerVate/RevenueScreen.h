//
//  ViewController.h
//  SupplementsList
//
//  Created by Matrid on 17/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RevenueScreen : UIViewController<UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate> {
    
    __weak IBOutlet UILabel *totalRevenue;
    __weak IBOutlet UILabel *nextPayment;
    __weak IBOutlet UILabel *clientName;
    __weak IBOutlet UILabel *lastRevenue;
}
- (IBAction)revenueButton:(id)sender;
- (IBAction)historyButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIButton *revenueButton;
@property (strong, nonatomic) IBOutlet UIButton *historyButton;
@property (strong, nonatomic) IBOutlet UIView *historyView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
