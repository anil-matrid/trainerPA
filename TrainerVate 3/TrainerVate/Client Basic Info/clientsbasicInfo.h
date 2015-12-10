//
//  clientsbasicInfo.h
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface clientsbasicInfo : UIViewController<MBProgressHUDDelegate>

//outletes
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UITextField *height;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIButton *finish;
@property (weak, nonatomic) IBOutlet UIButton *setReminder;
@property (weak, nonatomic) IBOutlet UIView *doneView;
@property (weak, nonatomic) IBOutlet UITextView *canDo;
@property (weak, nonatomic) IBOutlet UITextView *canNotDo;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UILabel *errorToHide;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UITextView *textViewinjurise;

//buttons
- (IBAction)setReminder:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)finish:(id)sender;
- (IBAction)ok:(id)sender;
@end
