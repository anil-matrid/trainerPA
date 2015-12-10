//
//  ViewController.m
//  My Client- Workout
//
//  Created by Matrid on 21/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "workoutController.h"
#import "clientWorkoutCustomCell.h"
#import "WorkoutName.h"
#import "WorkoutName2.h"
#import "workoutDietPlanLibraryController.h"
//#import "WorkoutLibraryCustomCell.h"
#import "customWorkoutController.h"
#import "AFNetworking.h"
#import "customWorkoutController2.h"
#import "Constants.h"

@interface workoutController ()
{
    
    NSMutableArray *days;
    NSMutableArray *json2;
    NSMutableArray *selectedData;
    NSMutableArray *weekDays;
    BOOL LongPressFlag;
    int selectedUser;
    int selectedFlag;
    MBProgressHUD *  hudFirst ;
    NSInteger indexPaths;
    UITableView *tableViews;
}

@end

@implementation workoutController
@synthesize blurredView,custombtn,librarybtn,crossbtn,messagebox,headerName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"workoutController" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"workoutController_4" bundle:nibBundleOrNil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Workout Controller"];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
        _headerLabel.text=@"Workouts";
    }
    
    if (IS_IPHONE_5_OR_MORE) {
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"1"]){
            tableViews=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, 320, 426)];
        }
        else{
            tableViews=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, 320, 426+52)];
        }
    }
    else {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"1"]){
            tableViews=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, 320, 338)];
        }
        else{
            tableViews=[[UITableView alloc]initWithFrame:CGRectMake(0, 88, 320, 338+52)];
        }
    }
    tableViews.delegate=self;
    tableViews.dataSource=self;
    [tableViews setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableViews];
    [self.view sendSubviewToBack:tableViews];
    
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst hide:YES];

    _btnYes.layer.cornerRadius=_btnYes.bounds.size.height/2;
    _btnNo.layer.cornerRadius=_btnNo.bounds.size.height/2;
    selectedData=[[NSMutableArray alloc]init];
    //HIDING TEMPERAREY VIEWS
    
    blurredView.hidden=YES;
    _errorView.hidden=YES;
    _errorView1.hidden=YES;
    messagebox.hidden=YES;
    weekDays=[NSMutableArray arrayWithObjects:@"M",@"TU",@"W",@"TH",@"F",@"SA",@"SU",nil];
    custombtn.layer.cornerRadius=custombtn.frame.size.height/2;
    librarybtn.layer.cornerRadius=librarybtn.frame.size.height/2;
    
    //SETTING CLIENT FIRST NAME
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"1"]) {
        NSArray *comps = [headerName componentsSeparatedByString:@" "];
        NSString * firstNAme = [comps objectAtIndex:0];
        NSUInteger length = [firstNAme length];
        if (length>10) {
            _headerLabel.text=[NSString stringWithFormat:@"%@%@%@",[firstNAme substringToIndex:9],@"...'s",@" Workout"] ;
        }
        else {
            _headerLabel.text=[NSString stringWithFormat:@"%@%@%@",firstNAme,@"'s",@" Workout"] ;
        }
    }
   
    
    
    
    [_menuBtn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}
    // Do any additional setup after loading the view from its nib.

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// calling API
-(void)viewWillAppear:(BOOL)animated{
    
    selectedFlag=0;
    selectedUser=0;
    LongPressFlag=NO;
    [self callDataFormServer];
    messagebox.hidden=YES;
    blurredView.hidden=YES;
    _confirmationView.hidden=YES;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
        _addBtn.hidden=YES;
//        [tableViews setFrame:CGRectMake(0, 88, 318, 482)];
    }
}


-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (selectedData.count==0) {
        [_addBtn setTitle:@"Remove Workouts" forState:normal];
        CGPoint p = [gestureRecognizer locationInView:tableViews];
        NSIndexPath *indexPath = [tableViews indexPathForRowAtPoint:p];
        [selectedData addObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"]];
        LongPressFlag=YES;
        [tableViews reloadData];
    }
}

