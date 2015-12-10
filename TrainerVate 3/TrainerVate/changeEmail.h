//
//  changeEmail.h
//  TrainerVate
//
//  Created by Matrid on 12/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface changeEmail : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIView *emailBg;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIView *EmailBg1;
@property (weak, nonatomic) IBOutlet UITextField *Email1;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *passwordBg;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *currentCode;
@property (weak, nonatomic) IBOutlet UIView *currentCodeBg;
@property (weak, nonatomic) IBOutlet UITextField *emailNewCode;
@property (weak, nonatomic) IBOutlet UIView *emailNewCodeBg;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMesage;
@property (strong, nonatomic) NSString *Current;
@property (strong, nonatomic) NSString *latest;
@property (strong, nonatomic) IBOutlet UILabel *lblError;

@end
