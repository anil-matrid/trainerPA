//
//  Workout Name 2.m
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "WorkoutName2.h"
#import "ResultControllerCustomCell.h"
#import "customWorkoutController.h"
#import "SingletonClass.h"
#import "Globals.h"
#import "workoutController.h"
#import "ResultController.h"
#import "ExerciseName.h"
#import "workoutDietPlanLibraryController.h"
#import "Constants.h"

@interface WorkoutName2 ()
{
    BOOL LongPressFlag;
    int selectedUser;
    NSMutableArray *weights;
    NSMutableArray *speed;
    NSMutableArray *reps;
    NSMutableArray *exerciseName;
    NSMutableArray *images;
    NSMutableArray *json2;
    int senderTag;
    int selectedBtn;
    NSString *selectedValue;
    NSArray *pickerValue;
    NSArray *pickerDay;
    int count;
    NSMutableArray *updatedExercise;
    NSString *jsonString;
    NSString *mapId;
    NSMutableDictionary *dict;
    NSInteger index;
    ReminderView *reminder;
}

@end

@implementation WorkoutName2
@synthesize tableViews,blurredView,successView,successReminderBtn,finishBtn,exeName,workoutName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"MyClientController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"WorkoutName2" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"WorkoutName2_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Workout Name 2"];
    // Do any additional setup after loading the view from its nib.
    [self workoutExercise];
    // LONG PRESS FUNCTIONALITY STARTS..
    json2=[[NSMutableArray alloc]init];
    [_navigationBAr addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"customWorkoutController"]) {
         _lblWorkOutName.text = [[SingletonClass singleton].clientDat  objectForKey:@"WorkoutName"];
    }
    else {
        _lblWorkOutName.text = workoutName;
    }
    
    // ARRAYS..
    updatedExercise= [[NSMutableArray alloc]init];
    pickerValue=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    pickerDay=[NSArray arrayWithObjects:@"Daily",@"Weekly",@"Monthly",nil];
    
    // ROUNDING UP THE BUTTONS..
    successReminderBtn.layer.cornerRadius=successReminderBtn.bounds.size.height/2.0;
    finishBtn.layer.cornerRadius=finishBtn.bounds.size.height/2.0;
    
}


