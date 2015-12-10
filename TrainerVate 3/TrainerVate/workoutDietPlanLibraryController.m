//
//  workoutDietPlanLibraryController.m
//  TrainerVate
//
//  Created by Pankaj Khatri on 15/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "workoutDietPlanLibraryController.h"
#import "Globals.h"
#import "clientWorkoutCustomCell.h"
#import "Constants.h"
#import "WorkoutName2.h"
@interface workoutDietPlanLibraryController () {
    
    NSMutableArray *MainDataArray;
    NSArray *temps;
    NSMutableArray *json2;
    int selectedUser;
    NSArray *json3;
    NSMutableArray *json4;
    BOOL search;
     UITableView *tableViews;
}
@end

@implementation workoutDietPlanLibraryController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if(IS_IPHONE_5_OR_MORE) {
//        
//        self = [super initWithNibName:@"workoutDietPlanLibraryController" bundle:nibBundleOrNil];
//    }
//    else {
//        self = [super initWithNibName:@"workoutDietPlanLibraryController_4" bundle:nibBundleOrNil];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Workout Diet Plan Library Controller"];
    if (IS_IPHONE_5_OR_MORE) {
        tableViews=[[UITableView alloc]initWithFrame:CGRectMake(0, 127, 320, 442)];
    }
    else {
        tableViews=[[UITableView alloc]initWithFrame:CGRectMake(0, 127, 320, 352)];
    }
    tableViews.delegate=self;
    tableViews.dataSource=self;
    [tableViews setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableViews];
    json4=[[NSMutableArray alloc]init];
    selectedUser=-1;
    MainDataArray = [NSMutableArray array];
    [self callDataFormServer];
    [_navigationBAr addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    search=NO;
    _errorView.hidden=YES;
}


-(void)callDataFormServer{
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    //NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *urlString = [Globals urlCombileHash:kApiDomin3 ClassUrl:KurlgetWorkoutWithCategory apiKey:[Globals apiKey]];
    NSDictionary *InputDic = [NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:InputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                temps=[[NSArray alloc]init];
                temps=[json valueForKey:@"workouts"];
                json3=[[NSArray alloc]init];
                json3=[temps valueForKey:@"myWorkout"];
                [self handelResponse];
                [tableViews reloadData];
                [hudFirst hide:YES];
            }
            else{
//                [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
//                _errorView.hidden=NO;
                _lblMessage.text =@"Sorry! No Workouts in the library.";
                [hudFirst hide:YES];
            }
        }
        else {
            _errorView.hidden=NO;
           _lblMessage.text=@"Sorry! Internal Server Error.";
            [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
            
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _errorView.hidden = NO;
        _lblMessage.text = @"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:_errorView completionBlock:nil];
        [hudFirst hide:YES];
        
    }];
}
-(void)handelResponse {
    
   // NSArray *workOutArray=[response objectForKey:@""]
    
    for (int i=0; i<temps.count; i++) {
        NSMutableDictionary *DataHandelDic = [NSMutableDictionary dictionary];
        NSDictionary *currentDic =[temps objectAtIndex:i];
        [DataHandelDic setObject:[currentDic objectForKey:@"Category_Name"]  forKey:@"Category_Name"];
        NSArray *currenTRecivedArray = [[currentDic objectForKey:@"myWorkout"]objectAtIndex:0];
        NSMutableArray *StoredArray=[NSMutableArray array];
        NSDictionary *currentDetailDic = [currenTRecivedArray mutableCopy];
        [StoredArray addObject:currentDetailDic];
        [DataHandelDic setObject:StoredArray forKey:@"cells"];
        [MainDataArray addObject: DataHandelDic];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // NSArray *sectionArr=[[MainDataArray objectAtIndex:section] objectForKey:@"cells"];
    if (section==selectedUser) {
        NSArray *sectionArray=[[temps objectAtIndex:section] valueForKey:@"myWorkout"];
        return sectionArray.count;
    }
    return 0;
 
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return MainDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
//clientWorkoutCustomCell
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
     if (section==selectedUser) {
         return 0.1;
     }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *defaultCell = @"default";
    clientWorkoutCustomCell *cell = (clientWorkoutCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *mArray = [[NSBundle mainBundle]loadNibNamed:@"clientWorkoutCustomCell" owner:self options:nil];
        cell = [mArray objectAtIndex:0];
        
    }
    
        NSArray *sectionArray=[[temps objectAtIndex:indexPath.section] valueForKey:@"myWorkout"];
        NSDictionary *sectionDic=[sectionArray objectAtIndex:indexPath.row];
        // NSString *value=
        if (![[sectionDic objectForKey:@"Flag"] isEqual:@"0"]) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.userInteractionEnabled = NO;
            UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,78)];
            [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
            [cell addSubview:views];
        }
        cell.nameLbl.text = [sectionDic objectForKey:@"workout_name"];;
        cell.descriptionLbl.text = [sectionDic objectForKey:@"media_url"];
        

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,2)];
    [view setBackgroundColor:[UIColor whiteColor]];
    return view;
}

