//
//  Search Exercise Controller.h
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Search_Exercise_Controller : UIViewController
- (IBAction)searchbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *searchbtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;

@end
