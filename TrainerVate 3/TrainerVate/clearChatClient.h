//
//  clearChatClient.h
//  TrainerVate
//
//  Created by Matrid on 16/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface clearChatClient : UIViewController<MBProgressHUDDelegate>
- (IBAction)navBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (strong, nonatomic) IBOutlet UIView *view2;
- (IBAction)todayBtn:(id)sender;
- (IBAction)monthBtn:(id)sender;
- (IBAction)allBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *allBtn;
@property (strong, nonatomic) IBOutlet UIButton *monthBtn;
@property (strong, nonatomic) IBOutlet UIButton *todayBtn;
- (IBAction)yes:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *yesBtn;
- (IBAction)noBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *noBtn;
@property (strong, nonatomic) IBOutlet UIView *view3;
- (IBAction)okBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
