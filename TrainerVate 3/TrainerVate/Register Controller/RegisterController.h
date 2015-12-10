//
//  RegisterController.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RegisterController : UIViewController<MBProgressHUDDelegate>
-(IBAction)txtResign:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *Next;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *emailId;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) NSMutableDictionary *registerationInformation;
- (IBAction)Next:(id)sender;
- (IBAction)Back:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *gymCode;

@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *messagesView;
@property (weak, nonatomic) IBOutlet UILabel *message;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *okView;

- (IBAction)ok1:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UILabel *errorToHide;

@end
