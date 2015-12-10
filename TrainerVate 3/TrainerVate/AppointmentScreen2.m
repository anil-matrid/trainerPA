//
//  ViewController.m
//  appointment screen2
//
//  Created by Matrid on 15/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AppointmentScreen2.h"
#import "Constants.h"

@interface AppointmentScreen2 () {
    NSArray *mys;
    NSDictionary *selectedUser;
    NSArray *searchResults;
    UISearchDisplayController *searchDisplayController;
}

@end

@implementation AppointmentScreen2
@synthesize blurredView, view2,bookTime,view3,view3Lbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (IS_IPHONE_4_OR_LESS) {
            _scroll.contentSize = CGSizeMake(320,560);
        }
    
        

   [self timeValidation];
    
     [datePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    self.appointmentButton.layer.cornerRadius = 11;
    blurredView.hidden = YES;
    view2.hidden = YES;
    view3.hidden=YES;
    
    offView2.hidden=YES;
    btnTitle.layer.cornerRadius= btnTitle.frame.size.height/2;
    lbluserName.layer.cornerRadius= lbluserName.frame.size.height/2;
    book2.layer.cornerRadius= book2.frame.size.height/2;
    lbluserName.clipsToBounds=YES;
    _appointmentButton.layer.cornerRadius= _appointmentButton.frame.size.height/2;
    
    // setting borders for text view/
    [[where layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[where layer] setBorderWidth:1];
    [[where layer] setCornerRadius:15];
    
    [[notes layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[notes layer] setBorderWidth:1];
    [[notes layer] setCornerRadius:15];

//    selectedUser = [[NSMutableArray alloc]init];
    
    // setting the view
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEE dd MMM yyyy"];
    lblFromDate.text = [formatter stringFromDate:self.CurrentDate];
    lblToDate.text = [formatter stringFromDate:self.CurrentDate];
    
    self.searchBarController.delegate = self;
   // self.searchBarController.searchResultsDataSource = self;
  //  self.searchBarController.searchResultsDelegate = self;
    
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBarController contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;

    // setting current time
//    lblFromTime.text=[[NSDate date] description];
//    lblToTime.text=[[NSDate date] description];

    // timer is set & will be triggered each second
    [self showTime];
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    
}

-(void)showTime{
    NSDate *StrDate = [NSDate date];
    NSDateFormatter *Dateformat = [[NSDateFormatter alloc]init];
    [Dateformat setDateFormat:@"hh:mm a"];
    NSString *DateStr = [Dateformat stringFromDate:StrDate];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:locale];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    DateStr = [df stringFromDate:[NSDate date]];
    [df setDateFormat:@"hh:mm"];
    lblFromTime.text=[df stringFromDate:[NSDate date]];
    lblToTime.text=[df stringFromDate:[NSDate date]];
    [df setDateFormat:@"a"];
    lblFromAmPm.text = [df stringFromDate:[NSDate date]];
    lblToAmPm.text = [df stringFromDate:[NSDate date]];

}

-(void)viewWillAppear:(BOOL)animated {
    if ([bookTime isEqualToString:@"1"]) {
        bookOffView.hidden=NO;
        offView2.hidden=NO;
        [btnTitle setTitle:@"Book Time Off" forState:normal];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        bookOffView.hidden=YES;
        offView2.hidden=NO;
        [btnTitle setTitle:@"Book Time Off" forState:normal];
    }
    else {
        BOOL flag=NO;
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[MyClientController class]]) {
                flag=YES;
                break;
                }
            else  {
               
            }
        }
        if (flag==NO && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
            [self callDataFormServer];
        }
        bookOffView.hidden=YES;
    }
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[MyClientController class]]) {
            _appointmentButton.enabled=NO;
            lbluserName.hidden=NO;
            lbluserName.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)appointmentButton:(id)sender {
    
    [self.view addSubview:self.searchView];
    self.searchView.center = self.view.center;
    [self.tableViews setHidden:NO];
    [self.searchView addSubview:self.tableViews];
    self.searchView.hidden = NO;
}
- (IBAction)timeOffButton:(id)sender {
}
- (IBAction)bookButton:(id)sender {
   
    
     if ([bookTime isEqualToString:@"1"]) {
         [self timeOffAppointment];
     }
     else {
         if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
             if ([lbluserName.text isEqualToString:@"Enter Client Name..."]) {
                 view3.hidden=NO;
                 blurredView.hidden=NO;
                 return;
             }
         }
         [self setAppointment];

     }
}

