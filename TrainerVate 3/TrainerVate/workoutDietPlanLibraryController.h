//
//  workoutDietPlanLibraryController.h
//  TrainerVate
//
//  Created by Pankaj Khatri on 15/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface workoutDietPlanLibraryController : UIViewController<MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate> {
  //  IBOutlet UITableView *tableViews;
    IBOutlet UITextField *txtSearchField;
}
- (IBAction)sendBtn:(UIButton *)sender;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UIButton *navigationBAr;



@end
