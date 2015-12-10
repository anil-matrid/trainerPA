//
//  DateAppointments.m
//  TrainerVate
//
//  Created by Matrid on 19/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DateAppointments.h"
#import "AppointmentScreen2.h"
#import "dateAppCell.h"
#import "Constants.h"
#import "DDCalendarEvent.h"
#import "NSDate+DDCalendar.h"
#import "DDCalendarView.h"
#import "EventView.h"

@interface DateAppointments ()<DDCalendarViewDataSource, DDCalendarViewDelegate>
{
    NSString *selectedDate;
    int timeValue;
    NSString *date;
    NSInteger row;
    NSArray *repeatPickerData;
    int firstIndexCell;
    NSString *strDates;
    NSString *currentMonth;
    NSString *currentYear;
    NSString *currentDates;
    NSMutableArray *appointMentArray;
    NSMutableArray *appointmentToShow;
    
}

@end

@implementation DateAppointments
@synthesize pickerDate,dates,datsInfoDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"DateAppointments_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"DateAppointments" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"DateAppointments_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    timeValue = 12;
    firstIndexCell=-1;
    // Do any additional setup after loading the view from its nib.
    pickerDate.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [pickerDate addConstraint:[NSLayoutConstraint constraintWithItem:pickerDate
                                                           attribute:NSLayoutAttributeCenterX
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:pickerDate
                                                           attribute:NSLayoutAttributeCenterX
                                                          multiplier:5.0
                                                            constant:0.0]];
    NSDateFormatter *dateFormat =[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"hh:mm:a"];
    [pickerDate addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

    [pickerDate addTarget:self
action:@selector(LabelChange:)
forControlEvents:UIControlEventValueChanged];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    _bluredView.hidden=YES;
    _appointmentView.hidden=YES;
    _bookAppointment.layer.cornerRadius=_bookAppointment.bounds.size.height/2;
    _bookTimeOff.layer.cornerRadius=_bookTimeOff.bounds.size.height/2;
    [pickerDate setDate:dates];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    strDates = [dateFormatter stringFromDate:dates];
    self.day.text = [strDates substringToIndex:2];
    self.year.text = [strDates substringFromIndex:6];
    [dateFormatter setDateFormat:@"MMM"];
    NSString *strDates1 = [dateFormatter stringFromDate:dates];
    self.month.text = strDates1;
    currentMonth=strDates1;
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *strDates2 = [dateFormatter stringFromDate:dates];
    currentYear=strDates2;

    
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDates = [dateFormatter stringFromDate:pickerDate.date];
    appointmentToShow =[[NSMutableArray alloc]init];
    for (int i=0; i<_dataInfoArray.count; i++) {
        if ([[[_dataInfoArray objectAtIndex:i]valueForKey:@"appointment_date"] isEqualToString:currentDates]) {
            [appointmentToShow addObject:[_dataInfoArray objectAtIndex:i]];
        }
    }
    [_calendarView reloadData];
    [self timeValidation];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)datePickerChanged:(UIDatePicker *)datePicker {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.day.text = [strDate substringToIndex:2];
    self.year.text = [strDate substringFromIndex:6];
    [dateFormatter setDateFormat:@"MMM"];
    strDate = [dateFormatter stringFromDate:datePicker.date];
    self.month.text = strDate;
    [dateFormatter setDateFormat:@"M"];
    NSString *monthString =[dateFormatter stringFromDate:datePicker.date];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDates = [dateFormatter stringFromDate:datePicker.date];
    
    if (![currentMonth isEqualToString:strDate]) {
        [self callDataFormServer:monthString year:self.year.text];
        currentMonth=strDate;
    }
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *strDate2 = [dateFormatter stringFromDate:datePicker.date];
    if (![currentYear isEqualToString:strDate2]) {
        [self callDataFormServer:monthString year:self.year.text];
        currentYear=strDate2;
    }
    appointmentToShow =[[NSMutableArray alloc]init];
    for (int i=0; i<_dataInfoArray.count; i++) {
        if ([[[_dataInfoArray objectAtIndex:i]valueForKey:@"appointment_date"] isEqualToString:currentDates]) {
            [appointmentToShow addObject:[_dataInfoArray objectAtIndex:i]];
        }
    }
    [_calendarView reloadData];
}