- (IBAction)okButton:(id)sender {
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[calenderViewController class]] ) {
            calenderViewController *tom = (calenderViewController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
        }
    }
}

- (void)timeOffAppointment{
    
    MBProgressHUD*    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //  hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"setBookOff/" apiKey:[Globals apiKey]];
    NSString *timeFromString =[NSString stringWithFormat:@"%@ %@",lblFromTime.text,lblFromAmPm.text];
    NSString *timetoString =[NSString stringWithFormat:@"%@ %@",lblToTime.text,lblToAmPm.text];
    NSString *dateFromString =[self dateStringToDateStringFormat:lblToDate.text];
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSDictionary *inputDic = [NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",timeFromString,@"time_from",timetoString,@"time_to",dateFromString,@"appointment_date",@"1",@"is_off", nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status_code"]isEqualToString:@"SUCCESS"]) {
            hudFirst.hidden = YES;
            blurredView.hidden=NO;
            view2.hidden=NO;
            _view2DateLbl.text=lblToDate.text;
            _view2TimeLbl1.text=timeFromString;
            _view2TimeLbl2.text=timetoString;
            _view2Lbl.text=@"Your Time-off has been noted.";
        }
        else {
            blurredView.hidden=NO;
            view2.hidden=NO;
            _view2DateLbl.hidden=YES;
            _view2TimeLbl1.hidden=YES;
            _view2TimeLbl2.hidden=YES;
            _to.hidden=YES;
            _view2Lbl.text=@"Sorry! Internal Server Error.";
            [hudFirst hide:YES];
        }
        [hudFirst hide:YES];
        
    }
    failure:^(NSError *error) {
        blurredView.hidden=NO;
        view2.hidden=NO;
        _view2DateLbl.hidden=YES;
        _view2TimeLbl1.hidden=YES;
        _view2TimeLbl2.hidden=YES;
        _to.hidden=YES;
        _view2Lbl.text=@"Sorry! Internal Server Error.";
        [hudFirst hide:YES];
    }];
    
}

