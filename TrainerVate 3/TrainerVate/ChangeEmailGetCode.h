//
//  ChangeEmailGetCode.h
//  TrainerVate
//
//  Created by Matrid on 12/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface ChangeEmailGetCode : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIView *emailBg;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMesage;
@property (weak, nonatomic) IBOutlet UITextField *emailNew;
@property (weak, nonatomic) IBOutlet UIView *emailNewBg;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;

@end

