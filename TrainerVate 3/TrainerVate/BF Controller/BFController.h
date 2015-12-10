//
//  BFController.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface BFController : UIViewController<UITextFieldDelegate,MBProgressHUDDelegate>
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *bfArmR;
@property (strong, nonatomic) IBOutlet UITextField *bfArmL;
@property (strong, nonatomic) IBOutlet UITextField *bfLegR;
@property (strong, nonatomic) IBOutlet UITextField *bfLegL;
@property (weak, nonatomic) IBOutlet UIButton *okIfSuccess;

- (IBAction)next:(id)sender;
- (IBAction)txtResign:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UIView *viewBlured;
@property (weak, nonatomic) IBOutlet UIView *viewError;
- (IBAction)btnOk:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UIButton *ok;

@property (weak, nonatomic) IBOutlet UILabel *lblMessages;

- (IBAction)okIfSuccess:(id)sender;


@end