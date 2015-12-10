//
//  SettingController.h
//  Settings
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingController : UIViewController
- (IBAction)back:(id)sender;

- (IBAction)pushNotification:(id)sender;
- (IBAction)language:(id)sender;
- (IBAction)changeEmail:(id)sender;
- (IBAction)changePassword:(id)sender;
- (IBAction)addProfilePic:(id)sender;
- (IBAction)disconnectTrainer:(id)sender;
- (IBAction)termsConditions:(id)sender;
- (IBAction)privacyPolicy:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *settingScrollView;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)signoutBtn:(id)sender;
- (IBAction)clearChatBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UILabel *idLbl;
@property (weak, nonatomic) IBOutlet UISwitch *notification;

- (IBAction)uniqueBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (weak, nonatomic) IBOutlet UIButton *disconnectTrainer;
- (IBAction)okBtn:(id)sender;
@end