- (void)setAppointment{
      MBProgressHUD*    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  //  hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];

    
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"schedule_appointment/" apiKey:[Globals apiKey]];
    NSString *timeFromString =[NSString stringWithFormat:@"%@ %@",lblFromTime.text,lblFromAmPm.text];
    NSString *timetoString =[NSString stringWithFormat:@"%@ %@",lblToTime.text,lblToAmPm.text];
    NSString *dateFromString =[self dateStringToDateStringFormat:lblToDate.text];
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID = [selectedUser objectForKey:@"id"];
    
    NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-4];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"MyClientController"]) {
        clientID=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    }
    NSDictionary *inputDic;
    NSString *trainnerYes = [[NSUserDefaults standardUserDefaults]objectForKey:@"userType"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
         //Dictionary for trainer..
        
        inputDic = [NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientID,@"client_id",timeFromString,@"time_from",timetoString,@"time_to",dateFromString,@"appointment_date",@"0",@"is_accepted",where.text,@"place",notes.text,@"note",trainnerYes,@"is_from_trainer",bookTime,@"is_off", nil];
        [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
            if ([[responseObject objectForKey:@"status_code"]isEqualToString:@"SUCCESS"]) {
                hudFirst.hidden = YES;
                blurredView.hidden=NO;
                view2.hidden=NO;
                _view2TimeLbl1.text = timeFromString;
                _view2TimeLbl2.text = timetoString;
//                _view2DateLbl.text = dateFromString;
                _view2DateLbl.text = lblToDate.text;

            }
            else if ([[responseObject objectForKey:@"status_code"]isEqualToString:@"E_BUSY"]) {
                    blurredView.hidden=NO;
                    view2.hidden=NO;
                    _view2DateLbl.hidden=YES;
                    _view2TimeLbl1.hidden=YES;
                    _view2TimeLbl2.hidden=YES;
                    _to.hidden=YES;
                    _view2Lbl.text=@"You already have an appointment at this time.";
                    [hudFirst hide:YES];
            }
            else
            {
                blurredView.hidden=NO;
                view2.hidden=NO;
                _view2DateLbl.hidden=YES;
                _view2TimeLbl1.hidden=YES;
                _view2TimeLbl2.hidden=YES;
                _to.hidden=YES;

                _view2Lbl.text=@"Appointment could not be made at this time.";
                [hudFirst hide:YES];
            }
            [hudFirst hide:YES];
            
        } failure:^(NSError *error) {
            blurredView.hidden=NO;
            view2.hidden=NO;
            _view2DateLbl.hidden=YES;
            _view2TimeLbl1.hidden=YES;
            _view2TimeLbl2.hidden=YES;
            _to.hidden=YES;

            _view2Lbl.text=@"Sorry! Internal Server Error.";

            [hudFirst hide:YES];
        }];
        

    }
    
    else {
        //Dictionary for client..
        clientID = [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
        inputDic = [NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientID,@"client_id",timeFromString,@"time_from",timetoString,@"time_to",dateFromString,@"appointment_date",@"0",@"is_accepted",where.text,@"place",notes.text,@"note",trainnerYes,@"is_from_trainer",@"0",@"is_off", nil];
    
   
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"]isEqualToString:@"SUCCESS"]) {
            hudFirst.hidden = YES;
            blurredView.hidden=NO;
            view2.hidden=NO;
           _view2Lbl.text=@"Your appointment has been requested.";
            _view2DateLbl.text = lblToDate.text;
            _view2TimeLbl1.text = timeFromString;
            _view2TimeLbl2.text = timetoString;

        }
        else
        {
            blurredView.hidden=NO;
            view2.hidden=NO;
            _view2DateLbl.hidden=YES;
            _view2TimeLbl1.hidden=YES;
            _view2TimeLbl2.hidden=YES;
            _to.hidden=YES;

            _view2Lbl.text=@"Some error occured. Please Try Again";
            
            [hudFirst hide:YES];
        }
        [hudFirst hide:YES];
        
    } failure:^(NSError *error) {
        blurredView.hidden=NO;
        view2.hidden=NO;
        _view2DateLbl.hidden=YES;
        _view2TimeLbl1.hidden=YES;
        _view2TimeLbl2.hidden=YES;
        _to.hidden=YES;

        _view2Lbl.text=@"Sorry! Internal Server Error.";
        
        [hudFirst hide:YES];
    }];
    }
}
#pragma mark- picker view****************************************************************

- (IBAction)doneBtn:(UIButton *)sender {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSString *dateTimeString;
    
    if (datePicker.tag==0) {
        [dateFormat setDateFormat:@"EEE dd MMM yyyy"];
        dateTimeString = [dateFormat stringFromDate:datePicker.date];
        lblFromDate.text=dateTimeString;
    }
    else if (datePicker.tag==1){
        [dateFormat setDateFormat:@"EEE dd MMM yyyy"];
        dateTimeString = [dateFormat stringFromDate:datePicker.date];
        lblToDate.text=dateTimeString;
    }
    else if (datePicker.tag==2){
        
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [df setLocale:locale];
        [df setDateStyle:NSDateFormatterNoStyle];
        [df setTimeStyle:NSDateFormatterShortStyle];
        [df setDateFormat:@"hh:mm"];
        lblFromTime.text=[df stringFromDate:datePicker.date];
        [df setDateFormat:@"a"];
        lblFromAmPm.text =[df stringFromDate:datePicker.date];
    }
    else if (datePicker.tag==3){
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [df setLocale:locale];
        [df setDateStyle:NSDateFormatterNoStyle];
        [df setTimeStyle:NSDateFormatterShortStyle];
        [df setDateFormat:@"hh:mm"];
        lblToTime.text=[df stringFromDate:datePicker.date];
        [df setDateFormat:@"a"];
        lblToAmPm.text=[df stringFromDate:datePicker.date];
    }
    [self showPickerValue:NO];
    [self timeValidation];
}

- (IBAction)btnDateSelect:(UIButton *)sender {
    if (sender.tag == 0 || sender.tag==1) {
        datePicker.datePickerMode = UIDatePickerModeDate;
    }
    else{
         datePicker.datePickerMode = UIDatePickerModeTime;
    }
    
    datePicker.tag = sender.tag;
    [self showPickerValue:YES];
}

//- (IBAction)btnTimeSelect:(UIButton*)sender {
//    datePicker.datePickerMode = UIDatePickerModeTime;
//    datePicker.tag = sender.tag;
//    [self showPickerValue:YES];
//}

