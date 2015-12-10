//
//  recommendBundleEditing.h
//  TrainerVate
//
//  Created by Matrid on 04/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface recommendBundleEditing : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblRecommendeBundle;
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (weak, nonatomic) IBOutlet UIView *viewInfoProduct;

@property (weak, nonatomic) IBOutlet UIView *viewBlured;
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UIButton *save;
@property (weak, nonatomic) IBOutlet UIButton *saveSend;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) NSString *preScreen;
- (IBAction)btnOk:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ok;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
- (IBAction)cross:(id)sender;
@property (strong, nonatomic) NSString *bundelName;
@property (strong, nonatomic) NSString *RecommendID;
@property BOOL isClient;

@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *reminerView;
- (IBAction)setREminder:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *setREminder;
- (IBAction)finish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *finish;

- (IBAction)btnBottom:(id)sender;
- (IBAction)btnIncrease:(id)sender;
- (IBAction)btnDecrease:(id)sender;
- (IBAction)btnAll:(id)sender;

@end