- (void)viewWillAppear:(BOOL)animated {
   
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
        _sendWorkout.hidden=YES;
        _addExercise.hidden=YES;
        _btnBg.hidden=YES;
        _viewToHide.hidden=NO;
        
        _lblWorkOutName.text=exeName;
    }
    _viewDuplicate.hidden=YES;
    successView.hidden=YES;
    blurredView.hidden=YES;
    _viewForNoData.hidden=YES;
    _viewApiPosterror.hidden=YES;
    _textBackground.layer.cornerRadius=_textBackground.frame.size.height/2;
    dict =[[NSMutableDictionary alloc]init];
    [self setDefaultValue];
    
    //ADDING EXERCISE TO TABLEVIEW WHICH WE GOT FROM PREVIOUS VIEW
    if ([SingletonClass singleton].selectedWorkout.count !=0) {
        
        BOOL Exists = NO;
        for ( int i=0; i<json2.count; i++) {
            NSDictionary *currentDic = [json2 objectAtIndex:i];
            NSDictionary *jsonDic =[[SingletonClass singleton].selectedWorkout mutableCopy];
            
            currentDic = [json2 objectAtIndex:i];
            if ([[currentDic objectForKey:@"workout_exc_id"] isEqualToString:[jsonDic objectForKey:@"workout_exc_id"]]) {
                Exists = YES;
                [json2 replaceObjectAtIndex:i withObject:jsonDic];
            }
           if ([currentDic isEqualToDictionary:jsonDic] && [[SingletonClass singleton].workoutRemove isEqualToString:[currentDic objectForKey:@"workout_exc_id"]]) {
                [json2 removeObjectAtIndex:i];
                Exists = YES;
                [SingletonClass singleton].workoutRemove=@"0";
            }
        }
        if (Exists==NO) {
            [json2 addObject:[[SingletonClass singleton].selectedWorkout mutableCopy]];
                    }
        
        [tableViews reloadData];
    }
    [SingletonClass singleton].selectedWorkout=nil;

    if (json2==nil || json2.count==0) {
        _viewForNoData.hidden=NO;
        tableViews.hidden=YES;
    }
    else {
        _viewForNoData.hidden=YES;
        tableViews.hidden=NO;
        [tableViews reloadData];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// TABLE VIEW DELEGATE METHODS STARTS..

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return json2.count+updatedExercise.count;
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
    if (indexPath.row<json2.count && json2.count!=0 && json2!=nil) {
        cell.namelbl.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"exercise_name"];
        cell.weightlbl.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"weights"];
        cell.speedlbl.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"speed"];
        cell.repslbl.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"reps"];
        cell.lblTime.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"exercise_time"];
    }
    else if(updatedExercise.count!=0 && updatedExercise!=nil) {
        cell.namelbl.text = [[updatedExercise objectAtIndex:indexPath.row-json2.count] valueForKey:@"exercise_name"];
        cell.weightlbl.text = [[updatedExercise objectAtIndex:indexPath.row-json2.count] valueForKey:@"weights"];
        cell.speedlbl.text = [[updatedExercise objectAtIndex:indexPath.row-json2.count] valueForKey:@"speed"];
        cell.repslbl.text = [[updatedExercise objectAtIndex:indexPath.row-json2.count] valueForKey:@"reps"];
        cell.lblTime.text = [[updatedExercise objectAtIndex:indexPath.row-json2.count] valueForKey:@"exercise_time"];
    }
    
    //    cell.tick.image= [UIImage imageNamed:@"tick.png"];
    //    cell.tick.hidden=YES;
    return cell;
}

// TABLE VIEW DELEGATE METHODS END...

//HANDLE LONG PRESS FUNCTIONALITY ON TABLE CELL..

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
    if (indexPath.row<json2.count && json2.count!=0) {
        [SingletonClass singleton].selectedWorkout = [json2 objectAtIndex:indexPath.row];
    }
    else {
        [SingletonClass singleton].selectedWorkout = [updatedExercise objectAtIndex:indexPath.row-json2.count];
    }
    ExerciseName *temp=[[ExerciseName alloc]initWithNibName:@"ExerciseName" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
    
    
}

//LONG PRESS FUNCTIONALITY ENDS..


