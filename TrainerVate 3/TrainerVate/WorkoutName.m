//
//  Workout Name.m
//  My Client- Workout
//
//  Created by Matrid on 24/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "WorkoutName.h"
#import "ResultControllerCustomCell.h"
#import "SingletonClass.h"
#import "Globals.h"
#import "Constants.h"
#import "ResultController.h"
#import "workoutController.h"
#import "ExerciseName.h"
#import "SearchExerciseController.h"


@interface WorkoutName ()

{
    NSMutableArray *weights;
    NSMutableArray *speed;
    NSMutableArray *reps;
    NSMutableArray *exerciseName;
    NSMutableArray *images;
    int senderTag;
    int selectedBtn;
    NSString *selectedValue;
    NSArray *pickerValue;
    NSArray *pickerDay;
    int count;
    NSString *jsonString;
    NSMutableArray *json2;
    NSArray *mapId;
    NSMutableDictionary *dict;
    NSString *everyday;
    NSInteger index;
    ReminderView *reminder;
}

@end

@implementation WorkoutName
@synthesize tableViews,blurredView,ndict,workoutName,DicCurrentDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"WorkoutName" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"WorkoutName_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    
    
    
    [SingletonClass singleton].selectedWorkout=nil;
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Workout Name"];
    // Do any additional setup after loading the view from its nib.
    ndict=[[NSDictionary alloc]init];
    [self callDataFormServer];
    weights = [NSMutableArray arrayWithObjects:@"5 kg",@"10 kg",@"15 kg", nil];
    speed = [NSMutableArray arrayWithObjects:@"Easy",@"Medium",@"Hard", nil];
    reps = [NSMutableArray arrayWithObjects:@"1",@"2",@"10", nil];
    exerciseName = [NSMutableArray arrayWithObjects:@"Exercise Name",@"Exercise Name",@"Exercise Name", nil];
    images = [NSMutableArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg",@"workout.jpeg", nil];
    
    //rounding up days buttons.
    
    
    //arrays
    json2 = [[NSMutableArray alloc]init];
    pickerValue=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    pickerDay=[NSArray arrayWithObjects:@"Daily",@"Weekly", nil];
    [_menuBtn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _lblWorkout.text=workoutName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    blurredView.hidden=YES;
    _viewMessages.hidden=YES;
    blurredView.hidden=YES;
    _confirmationView.hidden=YES;
    dict =[[NSMutableDictionary alloc]init];
    [self setDefaultValue];
    _errorVIew.hidden=YES;
    // CALLING IMPLEMENTED API
    if (json2==nil) {
        json2 = [[NSMutableArray alloc]init];
    }
    
    if ([SingletonClass singleton].selectedWorkout.count !=0) {
        BOOL Exists = NO;
        for ( int i=0; i<json2.count; i++) {
            NSDictionary *currentDic;// = [json2 objectAtIndex:i];
            NSDictionary *jsonDic =[[SingletonClass singleton].selectedWorkout mutableCopy];
            
            currentDic = [json2 objectAtIndex:i];
            if ([[currentDic objectForKey:@"workout_exc_id"] isEqualToString:[jsonDic objectForKey:@"workout_exc_id"]]) {
                Exists = YES;
                [json2 replaceObjectAtIndex:i withObject:jsonDic];
            }
            if ([currentDic isEqualToDictionary:jsonDic] && [[SingletonClass singleton].workoutRemove isEqualToString:[currentDic objectForKey:@"workout_exc_id"]]) {
                [json2 removeObjectAtIndex:i];
                [SingletonClass singleton].workoutRemove=@"0";
            }
        }
        if (!Exists) {
            [json2 addObject:[[SingletonClass singleton].selectedWorkout mutableCopy]];
            [SingletonClass singleton].selectedWorkout=nil;
        }
        
        [tableViews reloadData];
    }
    
    if (json2==nil || json2.count==0) {
        tableViews.hidden=YES;
        _errorVIew.hidden=NO;
    }
    else {
        tableViews.hidden=NO;
        _errorVIew.hidden=YES;
    }
//   if ([SingletonClass singleton].selectedWorkout.count != 0 || [SingletonClass singleton].selectedWorkout==nil) {
//
//        [temp addObject:[[SingletonClass singleton].selectedWorkout mutableCopy]];
//       
//        //[json2 addObject:[temp mutableCopy]];
//        [tableViews reloadData];
//    }
   
   

}

//TABLE VIEW STARTS...

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return json2.count;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCell = @"default";
    ResultControllerCustomCell *cell = (ResultControllerCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *mArray = [[NSBundle mainBundle]loadNibNamed:@"ResultControllerCustomCell" owner:self options:nil];
        cell = [mArray objectAtIndex:0];
        
    }
    cell.namelbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"exercise_name"];
    cell.weightlbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"weights"];
    cell.speedlbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"speed"];
    cell.repslbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"reps"];
    cell.lblTime.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"exercise_time"];
    return cell;
}
//IMPLEMENTING LONG PRESS FUNCTION ON TABLE CELL

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [SingletonClass singleton].selectedWorkout = [json2 objectAtIndex:indexPath.row];
    [SingletonClass singleton].remove= [[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_exc_id"];
    ExerciseName *tepl=[[ExerciseName alloc]initWithNibName:@"ExerciseName" bundle:nil];
    
    [self.navigationController pushViewController:tepl animated:YES];

}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menubtn:(id)sender {
}

- (IBAction)addbtn:(id)sender {
    [SingletonClass singleton].selectedWorkout=nil;
    [SingletonClass singleton].existWorkouts=[json2 mutableCopy];
    ResultController *templ =[[ResultController alloc]initWithNibName:@"ResultController" bundle:nil];
    [self.navigationController pushViewController:templ animated:YES];
}

- (IBAction)editbtn:(id)sender {
    
    if (json2.count==0) {
        _viewMessages.hidden=NO;
        blurredView.hidden=NO;
        _lblMessages.text=@"Please add Atleast one exercise.";
        [Globals showBounceAnimatedView:self.viewMessages completionBlock:nil];
        return;
    }
    NSLog(@"%@",DicCurrentDic);
    
    reminder = [[ReminderView alloc]init];
    reminder.center = self.view.center;
    reminder.delegate=self;
    reminder.NumberOf= [[DicCurrentDic objectForKey:@"occurance"] intValue];
    DicCurrentDic=[[Globals removeNullFormDictionary:DicCurrentDic] mutableCopy];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
//    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
//    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    dateFormatters.dateFormat = @"hh:mm a";
    NSString *currentTime = [dateFormatters stringFromDate:[NSDate date]];
    if ([[DicCurrentDic objectForKey:@"set_time_1"] isEqualToString:@"0"]) {
        reminder.txtSetTime1.text=currentTime;
    }
    else {
        reminder.txtSetTime1.text=[DicCurrentDic objectForKey:@"set_time_1"];
    }
    
    if ([[DicCurrentDic objectForKey:@"set_time_2"] isEqualToString:@"1"]) {
        reminder.txtSetTime2.text=@"";
    }
    else {
        reminder.txtSetTime2.text=[DicCurrentDic objectForKey:@"set_time_2"];
    }

    if ([[DicCurrentDic objectForKey:@"set_time_3"] isEqualToString:@"2"]) {
        reminder.txtSetTime3.text=@"";
    }
    else {
        reminder.txtSetTime3.text=[DicCurrentDic objectForKey:@"set_time_3"];
    }
    NSArray *SlectedDaysArray = [Globals getDaysIntoInteger:DicCurrentDic];
    if (SlectedDaysArray.count!=7) {
        reminder.SlectedDaysArray = [SlectedDaysArray mutableCopy];
    }
    [reminder reloadDaysBtns];
    if ([[DicCurrentDic objectForKey:@"sunday"]isEqualToString:@"1"] && [[DicCurrentDic objectForKey:@"monday"]isEqualToString:@"1"] && [[DicCurrentDic objectForKey:@"tuesday"]isEqualToString:@"1"] && [[DicCurrentDic objectForKey:@"wednesday"]isEqualToString:@"1"] && [[DicCurrentDic objectForKey:@"thursday"]isEqualToString:@"1"] && [[DicCurrentDic objectForKey:@"friday"]isEqualToString:@"1"] && [[DicCurrentDic objectForKey:@"saturday"]isEqualToString:@"1"] ) {
        reminder.viewsDaysBtns.hidden = YES;
        reminder.txtDays.text=@"      Daily";
        [reminder reloadData];
    }
    else if ([[dict objectForKey:@"everyday"] isEqualToString:@"1"]) {
        reminder.viewsDaysBtns.hidden = YES;
        [self setDefaultValue];
        reminder.txtDays.text=@"      Daily";
        [reminder reloadData];
    }

    else if ([[DicCurrentDic objectForKey:@"sunday"]isEqualToString:@"1"] || [[DicCurrentDic objectForKey:@"monday"]isEqualToString:@"1"] || [[DicCurrentDic objectForKey:@"tuesday"]isEqualToString:@"1"] || [[DicCurrentDic objectForKey:@"wednesday"]isEqualToString:@"1"] || [[DicCurrentDic objectForKey:@"thursday"]isEqualToString:@"1"] || [[DicCurrentDic objectForKey:@"friday"]isEqualToString:@"1"] || [[DicCurrentDic objectForKey:@"saturday"]isEqualToString:@"1"] ) {
        reminder.viewsDaysBtns.hidden = NO;
        reminder.txtDays.text=@"      Weekly";
        
        [reminder reloadData];
    }
    else{
        reminder.txtDays.text=@"        Daily";
        reminder.viewsDaysBtns.hidden=YES;
        [reminder reloadData];
    }
   
    [self.view addSubview:reminder];
    blurredView.hidden=NO;
    [Globals showBounceAnimatedView:reminder completionBlock:nil];
}
- (IBAction)sendbtn:(id)sender {
    NSError *error = nil;
    NSMutableArray *currentCheckArray =[json2 mutableCopy];
    for (int i=0; i<currentCheckArray.count; i++) {
        NSMutableDictionary *currentDic=[[currentCheckArray objectAtIndex:i] mutableCopy];
        if ([currentDic objectForKey:@"media_type"]) {
            [currentDic removeObjectForKey:@"media_type"];
        }
        if ([currentDic objectForKey:@"media_url"]) {
            [currentDic removeObjectForKey:@"media_url"];
        }
        if ([currentDic objectForKey:@"exercise_name"]) {
            [currentDic removeObjectForKey:@"exercise_name"];
        }
        [currentCheckArray replaceObjectAtIndex:i withObject:currentDic];
    }

    NSData *jsonData=[NSJSONSerialization dataWithJSONObject:currentCheckArray options:0 error:&error];
    jsonString=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    //CALLING API TO UPLOAD EXERCISE BUNDEL
    [self callDataFormServers];

}

-(void)CrossButtonTapped{
    blurredView.hidden=YES;
}
-(void)ReminderViewDetialsDays:(NSString *)daySet numberOfTimes:(NSString *)numberOfTime setTime1:(NSString *)setTime1 setTime2:(NSString *)setTime2 setTime3:(NSString *)setTime3 DaysArray:(NSArray *)daysArray{
    
    if ([daySet isEqualToString:@"      Weekly"] && daysArray.count==0) {
        self.viewMessages.hidden=NO;
        self.lblMessages.text=@"Please select at least one day!";
        [self.view bringSubviewToFront:self.viewMessages];
        return;
    }
    if ([numberOfTime intValue]==1) {
       // setTime3=@"0";
       // setTime2=@"0";
    }
    if ([numberOfTime intValue]==2) {
        if ([setTime1 isEqualToString:setTime2]) {
           // setTime3=@"0";
            self.viewMessages.hidden=NO;
            self.lblMessages.text=@"Time can not be same.";
            [self.view bringSubviewToFront:self.viewMessages];
            return;
        }
    }
    if ([numberOfTime intValue]==3) {
        if ([setTime1 isEqualToString:setTime2] || [setTime2 isEqualToString:setTime3] || [setTime1 isEqualToString:setTime3]) {
            self.viewMessages.hidden=NO;
            self.lblMessages.text=@"Time can not be same.";
            [self.view bringSubviewToFront:self.viewMessages];
            return;
        }
    }
    if ([daySet isEqualToString:@"      Weekly"]) {
        [dict setObject:@"0" forKey:@"everyday"];
    }
    else {
        [dict setObject:@"1" forKey:@"everyday"];
    }
    if ([daysArray containsObject:@"Monday"]) {
        [dict setObject:@"1"  forKey:@"monday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"monday"];
    }
    if ([daysArray containsObject:@"Tuesday"]) {
        [dict setObject:@"1"  forKey:@"tuesday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"tuesday"];
    }
    if ([daysArray containsObject:@"Wednesday"]) {
        [dict setObject:@"1"  forKey:@"wednesday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"wednesday"];
    }
    if ([daysArray containsObject:@"Thursday"]) {
        [dict setObject:@"1"  forKey:@"thursday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"thursday"];
    }
    if ([daysArray containsObject:@"Friday"]) {
        [dict setObject:@"1"  forKey:@"friday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"friday"];
    }
    if ([daysArray containsObject:@"Saturday"]) {
        [dict setObject:@"1"  forKey:@"saturday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"saturday"];
    }
    if ([daysArray containsObject:@"Sunday"]) {
        [dict setObject:@"1"  forKey:@"sunday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"sunday"];
    }
    if ([numberOfTime intValue]==1) {
        [dict setObject:setTime1 forKey:@"set_time_1"];
        [dict setObject:@"1" forKey:@"set_time_2"];
        [dict setObject:@"2" forKey:@"set_time_3"];
    }
    if ([numberOfTime intValue]==2) {
        [dict setObject:setTime1 forKey:@"set_time_1"];
        [dict setObject:setTime2 forKey:@"set_time_2"];
        [dict setObject:@"2" forKey:@"set_time_3"];
    }
    if ([numberOfTime intValue]==3) {
        [dict setObject:setTime1 forKey:@"set_time_1"];
        [dict setObject:setTime2 forKey:@"set_time_2"];
        [dict setObject:setTime3 forKey:@"set_time_3"];
    }
    
    [dict setObject:numberOfTime forKey:@"occurance"];
   
    reminder.hidden=YES;
    [self setReminder];
}


-(void)ReminderVIewObject:(UIView *)View{
    View.center = self.view.center;
}


- (void)setReminder {
        MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/setWorkout_reminder/abc266661b7732d92ffb8e264de00474/960b1c88c2cc38c2836ddb4872aea6ea";
    
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientID,@"client_id",[dict objectForKey:@"everyday"],@"everyday",[dict objectForKey:@"monday"],@"monday",[dict objectForKey:@"tuesday"],@"tuesday",[dict objectForKey:@"wednesday"],@"wednesday",[dict objectForKey:@"thursday"],@"thursday",[dict objectForKey:@"friday"],@"friday",[dict objectForKey:@"saturday"],@"saturday",[dict objectForKey:@"sunday"],@"sunday",[dict objectForKey:@"occurance"],@"occurance",[dict objectForKey:@"set_time_1"],@"set_time_1",[dict objectForKey:@"set_time_2"],@"set_time_2",[dict objectForKey:@"set_time_3"],@"set_time_3",[[SingletonClass singleton].clientDat objectForKey:@"workout_id"],@"workout_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                //This for loop iterates through all the view controllers in navigation stack.
                [reminder removeFromSuperview];
                if ([[dict objectForKey:@"everyday"] isEqualToString:@"1"]) {
    
                    [self setDefaultValue];
                    [reminder reloadData];
                }
                
                DicCurrentDic=dict;
                blurredView.hidden=YES;
                [hudFirst hide:YES];
            }
            else{
                blurredView.hidden=NO;
                _viewMessages.hidden=NO;
                [reminder removeFromSuperview];
                _lblMessages.text=@"Sorry! Internal Server Error.";
                [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
                [hudFirst hide:YES];
            }
        }
        else {
            blurredView.hidden=NO;
            _viewMessages.hidden=NO;
            [reminder removeFromSuperview];
            _lblMessages.text=@"Sorry! Internal Server Error.";
            [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
            
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        blurredView.hidden=NO;
        _viewMessages.hidden=NO;
       [reminder removeFromSuperview];
        _lblMessages.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
        
        [hudFirst hide:YES];
    }];
    
    
}


// picker view DELEGATE METHODS STARTS.

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (selectedBtn==1) {
        selectedValue = [pickerDay objectAtIndex:row];
    }
    else if (selectedBtn==2) {
        selectedValue = [pickerValue objectAtIndex:row];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (selectedBtn==1) {
        return [pickerDay count];
    }
    else{
        return [pickerValue count];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (selectedBtn==1) {
        return [pickerDay objectAtIndex:row];
              }
    
    
    else{
        return [pickerValue objectAtIndex:row];
    }
}
// PICKER VIEW DELEGATES ENDS.




//UPDATING WORKOUT API
-(void)callDataFormServers
{
    if (json2.count==0) {
        _viewMessages.hidden=NO;
        blurredView.hidden=NO;
        _lblMessages.text=@"Please add Atleast one exercise.";
        [Globals showBounceAnimatedView:self.viewMessages completionBlock:nil];
        return;
    }
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"addExerciseToRecommendedWorkouts/" apiKey:[Globals apiKey]];
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID =[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *workoutID= [[SingletonClass singleton].clientDat objectForKey:@"workout_id"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"data",trainerID,@"trainer_id",clientID,@"client_id",workoutID,@"workout_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                blurredView.hidden=NO;
                _confirmationView.hidden=NO;
                [hudFirst hide:YES];
            }
            else{
                
                _viewMessages.hidden=NO;
                blurredView.hidden=NO;
                _lblMessages.text=@"Please add Atleast one exercise.";
                [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
                [hudFirst hide:YES];
            
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _viewMessages.hidden=NO;
        blurredView.hidden=NO;
        _lblMessages.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
        [hudFirst hide:YES];
        
    }];
    
}


//HITTING API
-(void)callDataFormServer
{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *urlString = [Globals urlCombileHash:kApiDomin3 ClassUrl:@"getExercises/" apiKey:[Globals apiKey]];
    NSString *workoutID= [[SingletonClass singleton].clientDat objectForKey:@"workout_id"];
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",trainerID,@"trainer_id",workoutID,@"workout_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
                if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                    json2 = [[json objectForKey:@"returnset" ]mutableCopy];
                    tableViews.hidden=NO;
                    _errorVIew.hidden=YES;
                    [tableViews reloadData];
                    [hudFirst hide:YES];
                }
                else{
                    [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
                    _errorVIew.hidden=NO;
                    tableViews.hidden=YES;
                    _lblmsg.text=@"No Exercises yet!";
                    [hudFirst hide:YES];
                 }
        }
        else {
            _errorVIew.hidden=NO;
            tableViews.hidden=YES;
            _lblmsg.text=@"Sorry! Internal Server Error.";
            [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
            
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _errorVIew.hidden=NO;
        tableViews.hidden=YES;
        _lblmsg.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorVIew completionBlock:nil];
        [hudFirst hide:YES];
        
    }];
    
}

-(void)setDefaultValue{
    [dict setObject:@"0" forKey:@"monday"];
    [dict setObject:@"0" forKey:@"tuesday"];
    [dict setObject:@"0" forKey:@"wednesday"];
    [dict setObject:@"0" forKey:@"thursday"];
    [dict setObject:@"0" forKey:@"friday"];
    [dict setObject:@"0" forKey:@"saturday"];
    [dict setObject:@"0" forKey:@"sunday"];
    [dict setObject:@"0" forKey:@"everyday"];
}


- (IBAction)ok:(id)sender {
    _viewMessages.hidden=YES;
    if ( _viewMessages.hidden==YES) {
        blurredView.hidden=YES;
    }
    if (reminder.hidden==YES) {
        blurredView.hidden=YES;
    }
    if (reminder.hidden==NO && _viewMessages.hidden==YES && reminder!=nil) {
        blurredView.hidden=NO;
    }
}

- (IBAction)btnOk:(id)sender {
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[workoutController class]] ) {
            workoutController *tom = (workoutController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
        }
    }
}

@end