//
//  ResultController.m
//  My Client- Workout
//
//  Created by Matrid on 01/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ResultController.h"
#import "ResultControllerCustomCell.h"
#import "Exercise Name.h"
#import "SingletonClass.h"
#import "customWorkoutController.h"
#import "customWorkoutController2.h"
#import "AFNetworking.h"

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
@synthesize textlbl,textfield,headinglbl,searchbtn,tableView,line,resultSearch,resultTextField,addbtn,bglbl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    bglbl.hidden=YES;
    addbtn.hidden=YES;
    resultSearch.hidden=YES;
    resultTextField.hidden=YES;
    tableView.hidden=YES;
    weights = [NSMutableArray arrayWithObjects:@"5 kg",@"10 kg",@"15 kg", nil];
    speed = [NSMutableArray arrayWithObjects:@"Easy",@"Medium",@"Hard", nil];
    reps = [NSMutableArray arrayWithObjects:@"1",@"2",@"10", nil];
    exerciseName = [NSMutableArray arrayWithObjects:@"Exercise Name",@"Exercise Name",@"Exercise Name", nil];
    images = [NSMutableArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg",@"workout.jpeg", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    // CHANGING LAYOUT ACCORDING TO THE PREVIOUS PAGE CALLED..

    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"customWorkoutController"]){
        headinglbl.text=[[SingletonClass singleton].clientDat objectForKey:@"WorkoutBundleName"];
    }
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
    cell.namelbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"exercise_name"];
    cell.weightlbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"weights"];
    cell.speedlbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"speed"];
    cell.repslbl.text = [[json2 objectAtIndex:indexPath.row ] valueForKey:@"reps"];
    cell.picsimg.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Exercise_Name *templ=[[Exercise_Name alloc]initWithNibName:@"Exercise Name" bundle:nil];
    [self.navigationController pushViewController:templ animated:YES];
}

//TABLE VIEW METHOD ENDS..


- (IBAction)searchbtn:(id)sender {
    
//IMPLEMENTING API ON THE SEARCH BUTTON.
    
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/searchExercise/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"901",@"trainer_id",@"t",@"exercise",nil];
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
                
                [tableView reloadData];
                
            }
            else{
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

    searchbtn.hidden=YES;
    line.hidden=YES;
    textfield.hidden=YES;
    textlbl.hidden=YES;
    tableView.hidden=NO;
    headinglbl.text=@"Results";
    resultTextField.hidden=NO;
    resultSearch.hidden=NO;
    addbtn.hidden=NO;
    bglbl.hidden=NO;
}

//API ENDS.

- (IBAction)backbtn:(id)sender {
}

- (IBAction)menubtn:(id)sender {
}

- (IBAction)textfield:(id)sender {
    
}
- (IBAction)resultTextField:(id)sender {
}
- (IBAction)resultSearch:(id)sender {
}

- (IBAction)addbtn:(id)sender {
    customWorkoutController2 *tempv=[[customWorkoutController2 alloc]initWithNibName:@"customWorkoutController2" bundle:nil];
    [self.navigationController pushViewController:tempv animated:YES];
}

@end
