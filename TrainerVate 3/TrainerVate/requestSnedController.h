//
//  requestSnedController.h
//  TrainerVate
//
//  Created by Matrid on 23/11/15.
//  Copyright © 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface requestSnedController : UIViewController<MBProgressHUDDelegate> {
    
    __weak IBOutlet UIButton *navigationBar;
    __weak IBOutlet UITextField *reciverCode;
    __weak IBOutlet UIView *txtBackground;
    __weak IBOutlet UILabel *senderLbl;
    __weak IBOutlet UILabel *headerLbl;
   // __weak IBOutlet UIButton *requestBtn;
}
- (IBAction)back:(id)sender;
//- (IBAction)requestBtn:(id)sender;


@end
