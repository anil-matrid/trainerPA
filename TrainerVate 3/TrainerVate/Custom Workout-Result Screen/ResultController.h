//
//  ResultController.h
//  My Client- Workout
//
//  Created by Matrid on 01/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)backbtn:(id)sender;
- (IBAction)menubtn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *headinglbl;
- (IBAction)searchbtn:(id)sender;
- (IBAction)textfield:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textfield;
@property (strong, nonatomic) IBOutlet UIButton *searchbtn;
@property (strong, nonatomic) IBOutlet UILabel *textlbl;
@property (strong, nonatomic) IBOutlet UILabel *line;
- (IBAction)resultTextField:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *resultTextField;
@property (strong, nonatomic) IBOutlet UIButton *resultSearch;
- (IBAction)resultSearch:(id)sender;
- (IBAction)addbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addbtn;
@property (strong, nonatomic) IBOutlet UILabel *bglbl;


@end
