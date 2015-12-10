//
//  MyClientController.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface MyClientController : UIViewController<UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate>
{
    IBOutlet UITableView *client;
    IBOutlet UIButton *rightMenuBtn;
    
}
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet UITableView *client;
- (IBAction)back:(id)sender;
- (IBAction)addNewClient:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end
