//
//  clientDietPlan.h
//  TrainerVate
//
//  Created by Matrid on 13/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clientDietPlan : UIViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (strong, nonatomic) NSDictionary *dicty;
@end