//table view starts
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return json2.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexPaths=[[NSNumber numberWithInteger:indexPath.row]integerValue];
    
    if (LongPressFlag==YES) {
        
        if ([selectedData containsObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"]]) {
            NSUInteger value=[selectedData indexOfObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"]];
            [selectedData removeObjectAtIndex:value];
            if(selectedData.count==0)
            {
                LongPressFlag=NO;
                [_addBtn setTitle:@"Add Workout" forState:normal];
                [self.view setNeedsDisplay];
            }
        }
        else {
            [selectedData addObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"]];
        }
        [tableViews reloadData];
    }
    else {
        [[SingletonClass singleton].clientDat setObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"]forKey:@"workout_id"];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
            WorkoutName2 *tempVC =[[WorkoutName2 alloc] init];
            tempVC.exeName=[[json2 objectAtIndex:indexPath.row]valueForKey:@"workout_name"];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
        else {
            [SingletonClass singleton].Workout=@"1";
            WorkoutName *tempVC =[[WorkoutName alloc]
                           initWithNibName:@"WorkoutName" bundle:nil];
            tempVC.DicCurrentDic = [[json2 objectAtIndex:indexPath.row] mutableCopy];
            tempVC.workoutName = [[json2 objectAtIndex:indexPath.row]valueForKey:@"workout_name"];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    indexPaths=[[NSNumber numberWithInteger:indexPath.row]integerValue];
    return indexPath;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCell = @"default";
    clientWorkoutCustomCell *cell = (clientWorkoutCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *fArray = [[NSBundle mainBundle]loadNibNamed:@"clientWorkoutCustomCell" owner:self options:nil];
        cell = [fArray objectAtIndex:0];
    }
    
    cell.tick.backgroundColor=[UIColor clearColor];
    if (LongPressFlag) {
        if ([selectedData containsObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"]]) {
            cell.tick.image=[UIImage imageNamed:@"tick.png"];
            // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else
        {
            cell.tick.image=nil;
        }
    }
    [cell.backLbl setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    cell.nameLbl.text=[[json2 objectAtIndex:indexPath.row]valueForKey:@"workout_name"];
   //cell.descriptionLbl.text=[description objectAtIndex:indexPath.row];
   //cell.imageView1.image=[UIImage imageNamed:[image objectAtIndex:indexPath.row]];
    int xAxis=113;
    NSArray *temp=[days objectAtIndex:indexPath.row];
    for (int i=0; i<temp.count; i++) {
        if ([[temp objectAtIndex:i] isEqualToString:@"1"]) {
            UILabel *labelCus=[[UILabel alloc]initWithFrame:CGRectMake(xAxis, 50, 16, 16)];
            labelCus.text=[weekDays objectAtIndex:i];
            labelCus.textColor=[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            labelCus.textAlignment=NSTextAlignmentCenter;
            labelCus.backgroundColor=[UIColor whiteColor];
            [labelCus setFont:[UIFont fontWithName:@"Lato-Bold" size:10]];
            labelCus.layer.borderColor = [UIColor blackColor].CGColor;
            labelCus.backgroundColor=[UIColor whiteColor];
            labelCus.layer.cornerRadius=labelCus.frame.size.width/2.0;
            labelCus.layer.cornerRadius=labelCus.frame.size.height/2.0;
            labelCus.clipsToBounds=YES;
            UIImageView *images=[[UIImageView alloc]initWithFrame:CGRectMake(xAxis-0.5, 50, 18, 18)];
            images.image=[UIImage imageNamed:@"circle.png"];
            [cell  addSubview:labelCus];
            [cell  addSubview:images];
            xAxis=xAxis+23;
        }
    }
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.75; //seconds
    lpgr.delegate = self;
    [cell addGestureRecognizer:lpgr];
    return cell;
}


//table view ends..

- (IBAction)addBtn:(id)sender {
    if (LongPressFlag==YES) {
        _confirmationView.hidden=NO;
        blurredView.hidden=NO;
       
        return;
    }
    [SingletonClass singleton].Workout=@"0";
    blurredView.hidden=NO;
    messagebox.hidden=NO;
    [Globals showBounceAnimatedView:messagebox completionBlock:nil];

}
- (IBAction)librarybtn:(id)sender {
    workoutDietPlanLibraryController *temp =[[workoutDietPlanLibraryController alloc]init];
    [self.navigationController pushViewController:temp animated:YES];
}
- (IBAction)custombtn:(id)sender {
    customWorkoutController2 *tempvc =[[customWorkoutController2 alloc]init];
    [self.navigationController pushViewController:tempvc animated:YES];
}

- (IBAction)crossbtn:(id)sender {
    blurredView.hidden=YES;
    messagebox.hidden=YES;
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// api implementation
-(void)callDataFormServer
{
    BOOL flag=NO;
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    if (LongPressFlag==YES || selectedFlag==0) {
        [hudFirst show:YES];
    }
    
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic;
    NSString *urlString;
    if (LongPressFlag==YES) {
        urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"DeleteWorkOuts/" apiKey:[Globals apiKey]];
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:selectedData options:0 error:&err];
        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString* ids = [myString stringByReplacingOccurrencesOfString:@"\""
                                                            withString:@""];
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",ids,@"ids",nil];
    }
    else {
        
        urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"getRecommendedWorkouts/" apiKey:[Globals apiKey]];
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",nil];
        selectedFlag=1;
         flag=YES;
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        [hudFirst hide:YES];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"message"]isEqualToString:@"Data Deleted!."]) {
                _errorView.hidden=YES;
                tableViews.hidden=NO;
                [_addBtn setTitle:@"Add Workout" forState:normal];
                LongPressFlag=NO;
                selectedUser=0;
                [selectedData removeAllObjects];
                [self callDataFormServer];
            }
            else {
                json2=[[NSMutableArray alloc]init];
                if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                    json2=[[json objectForKey:@"returnset" ]mutableCopy];
                    indexPaths=json2.count+1;
                    _errorView.hidden=YES;
                    [self daysOptions];
                    tableViews.hidden=NO;
                    [tableViews reloadData];
                }
                else{
                    [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
                   
                    if (flag==YES) {
                        _errorView.hidden=NO;
                        tableViews.hidden=YES;
                        _lblmsg.text=@"No Workouts yet!";
                    }
                    else {
                        _errorView1.hidden=NO;
                        blurredView.hidden=NO;
                        _errorLbl.text=@"No Workouts yet!";
                    }
                    [tableViews reloadData];
                    
                }
            }
        }
        else {
            [tableViews reloadData];
            if (flag==YES) {
                _errorView.hidden=NO;
                tableViews.hidden=YES;
                _lblmsg.text=@"Sorry! Internal Server Error.";
            }
            else {
                _errorView1.hidden=NO;
                blurredView.hidden=NO;
                _errorLbl.text=@"Sorry! Internal Server Error.";
            }
            [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [tableViews reloadData];
        if (flag==YES) {
            _errorView.hidden=NO;
            tableViews.hidden=YES;
            _lblmsg.text=@"Sorry! Internal Server Error.";
        }
        else {
            _errorView1.hidden=NO;
            blurredView.hidden=NO;
            _errorLbl.text=@"Sorry! Internal Server Error.";
        }

        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
       
    }];
    
    
}

-(void)daysOptions{
    days=[[NSMutableArray alloc]init];
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    NSMutableArray *temp1=[[NSMutableArray alloc]init];
    for (int i=0;i<json2.count;i++) {
        temp1=[json2 objectAtIndex:i];
        [temp removeAllObjects];
        if ([temp1 valueForKey:@"monday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"monday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"tuesday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"tuesday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"wednesday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"wednesday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"thursday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"thursday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"friday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"friday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"saturday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"saturday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"sunday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"sunday"]];
        }
        else {
            [temp addObject:@"0"];
        }
       
        for(int i = 0; i < temp.count; i++){
            if([temp[i] isKindOfClass:[NSNull class]]){
                temp[i] = @"0";
            }
        }
        [days addObject:[temp mutableCopy]];
        
    }
    
   
}


- (IBAction)btnYes:(id)sender {
    _confirmationView.hidden=YES;
    blurredView.hidden=YES;
    [_addBtn setTitle:@"Remove Workouts" forState:normal];
     [self callDataFormServer];
}

- (IBAction)btnNo:(id)sender {
    _confirmationView.hidden=YES;
    blurredView.hidden=YES;
}
- (IBAction)ok:(id)sender {
    _errorView1.hidden=YES;
    blurredView.hidden=YES;
}
@end
