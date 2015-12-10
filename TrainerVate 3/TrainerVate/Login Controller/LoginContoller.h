//
//  LoginContoller.h
//  TrainerVate
//
//  Created by Matrid on 29/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginContoller : UIViewController<MBProgressHUDDelegate>

@property (weak, nonatomic) NSDictionary *userIdLogin;
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
- (IBAction)back:(id)sender;
- (IBAction)txtResign:(id)sender ;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet NSString *userType;

- (IBAction)ok:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *message;
- (IBAction)forgetPassword:(id)sender;


@end
