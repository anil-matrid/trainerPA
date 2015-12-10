//
//  Client'sInformationController.h
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface ClientsInformationController : UIViewController<MBProgressHUDDelegate>


@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *clientName;
@property (weak, nonatomic) IBOutlet UITextField *clientEmail;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UIView *age1;
@property (weak, nonatomic) IBOutlet UIButton *cross;
- (IBAction)cross:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
- (IBAction)btnOkIfSucces:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnOkIfSucces;
@property (weak, nonatomic) IBOutlet UIButton *ok;
@property (weak, nonatomic) IBOutlet UILabel *hideViewIfSuccess;


- (IBAction)next:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *sdk;
@property (weak, nonatomic) IBOutlet UIView *sdk2;
- (IBAction)gender:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *feMale;
@property (weak, nonatomic) IBOutlet UIButton *male;


@property (weak, nonatomic) IBOutlet UIButton *done;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;

@property (weak, nonatomic) IBOutlet UILabel *message;
- (IBAction)ok:(id)sender;

@end