//#pragma tableView method**************************************************************
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 24;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *simpleTable=@"simpleTableCell";
//    dateAppCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
//    
//    
//    
//    if (cell==nil) {
//        NSArray *temps=[[NSBundle mainBundle]loadNibNamed:@"dateAppCell" owner:self options:nil];
//        cell=[temps objectAtIndex:0];
//    }
//    if (self.dataInfoArray.count==0) {
//        if (indexPath.row ==0) {
//            cell.lblTime.text = @"12:00 am";
//            timeValue = 1;
//            
//        }
//        if (indexPath.row>0 && indexPath.row <12) {
//            cell.lblTime.text=[NSString stringWithFormat:@"%li:00 am",(long)indexPath.row];
//            timeValue++;
//        }
//        if (indexPath.row == 12) {
//            cell.lblTime.text = @"noon";
//            timeValue=1;
//        }
//        if (indexPath.row>12) {
//            cell.lblTime.text =[NSString stringWithFormat:@"%li:00 pm",indexPath.row-12];
//            timeValue++;
//        }
//       
//    
//    }
//    
//    NSArray * dataArr=datsInfoDic;
//     for (int i=0; i<self.dataInfoArray.count; i++) {
//    
//         NSDictionary *currenDic=[self.dataInfoArray objectAtIndex:i];
//         
//         NSString *datesNEw=[currenDic objectForKey:@"time_from"];
//         NSString *to=[currenDic objectForKey:@"time_to"];
//         NSString *cellTimeString=@"";
//    
//    if (indexPath.row ==0) {
//        cell.lblTime.text = @"12:00 am";
//        cellTimeString=cell.lblTime.text;
//        timeValue = 1;
//        
//    }
//    if (indexPath.row>0 && indexPath.row <12) {
//        cell.lblTime.text=[NSString stringWithFormat:@"%li:00 am",(long)indexPath.row];
//        cellTimeString=cell.lblTime.text;
//        timeValue++;
//    }
//    if (indexPath.row == 12) {
//        cell.lblTime.text = @"noon";
//        cellTimeString=@"12:00 pm";
//        timeValue=1;
//    }
//    if (indexPath.row>12) {
//        cell.lblTime.text =[NSString stringWithFormat:@"%li:00 pm",indexPath.row-12];
//        cellTimeString=cell.lblTime.text;
//        timeValue++;
//    }
//    NSString *cellTime=[datesNEw substringToIndex:2];
//    if ([cellTime hasPrefix:@"0"]) {
//        cellTime = [cellTime substringFromIndex:1];
//    }
//    cellTime = [NSString stringWithFormat:@"%@%@%c",cellTime,@" ",[datesNEw characterAtIndex:6]];
//    cellTime = [NSString stringWithFormat:@"%@%c",cellTime,[datesNEw characterAtIndex:7]];
//    if ([cellTime isEqualToString:@"12 pm"]) {
//        cellTime=@"noon";
//    }
//    
//    CGRect frame=CGRectMake(45, 0, cell.frame.size.width-45, 0);
//    
//    UILabel *cellLbl=[[UILabel alloc]initWithFrame:frame];
//    cellLbl.backgroundColor=[UIColor colorWithRed:21/255.0 green:192/255.0 blue:213/255.0 alpha:0.25f];
//    cellLbl.text=[currenDic objectForKey:@"note"];
//    cellLbl.alpha=0.6;
//    UILabel *cellLbl1=[[UILabel alloc]initWithFrame:CGRectMake(45, 0, 2, 0)];
//    cellLbl1.backgroundColor=[UIColor colorWithRed:21/255.0 green:192/255.0 blue:213/255.0 alpha:0.40f];
//
//    if ([cellTimeString isEqualToString:@"7:00 pm"]) {
//        
//    }
//    
//         if (indexPath.row == 15) {
//             
//         }
//         if (indexPath.row == 21) {
//             
//         }
//   
//        
//    
//    int timeBtew=[self calculateDuration:cellTimeString secondDate:to];
//    if ([self getTheTimeExistsOrNot:cellTimeString ToTIme:to fromTime:datesNEw]) {
//        
//        if (firstIndexCell==-1)
//        {
//            firstIndexCell=indexPath.row;
//        }
//        
//        if (firstIndexCell==indexPath.row) {
//            cellLbl.text=[currenDic objectForKey:@"note"];
//        }
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"hh:mm a"];
//        NSDate *TOdate=[formatter dateFromString:to];
//        NSDate *currentdate=[formatter dateFromString:cellTimeString];
//        NSDate *fromDate=[formatter dateFromString:datesNEw];
//        
//        if (TOdate == currentdate) {
//            frame.origin.y = 0;
//            frame.size.height = 60-timeBtew;
//            cellLbl.frame = frame;
//            frame.size.width=2;
//            cellLbl1.frame=frame;
//            
//            
//        }
//        else if ([self isEndDateIsSmallerThanCurrent:fromDate Currentdate:currentdate]) {
//            
//            frame.origin.y = timeBtew;
//            frame.size.height = 60-timeBtew;
//            cellLbl.frame = frame;
//            frame.size.width=2;
//            cellLbl1.frame=frame;
//        }
//        else if ([self isEndDateIsSmallerThanCurrent:TOdate Currentdate:currentdate]){
//            
//            if (60>timeBtew) {
//                
//                frame.origin.y = 60-timeBtew;
//                frame.size.height = timeBtew;
//                cellLbl.frame = frame;
//                frame.size.width=2;
//                cellLbl1.frame=frame;
//                
//            }
//            else{
//                frame.origin.y =0;
//                frame.size.height = 60;
//                cellLbl.frame = frame;
//                frame.size.width=2;
//                cellLbl1.frame=frame;
//                
//            }
//            
//        }
//        
//        
//        
//        
//        [cell addSubview:cellLbl];
//        [cell addSubview:cellLbl1];
//        
//    }
//    else if ([self getTheTimeExistsOrNot:[self addOneHourToString:cellTimeString] ToTIme:to fromTime:datesNEw]) {
//        
//        if (firstIndexCell==-1) {
//            firstIndexCell=indexPath.row;
//        }
//        
//        if (firstIndexCell==indexPath.row) {
//            cellLbl.text=[datsInfoDic objectForKey:@"note"];
//        }
//        
//        
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"hh:mm a"];
//        NSDate *TOdate=[formatter dateFromString:to];
//        NSDate *currentdate=[formatter dateFromString:cellTimeString];
//        NSDate *fromDate=[formatter dateFromString:datesNEw];
//        
//        if (TOdate == currentdate) {
//            frame.origin.y = 0;
//            frame.size.height = 60-timeBtew;
//            cellLbl.frame = frame;
//            frame.size.width=2;
//            cellLbl1.frame=frame;
//            
//        }
//        else if ([self isEndDateIsSmallerThanCurrent:fromDate Currentdate:currentdate]) {
//            
//            frame.origin.y = timeBtew;
//            frame.size.height = 60-timeBtew;
//            cellLbl.frame = frame;
//            frame.size.width=2;
//            cellLbl1.frame=frame;
//        }
//        else if ([self isEndDateIsSmallerThanCurrent:TOdate Currentdate:currentdate]){
//            
//            if (60>timeBtew) {
//                
//                frame.origin.y = 60-timeBtew;
//                frame.size.height = timeBtew;
//                cellLbl.frame = frame;
//                frame.size.width=2;
//                cellLbl1.frame=frame;
//                
//            }
//            else{
//                frame.origin.y =0;
//                frame.size.height = 60;
//                cellLbl.frame = frame;
//                frame.size.width=2;
//                cellLbl1.frame=frame;
//                
//            }
//            
//        }
//        
//        
//        
//        [cell addSubview:cellLbl];
//        [cell addSubview:cellLbl1];
//    }
//        
//    }
//    return cell;
//}
//
//

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)bookAppointment:(id)sender {
    AppointmentScreen2 *dateApp=[[AppointmentScreen2 alloc]init];
    dateApp.CurrentDate = [pickerDate date];
    dateApp.bookTime=@"0";
    [self.navigationController pushViewController:dateApp animated:YES];
}

