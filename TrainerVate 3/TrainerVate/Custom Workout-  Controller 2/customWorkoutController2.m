//
//  customWorkoutController2.m
//  My Client- Workout
//
//  Created by Matrid on 02/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "customWorkoutController2.h"
#import "customWorkoutController2CustomCell.h"
#import "Workout Name.h"
#import "customWorkoutController.h"
#import "AFNetworking.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    json2=[[NSArray alloc]init];
    name = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    description = [NSArray arrayWithObjects:@"lorem ipsim sit amet de consecteur dolor vich",@"lorem ipsim sit amet de consecteur dolor vich", nil];
    image = [ NSArray arrayWithObjects:@"benchpress.jpeg",@"workout.jpeg", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
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
    if (json2.count!=0) {
        
    
    cell.namelbl.text=[[json2 objectAtIndex:indexPath.row]valueForKey:@"workout_name"];
   // cell.descriptionlbl.text=[description objectAtIndex:indexPath.row];
//cell.imageimg.image=[UIImage imageNamed:[image objectAtIndex:indexPath.row]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Workout_Name *tem = [[Workout_Name alloc]initWithNibName:@"Workout Name" bundle:nil];
    [self.navigationController pushViewController:tem animated:YES];
}

// TABLE VIEW ENDS..

- (IBAction)createbtn:(id)sender {
    customWorkoutController *tempb = [[customWorkoutController alloc]initWithNibName:@"customWorkoutController" bundle:nil];
    [self.navigationController pushViewController:tempb animated:YES];
}

// API IMPLEMENTATION..

-(void)callDataFromServer{
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/getCustomWorkout/abc266661b7732d92ffb8e264de00474/960b1c88c2cc38c2836ddb4872aea6ea";
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"991",@"trainer_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                json2 = [json objectForKey:@"return_set"];
               
                [_tableVIew reloadData];
            }
            else{
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];

}

@end
