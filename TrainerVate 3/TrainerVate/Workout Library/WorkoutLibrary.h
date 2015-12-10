//
//  WorkoutLibrary.h
//  My Client- Workout
//
//  Created by Matrid on 26/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutLibrary : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *searchbtn;
- (IBAction)searchbtn:(id)sender;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;

@end