- (IBAction)bookTimeOff:(id)sender {
    AppointmentScreen2 *dateApp=[[AppointmentScreen2 alloc]init];
    dateApp.CurrentDate = [pickerDate date];
    dateApp.bookTime=@"1";
    [self.navigationController pushViewController:dateApp animated:YES];
}

- (IBAction)addAppointMent:(id)sender {
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[MyClientController class]]) {
            AppointmentScreen2 *dateApp=[[AppointmentScreen2 alloc]init];
            dateApp.CurrentDate = [pickerDate date];
            dateApp.bookTime=@"0";
            [self.navigationController pushViewController:dateApp animated:YES];
            flag=YES;
            break;
        }
    }
    if (flag==NO && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        AppointmentScreen2 *dateApp=[[AppointmentScreen2 alloc]init];
        dateApp.CurrentDate = [pickerDate date];
        dateApp.bookTime=@"0";
        [self.navigationController pushViewController:dateApp animated:YES];
    }
    else {
        _bluredView.hidden=NO;
        _appointmentView.hidden=NO;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
  //  [self.calendarView scrollDateToVisible:[NSDate date] animated:animated];
}

- (NSArray *)eventsForDay:(NSInteger)dayMod {
//    DDCalendarEvent *event2 = [DDCalendarEvent new];
//    [event2 setTitle: @"Demo Event 3"];
//    [event2 setDateBegin:[NSDate dateWithHour:3 min:15 inDays:dayMod]];
//    [event2 setDateEnd:[NSDate dateWithHour:4 min:0 inDays:dayMod]];
//    [event2 setUserInfo:@{@"color":[UIColor yellowColor]}];
//    
//    DDCalendarEvent *event3 = [DDCalendarEvent new];
//    [event3 setTitle: @"Demo Event 1"];
//    [event3 setDateBegin:[NSDate dateWithHour:1 min:00 inDays:dayMod]];
//    [event3 setDateEnd:[NSDate dateWithHour:2 min:10 inDays:dayMod]];
//    
//    DDCalendarEvent *event4 = [DDCalendarEvent new];
//    [event4 setTitle: @"Demo Event 5"];
//    [event4 setDateBegin:[NSDate dateWithHour:5 min:39 inDays:dayMod]];
//    [event4 setDateEnd:[NSDate dateWithHour:6 min:13 inDays:dayMod]];
//    [event4 setUserInfo:@{@"color":[UIColor yellowColor]}];
//    
//    DDCalendarEvent *event1 = [DDCalendarEvent new];
//    [event1 setTitle: @"Demo Event 7"];
//    [event1 setDateBegin:[NSDate dateWithHour:7 min:00 inDays:dayMod]];
//    [event1 setDateEnd:[NSDate dateWithHour:12 min:13 inDays:dayMod]];
//    
//    DDCalendarEvent *event5 = [DDCalendarEvent new];
//    [event5 setTitle: @"Demo Event 13"];
//    [event5 setDateBegin:[NSDate dateWithHour:13 min:00 inDays:dayMod]];
//    [event5 setDateEnd:[NSDate dateWithHour:14 min:13 inDays:dayMod]];
//    
//    DDCalendarEvent *event7 = [DDCalendarEvent new];
//    [event7 setTitle: @"Demo Event 15"];
//    [event7 setDateBegin:[NSDate dateWithHour:15 min:30 inDays:dayMod]];
//    [event7 setDateEnd:[NSDate dateWithHour:16 min:30 inDays:dayMod]];
//    [event7 setUserInfo:@{@"color":[UIColor greenColor]}];
//    
//    DDCalendarEvent *event8 = [DDCalendarEvent new];
//    [event8 setTitle: @"Demo Event 17"];
//    [event8 setDateBegin:[NSDate dateWithHour:17 min:40 inDays:dayMod]];
//    [event8 setDateEnd:[NSDate dateWithHour:21 min:30 inDays:dayMod]];
//    
//    DDCalendarEvent *event9 = [DDCalendarEvent new];
//    [event9 setTitle: @"Demo Event 22"];
//    [event9 setDateBegin:[NSDate dateWithHour:22 min:00 inDays:dayMod]];
//    [event9 setDateEnd:[NSDate dateWithHour:23 min:30 inDays:dayMod]];
    NSMutableArray *SendArray=[NSMutableArray array];
    
    for (int i=0; i<appointmentToShow.count; i++) {
        
        NSDictionary *currentDic=[appointmentToShow objectAtIndex:i];
        
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [df setTimeZone:[NSTimeZone systemTimeZone]];
        [df setDateFormat:@"hh:mm a"];
        NSDate* newDateFrom = [df dateFromString:[currentDic objectForKey:@"time_from"]];
        NSDate* newDateTo = [df dateFromString:[currentDic objectForKey:@"time_to"]];
        [df setDateFormat:@"HH:mm"];
        NSString * startDate = [df stringFromDate:newDateFrom];
        NSString * EndDate = [df stringFromDate:newDateTo];
        
        NSArray *startArray = [startDate componentsSeparatedByString:@":"];
        NSArray *endArray = [EndDate componentsSeparatedByString:@":"];
        
        int startHour;
        int startmin;
        if (startArray.count!=0) {
             startHour = [[startArray objectAtIndex:0] intValue];
             startmin = [[startArray objectAtIndex:1] intValue];
        }
        int endHour;
        int endmin;
        if (endArray.count!=0) {
            endHour = [[endArray objectAtIndex:0] intValue];
            endmin = [[endArray objectAtIndex:1] intValue];
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy HH:mm:ss"];
       
        NSString *titleValue=@"";
        
        if ([[currentDic objectForKey:@"appointment_id"] isEqualToString:@""]) {
            titleValue = @" ";
        }
        else{
            titleValue = [currentDic objectForKey:@"appointment_id"];
        }
        DDCalendarEvent *event2 = [DDCalendarEvent new];
        [event2 setTitle:titleValue];
    
        [event2 setDateBegin:[NSDate dateWithHour:startHour min:startmin inDays:dayMod]];
        [event2 setDateEnd:[NSDate dateWithHour:endHour min:endmin inDays:dayMod]];
        [event2 setUserInfo:@{@"color":[UIColor colorWithRed:21/255.0 green:192/255.0 blue:213/255.0 alpha:0.25]}];
        [SendArray addObject:event2];
    }
    return SendArray;
}

#pragma mark DDCalendarViewDelegate

- (void)calendarView:(DDCalendarView* )view focussedOnDay:(NSDate* )date {
    //  self.dayLabel.text = date.stringWithDateOnly;
}

- (void)calendarView:(DDCalendarView* )view didSelectEvent:(DDCalendarEvent* )event {
    //appointmentToShow;
    AppointmentScreen *appoint=[[AppointmentScreen alloc]init];
    for (int i=0; i<appointmentToShow.count; i++) {
        if ([event.title isEqualToString:[[appointmentToShow objectAtIndex:i] valueForKey:@"appointment_id"]]) {
            appoint.apppointmentData=[[appointmentToShow objectAtIndex:i] mutableCopy];
        }
    }
    [self.navigationController pushViewController:appoint animated:YES];
}

- (BOOL)calendarView:(DDCalendarView* )view allowEditingEvent:(DDCalendarEvent* )event {
    return YES;
}

- (void)calendarView:(DDCalendarView* )view commitEditEvent:(DDCalendarEvent* )event {
    NSLog(@"%@", event);
    //should do conflic validation and maybe save ;) or revert :P
}

#pragma mark DDCalendarViewDataSource

- (NSArray *)calendarView:(DDCalendarView *)view eventsForDay:(NSDate *)date12 {
    //should come from db ;) NOW using testdata
    NSInteger daysMod = [date12 daysFromDate:[NSDate date]];
    NSArray *newE = [self eventsForDay:daysMod]; //always today ;)
    
    NSMutableArray *dates2 = [NSMutableArray array];
    for (DDCalendarEvent *e in newE) {
        if([e.dateBegin isEqualDay:date12] ||
           [e.dateEnd isEqualDay:date12]) {
            [dates2 addObject:e];
        }
    }
    return dates2;
}

//optionally provide a view
- (DDCalendarEventView *)calendarView:(DDCalendarView *)view viewForEvent:(DDCalendarEvent *)event {
    return [[EventView alloc] initWithEvent:event];
}


//- (int)calculateDuration:(NSString *)timeTo secondDate:(NSString *)timeFrom
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"mm:ss a"];
//    NSDate *oldTime=[formatter dateFromString:timeTo];
//    NSDate *currentTime=[formatter dateFromString:timeFrom];
//    NSDate *date1 = oldTime;
//    NSDate *date2 = currentTime;
//    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
//    
//    if(secondsBetween<0)
//    {
//        secondsBetween=-secondsBetween;
//    }
//    
//    // int min = secondsBetween/60;
//    // int hh = secondsBetween / (60*60);
//    // double rem = fmod(secondsBetween, (60*60));
//    //    int mm = rem / 60;
//    
//    
//    // NSString *str = [NSString stringWithFormat:@"%02d:%02d:%02d",hh,mm,ss];
//    
//    return secondsBetween;
//}
//-(BOOL)getTheTimeExistsOrNot:(NSString *)currentTimeStr ToTIme:(NSString *)ToTimeStr fromTime:(NSString *)fromTimerStr{
//    
//    NSString *startTimeString =fromTimerStr;
//    NSString *endTimeString =ToTimeStr;
//    
//    //  NSLog(currentTimeStr);
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"hh:mm a"];
//    
//    // NSString *nowTimeString = [formatter stringFromDate:[NSDate date]];
//    
//    int startTime   = [self minutesSinceMidnight:[formatter dateFromString:startTimeString]];
//    int endTime  = [self minutesSinceMidnight:[formatter dateFromString:endTimeString]];
//    int nowTime     = [self minutesSinceMidnight:[formatter dateFromString:currentTimeStr]];;
//    
//    
//    BOOL value;
//    if (startTime <= nowTime && nowTime <= endTime)
//    {
//        value = YES;
//        NSLog(@"Time is between");
//    }
//    else {
//        value = NO;
//        NSLog(@"Time is not between");
//    }
//    return value;
//    
//}
//-(int) minutesSinceMidnight:(NSDate *)date1
//{
//    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date1];
//    return 60 * (int)[components hour] + (int)[components minute];
//}
//
//- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate Currentdate:(NSDate *)currentdate
//{
//    NSDate* enddate = checkEndDate;
//    // NSDate* currentdate = [NSDate date];
//    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
//    double secondsInMinute = 60;
//    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
//    
//    if (secondsBetweenDates == 0)
//        return YES;
//    else if (secondsBetweenDates < 0)
//        return YES;
//    else
//        return NO;
//}
//-(NSString *)addOneHourToString:(NSString *)currentString{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"hh:mm a"];
//    NSDate *CurrentTimedate = [formatter dateFromString:currentString];
//    NSDate *newDate = [CurrentTimedate dateByAddingTimeInterval:60*60];
//    currentString=[formatter stringFromDate:newDate];
//    return currentString;
//}


