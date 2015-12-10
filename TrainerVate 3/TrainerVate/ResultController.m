//
//  ResultController.m
//  My Client- Workout
//
//  Created by Matrid on 01/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ResultController.h"
#import "ResultControllerCustomCell.h"
#import "ExerciseName.h"
#import "SingletonClass.h"
#import "customWorkoutController.h"
#import "customWorkoutController2.h"
#import "Constants.h"


@interface ResultController ()
{
    NSMutableArray *weights;
    NSMutableArray *speed;
    NSMutableArray *reps;
    NSMutableArray *exerciseName;
    NSMutableArray *images;
    NSArray *json2;
    
}


@end

@implementation ResultController
@synthesize tableViews,resultTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"MyClientController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"ResultController" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"ResultController_4" bundle:nibBundleOrNil];
    }
    return self;
}

int counts = 0;
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Result Controller"];
    _errorView.hidden=YES;
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self apicalls];
    // CHANGING LAYOUT ACCORDING TO THE PREVIOUS PAGE CALLED..

   
}

-(void)viewWillDisappear:(BOOL)animated{
  //  [SingletonClass singleton].existWorkouts=nil;
    
}

//TABLE VIEW METHOD STARTS.

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
    if ([[[SingletonClass singleton].existWorkouts valueForKey:@"workout_exc_id"] containsObject:[[json2 objectAtIndex:indexPath.row]valueForKey:@"workout_exc_id"]]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.userInteractionEnabled = NO;
        UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,104)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
        [cell addSubview:views];
    }
  
    
    cell.namelbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"exercise_name"];
    cell.weightlbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"weights"];
    cell.speedlbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"speed"];
    cell.repslbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"reps"];
    cell.lblTime.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"exercise_time"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SingletonClass singleton].selectedWorkout=[[json2 objectAtIndex:indexPath.row ]mutableCopy];
    ExerciseName *templ=[[ExerciseName alloc]initWithNibName:@"ExerciseName" bundle:nil];
    [self.navigationController pushViewController:templ animated:YES];
}

//TABLE VIEW METHOD ENDS..

//API STARTS

- (void)apicalls {
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSDictionary *inputDic;
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:@"searchExercise/" apiKey:[Globals apiKey]];
    if (counts == 0) {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"exercise",nil];
    }
    else {
     inputDic=[NSDictionary dictionaryWithObjectsAndKeys:resultTextField.text,@"exercise",nil];
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            json2=[[NSArray alloc]init];
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                json2=[json objectForKey:@"returnset"];
                [hudFirst hide:YES];
                counts = 1;
                _errorView.hidden=YES;
                [tableViews reloadData];
                
            }
            else{
                _errorView.hidden=NO;
                _lblMessage.text=@"No Result found.";
                [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
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
        
        _errorView.hidden=NO;
        _lblMessage.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        [hudFirst hide:YES];
    }];

}



//API ENDS.

- (IBAction)backbtn:(id)sender {
    //[SingletonClass singleton].selectedWorkout=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menubtn:(id)sender {
}


- (IBAction)resultSearch:(id)sender {
    //IMPLEMENTING API ON THE SEARCH BUTTON.
    [self.view endEditing:YES];
    [self apicalls];
    
}

@end