// ADDING ANIMATION TO THE TABLE VIEW STARTS.

int drops=0;
-(void)userSelclected:(UIButton *)senderBtn
{
    if (selectedUser==(int)senderBtn.tag) {
        selectedUser=-1;
        drops=0;
        [tableViews reloadData];
        return;
    }
    if (drops==0 || selectedUser!= senderBtn.tag) {
        selectedUser=(int)senderBtn.tag;
        [UIView transitionWithView:tableViews duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [tableViews reloadData];
        } completion:nil];
        
        
        drops++;
    }
    else{
        [UIView transitionWithView:tableViews duration:0.25f options:UIViewAnimationOptionTransitionNone animations:^{
            [tableViews reloadData];
        } completion:nil];
        
        drops=0;
    }
    // [client reloadData];
    
}

// ANIMATION ENDS..



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    NSDictionary *currentDic=[MainDataArray objectAtIndex:section];
    
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 182, 27)];
    label.font=[UIFont fontWithName:@"Lato-Regular" size:15.0];
    label.text=[currentDic objectForKey:@"Category_Name"];
    [label setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(274, 17, 24,9)];
    [arrow setImage:[UIImage imageNamed:@"sign_arrow_down.png"]];
    arrow.backgroundColor = [UIColor clearColor];
    
    UIButton *senderBtnAction=[[UIButton alloc]initWithFrame:CGRectMake(0,0,320,44)];
    senderBtnAction.backgroundColor=[UIColor clearColor];
    
    senderBtnAction.tag=section;
    senderBtnAction.frame = CGRectMake(0, 0,views.frame.size.width, views.frame.size.height);
    [senderBtnAction addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    [views addSubview:label];
    [views addSubview:senderBtnAction];
        [views addSubview:arrow];
    [views setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]]; //your background color...
    return views;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     WorkoutName2 *nextClass = [[WorkoutName2 alloc]init];
    NSArray *tempArray = [[NSArray alloc]init];
//    if (search==YES) {
//        NSDictionary *sectionDic=[json4 objectAtIndex:indexPath.row];
//        [[SingletonClass singleton].clientDat setObject:[sectionDic objectForKey:@"workout_id"] forKey:@"workout_id"];
//        [[SingletonClass singleton].clientDat setObject:[sectionDic objectForKey:@"workout_name"] forKey:@"WorkoutName"];
//        nextClass.workoutName=[sectionDic objectForKey:@"workout_name"];
//        tempArray = [sectionDic mutableCopy];
//    }
//    else {
        NSArray *sectionArray=[[temps objectAtIndex:indexPath.section] valueForKey:@"myWorkout"];
        NSDictionary *sectionDic=[sectionArray objectAtIndex:indexPath.row];
       // NSDictionary *sectionDic=[[[MainDataArray objectAtIndex:indexPath.section] objectForKey:@"cells"]objectAtIndex:indexPath.row];
        [[SingletonClass singleton].clientDat setObject:[sectionDic objectForKey:@"workout_id"] forKey:@"workout_id"];
        [[SingletonClass singleton].clientDat setObject:[sectionDic objectForKey:@"workout_name"] forKey:@"WorkoutName"];
        nextClass.workoutName=[sectionDic objectForKey:@"workout_name"];
         tempArray = [MainDataArray valueForKey:@"cells"];
   // }
   
    [self.navigationController pushViewController:nextClass animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)apicalls {
    
    if ([txtSearchField.text isEqualToString:@""]) {
        return;
    }
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];

    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"SearchWorkoutLibrary/" apiKey:[Globals apiKey]];
    
    NSDictionary *inputdic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"uid",trainerID,@"trainer_id",txtSearchField.text,@"Workout_name",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputdic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
//                json4=[[NSMutableArray alloc]init];
//
//                json4=[json valueForKey:@"WorkOuts"];
//                [hudFirst hide:YES];
//                [tableViews reloadData];
                [MainDataArray removeAllObjects];
                selectedUser=-1;
                temps=[[NSArray alloc]init];
                temps=[json valueForKey:@"workouts"];
                tableViews.hidden=NO;
                _errorView.hidden=YES;
                json3=[[NSArray alloc]init];
                json3=[temps valueForKey:@"myWorkout"];
                [self handelResponse];
                [tableViews reloadData];
                [hudFirst hide:YES];
            }
            else{
                _errorView.hidden=NO;
                tableViews.hidden=YES;
                _lblMessage.text=@"No Workout Found!";
                [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
                [hudFirst hide:YES];
            }
        }
        else {
            _errorView.hidden=NO;
            tableViews.hidden=YES;
            _lblMessage.text=@"Sorry! Internal Server Error.";
            [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        _errorView.hidden=NO;
        tableViews.hidden=YES;
        _lblMessage.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        [hudFirst hide:YES];
    }];
    
}



- (IBAction)sendBtn:(UIButton *)sender {
    search = YES;
    [self.view endEditing:YES];
    [self apicalls];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
