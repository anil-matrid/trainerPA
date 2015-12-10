//
//  forgetPassword.h
//  TrainerVate
//
//  Created by Matrid on 12/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface forgetPassword : UIViewController<MBProgressHUDDelegate>
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *email;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

@end
