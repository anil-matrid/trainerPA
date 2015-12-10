//
//  shopProductInfo.h
//  TrainerVate
//
//  Created by Matrid on 27/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface shopProductInfo : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productNAme;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productGoodFor;
@property (weak, nonatomic) IBOutlet UILabel *productGoodFor1;
@property (weak, nonatomic) IBOutlet UILabel *productGoodFor2;
@property (weak, nonatomic) IBOutlet UIButton *addTocart;
- (IBAction)addTo:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *productInfo;
@property (strong, nonatomic) NSString *uid;
//@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSDictionary *productData;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UIView *viewLblBack;

@end