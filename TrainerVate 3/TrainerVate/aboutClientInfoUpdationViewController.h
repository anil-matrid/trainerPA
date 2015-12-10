//
//  aboutClientInfoUpdationViewController.h
//  TrainerVate
//
//  Created by Matrid on 25/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface aboutClientInfoUpdationViewController : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UITextView *txtInjuries;
@property (weak, nonatomic) IBOutlet UIButton *male;
@property (weak, nonatomic) IBOutlet UITextView *txtCando;
@property (weak, nonatomic) IBOutlet UIButton *female;
@property (weak, nonatomic) IBOutlet UITextView *txtcantdo;
- (IBAction)back:(id)sender;
- (IBAction)upDtae:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UIView *nameBg;
@property (weak, nonatomic) IBOutlet UIView *ageBg;
@property (weak, nonatomic) IBOutlet UIView *heightBg;
@property (weak, nonatomic) IBOutlet UIView *weightBg;
@property (strong, nonatomic) NSDictionary *basicInfo;
@property (weak, nonatomic) IBOutlet UIButton *weights;
@property (weak, nonatomic) IBOutlet UIButton *strength;
@property (weak, nonatomic) IBOutlet UIButton *upperBody;
@property (weak, nonatomic) IBOutlet UIButton *lowerBody;
@property (weak, nonatomic) IBOutlet UIButton *build;
@property (weak, nonatomic) IBOutlet UIButton *tone;
@property (weak, nonatomic) IBOutlet UIButton *endurance;
@property (weak, nonatomic) IBOutlet UIButton *flexibility;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessages;

- (IBAction)ok:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *bluredView;
- (IBAction)sex:(id)sender;
- (IBAction)goals:(id)sender;

@end
