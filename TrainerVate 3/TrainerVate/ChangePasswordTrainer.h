//
//  ChangePasswordTrainer.h
//  TrainerVate
//
//  Created by Matrid on 10/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ChangePasswordTrainer : UIViewController<MBProgressHUDDelegate>
- (IBAction)submitBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtField1;
@property (strong, nonatomic) IBOutlet UITextField *txtField2;
@property (strong, nonatomic) IBOutlet UITextField *txtField3;
- (IBAction)backBtn:(id)sender;
- (IBAction)okBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *blurredVIew;
@property (weak, nonatomic) IBOutlet UIView *textBg;
@property (weak, nonatomic) IBOutlet UIView *textBg2;
@property (weak, nonatomic) IBOutlet UIView *textBg3;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
