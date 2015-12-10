//
//  AboutClintController.h
//  TrainerVate
//
//  Created by Matrid on 22/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface AboutClintController : UIViewController<UIScrollViewDelegate,MBProgressHUDDelegate,UITableViewDataSource,UITableViewDelegate>
{
 
    IBOutlet UITableView *tblReminder;
    IBOutlet UIView *viewToHide;
    IBOutlet UIView *bluredView;
    __weak IBOutlet UITableView *table;
    IBOutlet UIButton *floatingButton;
    
    NSString *g_buildmuscles;
    NSString *g_endurance;
    NSString *g_flexibility;
    NSString *g_lowerbody;
    NSString *g_strengthen;
    NSString *g_tonemuscles;
    NSString *g_upperbody;
    NSString *g_weight;
    __weak IBOutlet UIButton *clientInfo;
    __weak IBOutlet UIButton *reminder;
}
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)daily:(id)sender;
- (IBAction)weekly:(id)sender;
- (IBAction)monthly:(id)sender;- (IBAction)TopBtns:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *daily;
@property (weak, nonatomic) IBOutlet UIButton *weekly;
@property (weak, nonatomic) IBOutlet UIButton *monthly;
- (IBAction)btnCancel:(id)sender;
- (IBAction)floatingButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@end
