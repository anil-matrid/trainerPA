//
//  ViewController.h
//  dietPlanController
//
//  Created by Matrid on 06/11/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dietPlanGlobalVIew : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)doneBtn:(id)sender;
- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *navBar;


@end

