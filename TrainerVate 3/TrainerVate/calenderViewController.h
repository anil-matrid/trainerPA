//
//  calenderViewController.h
//  TrainerVate
//
//  Created by Matrid on 14/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"
#import "MBProgressHUD.h"

@interface calenderViewController : UIViewController<FSCalendarDataSource,FSCalendarDelegate,MBProgressHUDDelegate>
@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UILabel *dates;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *lblBack;
@property (weak, nonatomic) IBOutlet UILabel *lblNotiCount;
- (IBAction)navBar:(id)sender;

@end
