//
//  Search Exercise Controller.m
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "Search Exercise Controller.h"
#import "SearchExerciseControllerCustomCell.h"
#import "Exercise Name.h"
#import "AFNetworking.h"

@interface Search_Exercise_Controller ()
{
    NSMutableArray *weights;
    NSMutableArray *speed;
    NSMutableArray *reps;
    NSMutableArray *exerciseName;
    NSMutableArray *images;
    NSArray *json2;
}

@end

@implementation Search_Exercise_Controller

@synthesize tableView,label;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tableView.hidden=YES;
    
    // ADDING OBECTS TO ARRAYS..
    
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
    SearchExerciseControllerCustomCell *cell = (SearchExerciseControllerCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *mArray = [[NSBundle mainBundle]loadNibNamed:@"SearchExerciseControllerCustomCell" owner:self options:nil];
        cell = [mArray objectAtIndex:0];
        
    }
    cell.namelbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"exercise_name"];
    cell.weightlbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"weights"];
    cell.speedlbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"speed"];
    cell.repslbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"reps"];
    cell.picsimg.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Exercise_Name *tempv=[[Exercise_Name alloc]initWithNibName:@"Exercise Name" bundle:nil];
    [self.navigationController pushViewController:tempv animated:YES];
}

//TABLE VIEW METHODS ENDS..


// ADDING API TO THE SEARCH BUTTON..

- (IBAction)searchbtn:(id)sender {
    
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
    tableView.hidden=NO;
    label.text=@"Results";
    }

// API ENDS.

- (IBAction)backbtn:(id)sender {
}

- (IBAction)menubtn:(id)sender {
}
          
 @end