- (IBAction)sendWorkoutbtn:(id)sender {
       
    //CALLING API TO UPLOAD EXERCISE BUNDEL
     NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"customWorkoutController"]) {
        [self create];
    }
    else {
        [self apicalls];
    }
    
}
- (IBAction)addbtn:(id)sender {
    [SingletonClass singleton].existWorkouts=[[updatedExercise arrayByAddingObjectsFromArray:json2] mutableCopy];
    ResultController *sec =[[ResultController alloc]initWithNibName:@"ResultController" bundle:nil];
    [self.navigationController pushViewController:sec animated:YES];
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menubtn:(id)sender {
}

// PERFORMING ACTION ON DAYS BUTTONS..
-(void)CrossButtonTapped{
    self.blurredView.hidden=YES;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[workoutController class]] ) {
            workoutController *tom = (workoutController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
        }
    }
}
-(void)ReminderViewDetialsDays:(NSString *)daySet numberOfTimes:(NSString *)numberOfTime setTime1:(NSString *)setTime1 setTime2:(NSString *)setTime2 setTime3:(NSString *)setTime3 DaysArray:(NSArray *)daysArray{
    if ([daySet isEqualToString:@"      Weekly"] && daysArray.count==0) {
        self.viewApiPosterror.hidden=NO;
        self.lblMesage.text=@"Please select at least one day!";
        [self.view bringSubviewToFront:self.viewApiPosterror];
        return;
    }
    if ([numberOfTime intValue]==1) {
        setTime3=@"0";
        setTime2=@"0";
    }
    if ([numberOfTime intValue]==2) {
        if ([setTime1 isEqualToString:setTime2]) {
             setTime3=@"0";
            self.viewApiPosterror.hidden=NO;
            self.lblMesage.text=@"Time can not be same.";
            [self.view bringSubviewToFront:self.viewApiPosterror];
            return;
        }
    }
    if ([numberOfTime intValue]==3) {
        if ([setTime1 isEqualToString:setTime2] || [setTime2 isEqualToString:setTime3] || [setTime1 isEqualToString:setTime3]) {
            self.viewApiPosterror.hidden=NO;
            self.lblMesage.text=@"Time can not be same.";
            [self.view bringSubviewToFront:self.viewApiPosterror];
            return;
        }
    }
    if ([[dict valueForKey:@"sunday"]isEqualToString:@"1"] && [[dict valueForKey:@"monday"]isEqualToString:@"1"] && [[dict valueForKey:@"tuesday"]isEqualToString:@"1"] && [[dict valueForKey:@"wednesday"]isEqualToString:@"1"] && [[dict valueForKey:@"thursday"]isEqualToString:@"1"] && [[dict valueForKey:@"friday"]isEqualToString:@"1"] && [[dict valueForKey:@"saturday"]isEqualToString:@"1"] ) {
        reminder.viewsDaysBtns.hidden = YES;
        reminder.txtDays.text=@"      Daily";
        [reminder reloadData];
    }
    
    else if ([[dict valueForKey:@"sunday"]isEqualToString:@"1"] || [[dict valueForKey:@"monday"]isEqualToString:@"1"] || [[dict valueForKey:@"tuesday"]isEqualToString:@"1"] || [[dict valueForKey:@"wednesday"]isEqualToString:@"1"] || [[dict valueForKey:@"thursday"]isEqualToString:@"1"] || [[dict valueForKey:@"friday"]isEqualToString:@"1"] || [[dict valueForKey:@"saturday"]isEqualToString:@"1"] ) {
        reminder.viewsDaysBtns.hidden = NO;
        reminder.txtDays.text=@"      Weekly";
        [reminder reloadData];
    }
    else{
        reminder.txtDays.text=@"        Daily";
        reminder.viewsDaysBtns.hidden=YES;
        [reminder reloadData];
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
        [dict setObject:@"0"  forKey:@"Friday"];
    }
    if ([daysArray containsObject:@"Saturday"]) {
        [dict setObject:@"1"  forKey:@"saturday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"Saturday"];
    }
    if ([daysArray containsObject:@"Sunday"]) {
        [dict setObject:@"1"  forKey:@"sunday"];
    }
    else {
        [dict setObject:@"0"  forKey:@"Sunday"];
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
    if ([daySet isEqualToString:@"      Weekly"]) {
        [dict setObject:@"0" forKey:@"everyday"];
    }
    else {
        [dict setObject:@"1" forKey:@"everyday"];
    }
    reminder.hidden=YES;
    [self setReminder];
}

- (void)setReminder{
   
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"setWorkout_reminder/" apiKey:[Globals apiKey]];
    
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
                [reminder removeFromSuperview];
                //This for loop iterates through all the view controllers in navigation stack.
                for (UIViewController* viewController in self.navigationController.viewControllers) {
                    if ([viewController isKindOfClass:[workoutController class]] ) {
                        workoutController *groupViewController = (workoutController*)viewController;
                        [self.navigationController popToViewController:groupViewController animated:YES];
                    }
                }
                blurredView.hidden=YES;
                [hudFirst hide:YES];
            }
            else{
                blurredView.hidden=NO;
                _viewApiPosterror.hidden=NO;
                _lblMesage.text=@"oops! You just missed something.";
                [hudFirst hide:YES];
            }
        }
        else {
            blurredView.hidden=NO;
            _viewApiPosterror.hidden=NO;
            [reminder removeFromSuperview];
            _lblMesage.text=@"Internal server error. Please try again.";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        
    }];

    
}



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

