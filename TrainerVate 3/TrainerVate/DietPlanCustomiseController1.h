//
//  DietPlanCustomiseController1.h
//  TrainerVate
//
//  Created by Matrid on 09/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface DietPlanCustomiseController1 : UIViewController<UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate>
//outlets..........
@property (strong, nonatomic) IBOutlet UITableView *dietPlanTable;
@property (strong, nonatomic) IBOutlet UIView *viewDietCustomise;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet NSString *preClass;
@property ( nonatomic)  int dietPlanIndexPath;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (strong, nonatomic) NSMutableArray *dietCustomiseData;
@property (strong, nonatomic) NSMutableArray * MainArrayData;

// buttons........
- (IBAction)add:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)addDiet:(id)sender;
- (IBAction)btnSearch:(id)sender;

@end
