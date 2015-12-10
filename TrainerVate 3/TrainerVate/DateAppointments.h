//
//  DateAppointments.h
//  TrainerVate
//
//  Created by Matrid on 19/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@class DDCalendarView;

@interface DateAppointments : UIViewController<MBProgressHUDDelegate>
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerDate;
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, weak) IBOutlet DDCalendarView *calendarView;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *appointmentView;
@property (weak, nonatomic) IBOutlet UIButton *bookAppointment;
- (IBAction)bookAppointment:(id)sender;
- (IBAction)bookTimeOff:(id)sender;
- (IBAction)addAppointMent:(id)sender;
@property (weak, nonatomic) NSDate *dates;
@property (weak, nonatomic) IBOutlet UIButton *bookTimeOff;
@property (strong, nonatomic) IBOutlet UILabel *dateLbl;
@property (strong, nonatomic) NSDictionary *datsInfoDic;
@property (strong, nonatomic) NSMutableArray *dataInfoArray;;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *month;
@property (weak, nonatomic) IBOutlet UILabel *year;
@end
