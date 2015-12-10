//
//  DisconnectTrainer.h
//  Settings
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DisconnectTrainer : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIButton *disconnect;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)disconnect:(id)sender;
- (IBAction)cancelBtn:(id)sender;
- (IBAction)okBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;

@end
