//
//  LibraryController.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LibraryController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MBProgressHUDDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *libraryDietPlan;
- (IBAction)send:(id)sender;
- (IBAction)backView:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *dietLibraryView;
- (IBAction)ok:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)btnCrossPopUp:(UIButton *)sender;
- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
@property (weak, nonatomic) IBOutlet UILabel *lblToHide;
@property (weak, nonatomic) IBOutlet UIButton *crossBtn;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;




@end