//HITTING API TO GET WORKOIT EXERCISE
-(void)create {
    if (updatedExercise.count==0 && json2.count==0) {
        blurredView.hidden=NO;
        _viewApiPosterror.hidden=NO;
        [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
        _lblMesage.text = @"Please select atleast one exercise.";
        return;
    }
   
    // IMPLEMENTING API TO THE NEXT BUTTON
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:KurladdCustomWorkout apiKey:[Globals apiKey]];
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",_lblWorkOutName.text,@"workout_name",@"fdfjdfdfdfdd",@"media_url",@"34",@"media_type",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                blurredView.hidden=YES;
                [[SingletonClass singleton].clientDat setObject:[[json valueForKey:@"return_set"] valueForKey:@"workout_id"] forKey:@"workout_id"];
                [self apicalls];
                
            }
            else if ([[json objectForKey:@"status_code"] isEqual:@"E_DUPLICATE"]) {
                _viewDuplicate.hidden=NO;
                blurredView.hidden=NO;
                [_textWorkoutName becomeFirstResponder];
                _textWorkoutName.text=_lblWorkOutName.text;
//                [[_textBackground layer] setBorderColor:[[UIColor redColor]CGColor]];
//                [[_textBackground layer] setBorderWidth:1];
                [Globals showBounceAnimatedView:self.viewDuplicate completionBlock:nil];
                _lblMesage.text=@"This workout name already exists.Please enter a different name.";
                [hudFirst hide:YES];
                
            }
            [hudFirst hide:YES];
        }
        else {
            _viewApiPosterror.hidden=NO;
            blurredView
            .hidden=NO;
            [self.view endEditing:YES];
            [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
            _lblMesage.text=@"Sorry! Internal Server Error.";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _viewApiPosterror.hidden=NO;
        blurredView.hidden=NO;
        [self.view endEditing:YES];
        [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
        _lblMesage.text=@"Sorry! Internal Server Error.";
        [hudFirst hide:YES];
    }];

}

- (void)apicalls {
    if (updatedExercise.count==0 && json2.count==0) {
        blurredView.hidden=NO;
        _viewApiPosterror.hidden=NO;
        [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
        _lblMesage.text = @"Please select atleast one exercise.";
        return;
    }

    NSError *error = nil;
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *urlString;
    NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"customWorkoutController"] || json2.count==0 ) {
        urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"addCustomExercise/" apiKey:[Globals apiKey]];
    }
    else {
         urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"addExerciseToRecommendedWorkouts/" apiKey:[Globals apiKey]];
    }
    NSMutableArray *currentCheckArray =[[updatedExercise arrayByAddingObjectsFromArray:json2] mutableCopy];
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
    NSString * jsonString1=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:jsonString1,@"data",trainerID,@"trainer_id",clientID,@"client_id", [[SingletonClass singleton].clientDat objectForKey:@"workout_id"],@"workout_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {

                blurredView.hidden=NO;
                successView.hidden=NO;
                [Globals showBounceAnimatedView:self.successView completionBlock:nil];
                [hudFirst hide:YES];
            }
            else{
                blurredView.hidden=NO;
                _viewApiPosterror.hidden=NO;
                [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
                _lblMesage.text = @"Please select atleast one exercise.";
                [hudFirst hide:YES];
            }
        }
        else {
            blurredView.hidden=NO;
            _viewApiPosterror.hidden=NO;
            [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
            _lblMesage.text = @"Sorry! Internal Server Error.";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        blurredView.hidden=NO;
        _viewApiPosterror.hidden=NO;
        [Globals showBounceAnimatedView:self.viewApiPosterror completionBlock:nil];
        _lblMesage.text = @"Sorry! Internal Server Error.";
        [hudFirst hide:YES];
    }];
    
}


