//
//  checkOutBundle.h
//  TrainerVate
//
//  Created by Matrid on 26/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface checkOutBundle : UIViewController<UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate> {
    
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UILabel *headerLbl;
}
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (strong, nonatomic) NSString *bundleName;
@property (strong, nonatomic) NSMutableArray *bundleProduct;
- (IBAction)back:(id)sender;
- (IBAction)next:(id)sender;
@end
