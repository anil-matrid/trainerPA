//
//  customWorkoutController2.m
//  My Client- Workout
//
//  Created by Matrid on 02/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "customWorkoutController2.h"
#import "customWorkoutController2CustomCell.h"
#import "WorkoutName2.h"
#import "customWorkoutController.h"
#import "Constants.h"

@interface customWorkoutController2 ()
{
    NSArray *name;
    NSArray *description;
    NSArray *image;
    NSArray *json2;
    NSDictionary *dict;
}


@end

@implementation customWorkoutController2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"MyClientController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"customWorkoutController2" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"CustomWorkoutController2_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Custom Workout Controller 2"];
    // Do any additional setup after loading the view from its nib.
    json2=[[NSArray alloc]init];
    name = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    description = [NSArray arrayWithObjects:@"lorem ipsim sit amet de consecteur dolor vich",@"lorem ipsim sit amet de consecteur dolor vich", nil];
    image = [ NSArray arrayWithObjects:@"benchpress.jpeg",@"workout.jpeg", nil];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    _errorView.hidden=YES;    
    [self callDataFromServer];
}

// TABLE VIEW STARTS.

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return json2.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCell = @"default";
    customWorkoutController2CustomCell *cell = (customWorkoutController2CustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *fArray = [[NSBundle mainBundle]loadNibNamed:@"customWorkoutController2CustomCell" owner:self options:nil];
        cell = [fArray objectAtIndex:0];
    }
    if (![[[json2 objectAtIndex:indexPath.row ] valueForKey:@"Flag"] isEqual:@"0"]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        
        UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,97)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
        [cell addSubview:views];
    }
    if (json2.count!=0) {
        
        [cell bringSubviewToFront:cell.cellFooter];
    cell.namelbl.text=[[json2 objectAtIndex:indexPath.row]valueForKey:@"workout_name"];
   // cell.descriptionlbl.text=[description objectAtIndex:indexPath.row];
//cell.imageimg.image=[UIImage imageNamed:[image objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[SingletonClass singleton].clientDat setObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_id"] forKey:@"workout_id"];
    WorkoutName2 *tem = [[WorkoutName2 alloc]initWithNibName:@"WorkoutName2" bundle:nil];
    tem.workoutName = [[json2 objectAtIndex:indexPath.row] valueForKey:@"workout_name"];
    [self.navigationController pushViewController:tem animated:YES];
}

// TABLE VIEW ENDS..

- (IBAction)createbtn:(id)sender {
    customWorkoutController *tempb = [[customWorkoutController alloc]initWithNibName:@"customWorkoutController" bundle:nil];
    [self.navigationController pushViewController:tempb animated:YES];
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// API IMPLEMENTATION..

-(void)callDataFromServer{
    
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/getCustomWorkout/abc266661b7732d92ffb8e264de00474/960b1c88c2cc38c2836ddb4872aea6ea";
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];

    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientID,@"client_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                json2 = [json objectForKey:@"return_set"];
                [hudFirst hide:YES];
                _errorView.hidden=YES;
                [_tableVIew reloadData];
            }
            else{
                [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
            
                _errorView.hidden=NO;
                _lblmsg.text=@"No Workouts yet!";
                [hudFirst hide:YES];
            }
        }
        else {
            _errorView.hidden=NO;
            _lblmsg.text=@"Sorry! Internal Server Error.";
            [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _errorView.hidden=NO;
        _lblmsg.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        [hudFirst hide:YES];
        
    }];

}

@end
