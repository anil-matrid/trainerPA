//
//  forgot password.h
//  TrainerVate
//
//  Created by Matrid on 17/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface forgotPasswordConfirmaion : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txt1;
@property (weak, nonatomic) IBOutlet UITextField *txt2;
@property (weak, nonatomic) IBOutlet UITextField *txt3;
@property (weak, nonatomic) IBOutlet UITextField *txt4;
@property (weak, nonatomic) IBOutlet UILabel *txt1bg;
- (IBAction)submitBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *txt3bg;
@property (weak, nonatomic) IBOutlet UILabel *txt2bg;
@property (weak, nonatomic) IBOutlet UILabel *txt4bg;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;
@property (strong, nonatomic) NSString *email;
@end
