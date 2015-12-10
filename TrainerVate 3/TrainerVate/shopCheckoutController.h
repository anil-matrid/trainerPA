//
//  setRecommendReminder.h
//  TrainerVate
//
//  Created by Matrid on 31/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Constants.h"

@interface shopCheckoutController : UIViewController<UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate>


@property (weak, nonatomic) IBOutlet UIView *viewPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblMessages;
- (IBAction)cross:(id)sender;

//outlets
@property (weak, nonatomic) IBOutlet UITableView *reminderProductTable;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productQty;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *productInfoView;
@property (weak, nonatomic) IBOutlet UIView *viewLblBack;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblError;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViews;
@property (weak, nonatomic) IBOutlet UIView *ViewError;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;


//buttons
- (IBAction)btnBasketForAll:(id)sender;
- (IBAction)btnIncrease:(id)sender;
- (IBAction)btnDecrease:(id)sender;
@end
