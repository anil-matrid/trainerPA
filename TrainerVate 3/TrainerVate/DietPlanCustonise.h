//
//  DietPlanCustonise.h
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietPlanCustonise : UIViewController<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UIAlertViewDelegate>
- (IBAction)backDietPlan:(id)sender;
- (IBAction)send:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *CustomDietTable;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (strong, nonatomic)  NSString *diet_id;
@property(strong , nonatomic) NSString *preClass;
@property (strong,nonatomic) NSMutableDictionary *dataDictionary;
@property (weak, nonatomic) IBOutlet UIView *erroriew;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
- (IBAction)ok:(id)sender;
//diet_id

@end