//HITTING API TO ADD CUSTOM BUNDEL
#pragma apli implimentation*************************************************************

- (void)workoutExercise {
    NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"customWorkoutController"]) {
        return;
    }
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    NSString *workoutID= [[SingletonClass singleton].clientDat objectForKey:@"workout_id"];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSDictionary *inputDic;
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"getExercises/" apiKey:[Globals apiKey]];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"workoutDietPlanLibraryController"]){
        if (json2.count != 0) {
            [hudFirst hide:YES];
            return;
        }
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:workoutID,@"workout_id",nil];
    }
    else if([NSStringFromClass([viewContrlls class]) isEqualToString: @"customWorkoutController"]){
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",workoutID,@"workout_id",nil];
    }
    else if([NSStringFromClass([viewContrlls class]) isEqualToString: @"customWorkoutController2"]){
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",workoutID,@"workout_id",nil];
    }
    else{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
            inputDic=[NSDictionary dictionaryWithObjectsAndKeys:workoutID,@"workout_id",nil];inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",workoutID,@"workout_id",nil];        }
        else {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientID,@"client_id",workoutID,@"workout_id",nil];
        }
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                json2 = [[json objectForKey:@"returnset"] mutableCopy];
                tableViews.hidden=NO;
                [tableViews reloadData];
                [hudFirst hide:YES];
                if (json2==nil || json2.count==0) {
                    _viewForNoData.hidden=NO;
                    tableViews.hidden=YES;
                }
                else {
                    _viewForNoData.hidden=YES;
                    tableViews.hidden=NO;
                }
            }
            else{
                [hudFirst hide:YES];
            }
        }
        else{
            [hudFirst hide:YES];
          _viewForNoData.hidden=NO;
            [Globals showBounceAnimatedView:self.viewForNoData completionBlock:nil];
          _lblError.text = @"Sorry! Internal Server Error.";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _viewForNoData.hidden=NO;
        [Globals showBounceAnimatedView:_viewForNoData completionBlock:nil];
        _lblError.text = @"Sorry! Internal Server Error.";
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
    _viewApiPosterror.hidden=YES;
    if ( _viewApiPosterror.hidden==YES) {
        blurredView.hidden=YES;
    }
    if (reminder.hidden==YES) {
        blurredView.hidden=YES;
    }
    if (reminder.hidden==NO && _viewApiPosterror.hidden==YES && reminder!=nil) {
        blurredView.hidden=NO;
    }
}

- (IBAction)sucessReminderBtn:(id)sender {
    successView.hidden=YES;
    blurredView.hidden=NO;
    reminder = [[ReminderView alloc]init];
    reminder.center = self.view.center;
    reminder.delegate=self;
    [self.view addSubview:reminder];
    [Globals showBounceAnimatedView:reminder completionBlock:nil];
}

-(void)ReminderVIewObject:(UIView *)View{
    View.center = self.view.center;
}

- (IBAction)finishBtn:(id)sender {
    [[SingletonClass singleton].selectedWorkout removeAllObjects];
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[workoutController class]] ) {
            workoutController *groupViewController = (workoutController*)viewController;
            [self.navigationController popToViewController:groupViewController animated:YES];
        }
    }
}
- (IBAction)okChangeName:(id)sender {
    if ([_textWorkoutName.text isEqualToString:@""]) {
        blurredView.hidden=NO;
        [[_textBackground layer] setBorderColor:[[UIColor redColor]CGColor]];
        [[_textBackground layer] setBorderWidth:1];
        return;
    }
    [[_textBackground layer] setBorderColor:[[UIColor clearColor]CGColor]];
    _viewDuplicate.hidden=YES;
    
    _lblWorkOutName.text=_textWorkoutName.text;
    [self.view endEditing:YES];
    [self create];
}
@end
