//
//  requsetManagementController.h
//  TrainerVate
//
//  Created by Matrid on 24/11/15.
//  Copyright © 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface requsetManagementController : UIViewController<UITableViewDelegate, UITableViewDataSource, MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblMsg;

@end