- (void)callDataFormServer:(NSString *)months year:(NSString *)years {
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSDictionary *inputDic;
    BOOL flag=NO;
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientUid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[MyClientController class]]) {
            inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientUid,@"user_id",years,@"year",months,@"month",@"0",@"is_trainer", nil];
            flag=YES;
            break;
        }
        else  {
            inputDic=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"user_id",years,@"year",months,@"month",@"1",@"is_trainer", nil];
        }
    }
    if (flag==NO && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientUid,@"user_id",years,@"year",months,@"month",@"0",@"is_trainer", nil];
    }
    
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"getAppointments/" apiKey:[Globals apiKey]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        // NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error: &e];
        if (json !=nil && json.allKeys.count!=0) {
           [hudFirst hide:YES];
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
               
                _dataInfoArray=[NSMutableArray array];
                appointMentArray =[[json valueForKey:@"returnset"] mutableCopy];
                for (int i=0; i<appointMentArray.count; i++) {
                    if ([[[appointMentArray objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"0"]) {
                        [appointMentArray removeObjectAtIndex:i];
                    }
                }
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                currentDates = [dateFormatter stringFromDate:pickerDate.date];
                _dataInfoArray=appointMentArray;
                appointmentToShow =[[NSMutableArray alloc]init];
                for (int i=0; i<_dataInfoArray.count; i++) {
                    if ([[[_dataInfoArray objectAtIndex:i]valueForKey:@"appointment_date"] isEqualToString:currentDates]) {
                        [appointmentToShow addObject:[_dataInfoArray objectAtIndex:i]];
                    }
                }
                [_calendarView reloadData];
                
            }
            else{
                [hudFirst hide:YES];
            }
        }
        [hudFirst hide:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        
    }];
    
}
- (void)LabelChange:(id)sender{
    [self timeValidation];
}

-(void)timeValidation{
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"dd-MM-yyyy"];
    NSString *strDate = [dateFormatter2 stringFromDate:[NSDate date]];
    
    NSString *strCurrentDate = strDate;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    NSString *strServerDate =[dateFormatter2 stringFromDate:pickerDate.date];
    
    
    NSDateFormatter *datePickerFormat = [[NSDateFormatter alloc] init];
    [datePickerFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *currentDate = [datePickerFormat dateFromString:strCurrentDate];
    NSDate *serverDate = [datePickerFormat dateFromString:strServerDate];
    NSComparisonResult result;
    result = [currentDate compare:serverDate];
    
    if (result == NSOrderedSame) {
        [_add setEnabled:YES];
    }
    else if (result == NSOrderedDescending) {
        [_add setEnabled:NO];
    }
    else {
        [_add setEnabled:YES];
    }

}



@end
