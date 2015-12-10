//
//  Search Exercise Controller.m
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SearchExerciseController.h"
#import "ResultControllerCustomCell.h"
#import "ExerciseName.h"
#import "Constants.h"

@interface SearchExerciseController ()
{
    NSMutableArray *weights;
    NSMutableArray *speed;
    NSMutableArray *reps;
    NSMutableArray *exerciseName;
    NSMutableArray *images;

    NSArray *json2;
}

@end

@implementation SearchExerciseController

@synthesize tableViews,label,resultTextFIeld;

int countss = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Search Exercise Controller"];
    // Do any additional setup after loading the view from its nib.
    _errorView.hidden=YES;
    tableViews.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    // ADDING OBECTS TO ARRAYS..
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    
    // CHANGING LAYOUT ACCORDING TO THE PREVIOUS PAGE CALLED..
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self apicalls];

}


// TABLE VIEW DELEGATE METHODS STARTS.

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
    cell.namelbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"exercise_name"];
    cell.weightlbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"weights"];
    cell.speedlbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"speed"];
    cell.repslbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"reps"];
    cell.lblTime.text = [[json2 objectAtIndex:indexPath.row] valueForKey:@"exercise_time"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [SingletonClass singleton].selectedWorkout=[[json2 objectAtIndex:indexPath.row ]mutableCopy];
    ExerciseName *tempv=[[ExerciseName alloc]initWithNibName:@"ExerciseName" bundle:nil];
    [self.navigationController pushViewController:tempv animated:YES];
}

//TABLE VIEW METHODS ENDS..


// ADDING API TO THE SEARCH BUTTON..

- (void)apicalls {
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSDictionary *inputDic;
    
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/searchExercise/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
    if (countss == 0) {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"",@"exercise",nil];
    }
    else {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:resultTextFIeld.text,@"exercise",nil];
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
                countss = 1;
                [tableViews reloadData];
                
            }
            else{
                _errorView.hidden=NO;
                [Globals showBounceAnimatedView:self.errorView completionBlock:nil];

                [hudFirst hide:YES];
            }
        }
        else {
            [Globals alert:@"somthing went wrong"];
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
}



//API ENDS.


- (IBAction)searchbtn:(id)sender {
    
    
    //IMPLEMENTING API ON THE SEARCH BUTTON.
    [self.view endEditing:YES];
    [self apicalls];
}
- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menubtn:(id)sender {
}
          
 @end
