//
//  calenderViewController.m
//  TrainerVate
//
//  Created by Matrid on 14/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "calenderViewController.h"
#include "FSCalendar.h"
#import "AppointmentScreen2.h"
#import "Constants.h"
#import "appointmentManagement.h"


@interface calenderViewController (){
    NSDate *maxdate;
    NSDate *mindate;
    NSArray *monthsName;
    NSMutableArray *datesArray;
    NSString *month;
    NSString *year;
    FSCalendar *calendar;
    NSMutableArray *pendingAppointMentArray;
    NSMutableArray *appointMentArray;
    NSString *sot;
    BOOL isClientFromTrainer;
}

@end

@implementation calenderViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"calenderViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"calenderViewController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    monthsName = [NSArray arrayWithObjects: @"January",@"February",@"March",@"April",@"May",@"June",@"July ",@"August",@"September",@"October",@"November",@"December", nil];
    //datesArray = [NSArray arrayWithObjects:@"05-09-2015",@"13-09-2015",@"09-09-2015",@"26-09-2015",@"15-09-2015", nil];
   
    
    _lblBack.layer.cornerRadius=_lblBack.bounds.size.height/2;
    datesArray=[NSMutableArray array];
    
    //calendar methods
   
    if (IS_IPHONE_5_OR_MORE) {
        calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 227, 320, 345)];
    }
    else {
         calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 182, 320, 300)];
    }
    isClientFromTrainer=NO;
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.firstWeekday = 2;
    calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
    calendar.appearance.selectionColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    calendar.appearance.todayColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    calendar.flow = FSCalendarFlowHorizontal;
    calendar.appearance.weekdayTextColor = [UIColor blackColor];
    calendar.appearance.headerTitleColor = [UIColor blackColor];
    calendar.appearance.eventColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
    calendar.appearance.cellStyle = FSCalendarCellStyleRectangle;
    appointMentArray=[NSMutableArray array];
    pendingAppointMentArray = [NSMutableArray array];
    [self.view addSubview:calendar];
    self.calendar = calendar;
       // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
   // _date.text=[@(month) stringValue];[dateComps day];
    [dateComps setMonth:[dateComps month]];
    [dateComps setYear:[dateComps year]];
    [dateComps setHour:[dateComps hour]];
    // Notification will fire in one minute
    [dateComps setMinute:[dateComps minute]];
    [dateComps setSecond:[dateComps second]];
    [self calendarSelectedValue];
    
//    NSCalendar *cal = [[NSCalendar alloc] init];
//    NSDateComponents *components = [cal components:0 fromDate:date];
//    NSInteger year = [components year];
//    NSInteger month = [components month];
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal fromDate: [NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    _day.text = [dateFormatter stringFromDate:[NSDate date]];
    _dates.text = [NSString stringWithFormat:@"%ld",(long)[components day]];
    _month.text =[monthsName objectAtIndex:[components month]-1];
    _year.text = [NSString stringWithFormat:@"%ld",(long)[components year] ];
    
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[MyClientController class]]) {
            isClientFromTrainer=YES;
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc] init] ;
    [df setDateFormat:@"yyyy"];
    NSString *YearString=[df stringFromDate:currentDate];
    [df setDateFormat:@"M"];
    NSString *monthString =[df stringFromDate:currentDate];
    [self callDataFormServer:monthString year:YearString];
    [super viewWillAppear:YES];
 //   [self callPendingDate];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