-(void)showPickerValue:(BOOL)flag{
    if (flag) {
        
            CGRect rectPicker = datePicketViewBg.frame;
            rectPicker.origin.y = self.view.frame.size.height;
            datePicketViewBg.frame = rectPicker;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rectPicker = datePicketViewBg.frame;
            rectPicker.origin.y = self.view.frame.size.height - datePicketViewBg.frame.size.height;
            datePicketViewBg.frame = rectPicker;
        }];
    }
    else{
            [UIView animateWithDuration:0.5 animations:^{  
            CGRect rectPicker = datePicketViewBg.frame;
            rectPicker.origin.y = self.view.frame.size.height;
            datePicketViewBg.frame = rectPicker;
        }];
    }
}
-(NSString *)dateStringToDateStringFormat:(NSString *)stirng{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
     [formatter setDateFormat:@"EEE dd MMM yyyy"];
    NSDate *date=[formatter dateFromString:stirng];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    stirng = [formatter stringFromDate:date];
    return stirng;
}

- (void)callDataFormServer {
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlGetTrainersClient apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionary];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                mys =[json objectForKey:@"returnset"];
                searchResults = mys;
                //                [SingletonClass singleton].MyClientDetail=[[json objectForKey:@"returnset"] mutableCopy];
                //                clientsName=[mys valueForKey:@"name"];
                
                [hudFirst hide:YES];
                
            }
            else{
                
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        
    }];
    
}
#pragma tableView***********************************************************************

- (NSInteger)tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return searchResults.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //custom Cell for row
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil )
    {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
//    if ([selectedUser containsObject:[mys objectAtIndex:indexPath.row]])
//    {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    cell.textLabel.text = [[searchResults objectAtIndex:indexPath.row] objectForKey:@"name"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.searchView.hidden = YES;
    if (searchDisplayController.searchBar.text.length==0) {
        searchResults=[mys mutableCopy];
    }
    [searchDisplayController setActive:NO animated:YES];
    selectedUser =  [searchResults objectAtIndex:indexPath.row];
    _searchView.hidden=YES;
    [_tableViews setHidden:YES];
    [_searchView removeFromSuperview];
   // [self.tableViews removeFromSuperview];
    lbluserName.text = [selectedUser objectForKey:@"name"];
    [self.view endEditing:YES];
    
//    if ([selectedUser containsObject:[searchResults objectAtIndex:indexPath.row]]) {
//        NSInteger Index = [selectedUser indexOfObject:[searchResults objectAtIndex:indexPath.row]];
//        [selectedUser removeObjectAtIndex:Index];
//    }
//    else{
//        [selectedUser addObject:[searchResults objectAtIndex:indexPath.row]];
//    }
//    [tableView reloadData];
 }
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [mys filteredArrayUsingPredicate:resultPredicate];
    
}



-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}



- (IBAction)view3Ok:(id)sender {
    view3.hidden=YES;
    blurredView.hidden=YES;
}
-(void)timeValidation{
    NSString *timeFromString =[NSString stringWithFormat:@"%@ %@",lblFromTime.text,lblFromAmPm.text];
    NSString *timetoString =[NSString stringWithFormat:@"%@ %@",lblToTime.text,lblToAmPm.text];
    
    //    NSDate *StrDate = lblFromTime.text;
    //    NSDateFormatter *Dateformat = [[NSDateFormatter alloc]init];
    //    [Dateformat setDateFormat:@"hh:mm a"];
    //    NSString *DateStr = [Dateformat stringFromDate:StrDate];
    //
    //    NSString *strCurrentDate = strDate;
    //    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    //    [df setDateFormat:@"dd-MM-yyyy"];
    //    NSString *strServerDate =[dateFormatter2 stringFromDate:pickerDate.date];
    
    
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:locale];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    [df setDateFormat:@"hh:mm a"];
    NSDate *currentDate = [df dateFromString:timeFromString];
    NSDate *serverDate = [df dateFromString:timetoString];
    NSComparisonResult result;
    result = [currentDate compare:serverDate];
    
    if (result == NSOrderedSame) {
        [bookBtn setEnabled:NO];
    }
    else if (result == NSOrderedDescending) {
        [bookBtn setEnabled:NO];
    }
    
    else {
        [bookBtn setEnabled:YES];
    }
    
}

@end
