//
//  customWorkoutController2.h
//  My Client- Workout
//
//  Created by Matrid on 02/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customWorkoutController2 : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableVIew;
- (IBAction)createbtn:(id)sender;

@end
