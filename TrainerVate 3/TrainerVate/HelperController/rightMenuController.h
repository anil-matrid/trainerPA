//
//  rightMenuController.h
//  TrainerVate
//
//  Created by Matrid on 10/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface rightMenuController : UIViewController<UITableViewDataSource, UITableViewDelegate>
//@property (strong, nonatomic) IBOutlet UITableView *rightMenuList;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end