//        _navigationBar.hidden=YES;
//        _lblNotiCount.hidden=YES;
//        _lblBack.hidden=YES;
    }
    else{
        if (isClientFromTrainer==YES) {
            _navigationBar.hidden=YES;
            _lblBack.hidden=YES;
        }
        else {
            _navigationBar.hidden=NO;
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date {
    
   // NSMutableArray *currentSendArray=[NSMutableArray array];
    
    
    DateAppointments *dateApp=[[DateAppointments alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //NSString *dates = [formatter stringFromDate:date];
//    for (int i=0; i<appointMentArray.count; i++) {
//        if ([[[appointMentArray objectAtIndex:i] valueForKey:@"appointment_date"] isEqualToString:dates]) {
//            dateApp.datsInfoDic=[[appointMentArray objectAtIndex:i] mutableCopy];
//            [currentSendArray addObject:[appointMentArray objectAtIndex:i]];
          //  break;
//        }
//    }
    dateApp.dataInfoArray=[appointMentArray mutableCopy];
    dateApp.dates=date;
    [self.navigationController pushViewController:dateApp animated:YES];
}

- (void)calendarCurrentMonthDidChange:(FSCalendar *)calendar {
    NSDate *currentDate=calendar.currentMonth;
    NSDateFormatter *df=[[NSDateFormatter alloc] init] ;
    [df setDateFormat:@"yyyy"];
    NSString *YearString=[df stringFromDate:currentDate];
    [df setDateFormat:@"M"];
    NSString *monthString =[df stringFromDate:currentDate];
    [self callDataFormServer:monthString year:YearString];
}

- (void)calendarSelectedValue {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekdayOrdinal fromDate: [NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    _day.text = [dateFormatter stringFromDate:[NSDate date]];
    _dates.text = [NSString stringWithFormat:@"%ld",(long)[components day]];
    _month.text =[monthsName objectAtIndex:[components month]-1];
    _year.text = [NSString stringWithFormat:@"%ld",(long)[components year] ];

}

#pragma apli implimentation*************************************************************
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
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                appointMentArray=[NSMutableArray array];
                pendingAppointMentArray = [NSMutableArray array];
                NSMutableArray *jsonData = [[json valueForKey:@"returnset"] mutableCopy];
                for (int i=0; i<jsonData.count; i++) {
                    if ([[[jsonData objectAtIndex:i] valueForKey:@"status"] isEqualToString:@"0"]) {
                        [pendingAppointMentArray addObject:[jsonData objectAtIndex:i]];
                    }
                    else {
                        [appointMentArray addObject:[jsonData objectAtIndex:i]];
                    }
                }
                [self updateTheDaeArray:appointMentArray];
                _lblNotiCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)pendingAppointMentArray.count ];
                for (int i=0; i<pendingAppointMentArray.count; i++) {
                    if(![[[pendingAppointMentArray objectAtIndex:i] valueForKey:@"avatar"] isEqual:[NSNull null] ]) {
                        if (![[[pendingAppointMentArray objectAtIndex:i] valueForKey:@"avatar"] isEqualToString:@""]) {
                            NSString *clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[[pendingAppointMentArray objectAtIndex:i] valueForKey:@"avatar"]];
                            [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:clientImage]];
                        }
                    }
                }
                [hudFirst hide:YES];
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

-(void)callPendingDate{
    
    NSString *clientUid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:KurlgetClientAppointment apiKey:[Globals apiKey]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *inputDic1=[NSDictionary dictionaryWithObjectsAndKeys:clientUid,@"client_id",@"1",@"for_client", nil];
    [manager POST:urlString parameters:inputDic1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]){
                sot = [[json valueForKey:@"count"] stringValue];
                [self updateTheDaeArray:[json valueForKey:@"return_set"]];
                appointMentArray =[json valueForKey:@"return_set"];
                _lblNotiCount.text = sot;
            }
            else{
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//- (void)callDataFormServer:(NSString *)months year:(NSString *)years {
//    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hudFirst.delegate = self;
//    hudFirst.labelText=@"Please wait";
//    hudFirst.center=self.view.center;
//    hudFirst.dimBackground=YES;
//    [hudFirst show:YES];
//    NSDictionary *inputDic;
//    BOOL flag=NO;
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSString *clientUid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
//    for (UIViewController* viewController in self.navigationController.viewControllers) {
//        if ([viewController isKindOfClass:[MyClientController class]]) {
//            inputDic=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"trainer_id",clientUid,@"client_id", nil];
//            flag=YES;
//            break;
//        }
//        else  {
//            inputDic=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"trainer_id",years,@"appointment_year",months,@"appointment_month", nil];
//        }
//    }
//    if (flag==NO && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
//        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:userId,@"trainer_id",clientUid,@"client_id", nil];
//    }
//    
//    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:KurlgetClientAppointment apiKey:[Globals apiKey]];
//    
//    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //[manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError* error;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                             options:kNilOptions error:&error];
//        if (json !=nil && json.allKeys.count!=0) {
//            
//            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
//                
//                sot = [[json valueForKey:@"count"] stringValue];
//                [self updateTheDaeArray:[json valueForKey:@"return_set"]];
//                _lblNotiCount.text = sot;
//
//                [hudFirst hide:YES];
//                
//            }
//            else{
//                
//                [hudFirst hide:YES];
//                
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [hudFirst hide:YES];
//      
//    }];
//    
//}

-(void)updateTheDaeArray:(NSArray *)response{
    for (int i = 0; i<response.count; i++) {
        NSDictionary *currentDIc=[response objectAtIndex:i];
        [datesArray addObject:[currentDIc objectForKey:@"appointment_date"]];
    }
    [calendar reloadData];
}

- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)dates {
    NSDateFormatter *dfs=[[NSDateFormatter alloc] init] ;
    [dfs setDateFormat:@"yyyy-MM-dd"];
    NSString *defaulDate=[dfs stringFromDate:dates];
    if ([datesArray containsObject:defaulDate]) {
        return YES;
    }
    return NO;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)navBar:(id)sender {
    appointmentManagement *am = [[appointmentManagement alloc]init];
    am.pendingRequest=pendingAppointMentArray;
    [self.navigationController pushViewController:am animated:YES];
    
}

@end
