//
//  ViewController.m
//  Appointment screen
//
//  Created by Matrid on 15/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AppointmentScreen.h"
#import "Globals.h"
#import "Constants.h"
#import "MBProgressHUD.h"

@interface AppointmentScreen (){
    NSString *accept;
    BOOL flag;
}

@end

@implementation AppointmentScreen
@synthesize timeFrom,view2,blurredView,apppointmentData,timeTO,notes,from,from2,where,nameLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _footerLbl.hidden=YES;
    NSArray *viewcon = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewcon class])isEqualToString:@"DateAppointments"]) {
        _footerLbl.hidden=NO;
        nameLbl.hidden=YES;
        
    }

    
    if (IS_IPHONE_4_OR_LESS) {
        _scroll.contentSize = CGSizeMake(320,568);
    }

    nameLbl.layer.cornerRadius=nameLbl.bounds.size.height/2;
    nameLbl.clipsToBounds=YES;
    
    blurredView.hidden = YES;
    view2.hidden = YES;
    NSString *apd =[apppointmentData objectForKey:@"appointment_date"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:apd];
    [formatter setDateFormat:@"EEE dd MMM yyyy"];
    NSString *string = [formatter stringFromDate:date];
    from.text = string;
    from2.text = string;
    _view2DateLbl.text = string;

    NSString *dates = [apppointmentData objectForKey:@"time_from"];
    dates = [dates substringToIndex:5];
    timeFrom.text = dates;
    
    
    NSString *dates1 = [apppointmentData objectForKey:@"time_to"];
    dates1 = [dates1 substringToIndex:5];
    timeTO.text = dates1;

    if ([[apppointmentData objectForKey:@"Time_from"] containsString:@"am"] || [[apppointmentData objectForKey:@"Time_from"] containsString:@"AM"]) {
        _am.text=@"am";
       
    }
    else {
        _am.text=@"pm";
    }
    if ([[apppointmentData objectForKey:@"Time_from"] containsString:@"am"] || [[apppointmentData objectForKey:@"Time_from"] containsString:@"AM"]) {
        _pm.text=@"am";
    }
    else {
        _pm.text=@"pm";
    }
    notes.text = [apppointmentData objectForKey:@"note"];
    where.text = [apppointmentData objectForKey:@"place"];
    nameLbl.text = [apppointmentData objectForKey:@"name"];
    _view2FromTime.text = [apppointmentData objectForKey:@"Time_from"];
    _view2TImeTo.text = [apppointmentData objectForKey:@"Time_to"];

    [[where layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[where layer] setBorderWidth:1];
    [[where layer] setCornerRadius:15];
    
    [[notes layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[notes layer] setBorderWidth:1];
    [[notes layer] setCornerRadius:15];

    flag=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookButton:(id)sender {
     accept=@"1";
       [self setAppointment];
}

- (IBAction)okButton:(id)sender {
    
    if (flag==YES) {
        blurredView.hidden=YES;
        view2.hidden=YES;
    }
    else {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[calenderViewController class]] ) {
                calenderViewController *tom = (calenderViewController*)viewController;
                [self.navigationController popToViewController:tom animated:YES];
            }
        }
    }
}


- (IBAction)rejectBtn:(id)sender {
    
    accept=@"2";
    _view2Lbl.text=@"Appointment Rejected";

    [self setAppointment];
}

- (void)setAppointment{
    
    MBProgressHUD*    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //  hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:kurlsetAppointment apiKey:[Globals apiKey]];
//    NSString *timeFromString =[NSString stringWithFormat:@"%@ %@",lblFromTime.text,lblFromAmPm.text];
//    NSString *timetoString =[NSString stringWithFormat:@"%@ %@",lblToTime.text,lblToAmPm.text];
//    NSString *dateFromString =[self dateStringToDateStringFormat:lblToDate.text];
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    
        //Dictionary for client..
//       NSString *clientID = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
     NSDictionary *inputDic = [NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",accept,@"is_accepted",[apppointmentData objectForKey:@"appointment_id"],@"appointment_id", nil];
    
AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
manager.responseSerializer = [AFHTTPResponseSerializer serializer];
[manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                         options:kNilOptions error:&error];
    if (json !=nil && json.allKeys.count!=0) {
        
        if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            blurredView.hidden=NO;
            view2.hidden=NO;
//            if (json2==nil) {
//                json2 = [[NSMutableArray alloc]init];
//            }
//            json2 = [json objectForKey:@"Appointments"];
//            [hudFirst hide:YES];
//            [_table reloadData];
            [hudFirst hide:YES];
            
        }
        else{
            _view2DateLbl.hidden=YES;
            _view2TImeTo.hidden=YES;
            _view2FromTime.hidden=YES;
            _view2TOLbl.hidden=YES;
            _view2Lbl.text= @"You are not available on this schedule.";
            blurredView.hidden=NO;
            view2.hidden=NO;
            flag=YES;
            [hudFirst hide:YES];
        }
    }
      [hudFirst hide:YES];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    _view2DateLbl.hidden=YES;
    _view2TImeTo.hidden=YES;
    _view2FromTime.hidden=YES;
    _view2TOLbl.hidden=YES;
    _view2Lbl.text= @"Sorry! Internal server error.";
    blurredView.hidden=NO;
    flag=YES;
    view2.hidden=NO;
    
    [hudFirst hide:YES];
}];

}




- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nav:(id)sender {
}
@end
