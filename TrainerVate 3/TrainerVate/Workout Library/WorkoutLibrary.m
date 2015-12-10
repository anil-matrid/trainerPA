//
//  WorkoutLibrary.m
//  My Client- Workout
//
//  Created by Matrid on 26/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "WorkoutLibrary.h"
#import "WorkoutLibraryCustomCell.h"
#import "Workout Name 2.h"
#import "AFNetworking.h"
#import "WorkoutName2CustomCell.h"

@interface WorkoutLibrary ()
{
    int  selectedUser;
    NSArray *images1;
    NSArray *images2;
    NSArray *images3;
    NSArray *images4;
    NSArray *images5;
    NSArray *name1;
    NSArray *name2;
    NSArray *name3;
    NSArray *name4;
    NSArray *name5;
    NSArray *description1;
    NSArray *description2;
    NSArray *description3;
    NSArray *description4;
    NSArray *description5;
    NSArray *header;
    NSArray *json2;
    NSMutableArray *mybundle;
    NSMutableArray *productInfo;
    int count;
    NSArray *json3;
    
}

@end

@implementation WorkoutLibrary
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    selectedUser=-1;
    
    // ARRAYS.
    images1 = [NSArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg", nil];
    images2 = [NSArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg", nil];
    images3 = [NSArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg", nil];
    images4 = [NSArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg", nil];
    images5 = [NSArray arrayWithObjects:@"workout.jpeg",@"benchpress.jpeg", nil];
    name1 = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    name2 = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    name3 = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    name4 = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    name5 = [NSArray arrayWithObjects:@"Workout Name",@"Workout Name", nil];
    description1 = [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", nil];
    description2 = [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", nil];
    description3 = [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", nil];
    description4 = [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", nil];
    description5 = [NSArray arrayWithObjects:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit.",@"Lorem ipsum dolor sit amet, consectetur adipiscing elit. ", nil];
    header =[NSArray arrayWithObjects:@"Abs",@"Arms Toning",@"Core Strength",@"Fat Loss",@"Muscle Building", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//CALLING IMPLEMENTED API.

-(void)viewWillAppear:(BOOL)animated{
    [self callDataFormServer];
}

//TABLE VIEW DELEGATE METHODS STARTS.
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return header.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rowArray=[[json3 objectAtIndex:section]valueForKey:@"workout_name"];
    return rowArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 101;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCell=@"cell";
    WorkoutLibraryCustomCell *cell =[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *mArray =[[NSBundle mainBundle]loadNibNamed:@"WorkoutLibraryCustomCell" owner:self options:nil];
        cell = [mArray objectAtIndex:0];
    }
  
       // cell.imageimg.image=[UIImage imageNamed:[images1 objectAtIndex:indexPath.row]];
        cell.namelbl.text=[[[json3 objectAtIndex:indexPath.section]objectAtIndex: indexPath.row] valueForKey:@"workout_name"];
      //  cell.descriptionlbl.text=[description1 objectAtIndex:indexPath.row];
  
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Workout_Name_2 *temp = [[Workout_Name_2 alloc]initWithNibName:@"Workout Name 2" bundle:nil];
    [self.navigationController pushViewController:temp animated:YES];
    
    
}

// TABLE VIEW DELEGATE METHODS ENDS.


// ADDING HEADER TO THE TABLE VIEW.
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 182, 27)];
    [label setFont:[UIFont boldSystemFontOfSize:17]];
    label.text=[header objectAtIndex:section];
    UIButton *senderBtnAction=[[UIButton alloc]initWithFrame:CGRectMake(0,0,320,44)];
    senderBtnAction.backgroundColor=[UIColor clearColor];
    
    senderBtnAction.tag=section;
    senderBtnAction.frame = CGRectMake(0, 0,views.frame.size.width, views.frame.size.height);
    [senderBtnAction addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    [views addSubview:label];
    [views addSubview:senderBtnAction];
    [views setBackgroundColor:[UIColor whiteColor]];
    return views;

}
// HEADER ENDS..



//BUTTONS ACTIONS..

- (IBAction)searchbtn:(id)sender {
}

- (IBAction)backbtn:(id)sender {
}

- (IBAction)menubtn:(id)sender {
}




// ADDING ANIMATION TO THE TABLE VIEW STARTS.

int Drop=0;
-(void)userSelclected:(UIButton *)senderBtn
{
    if (selectedUser==(int)senderBtn.tag) {
        selectedUser=-1;
        Drop=0;
        [tableView reloadData];
        return;
    }
    if (Drop==0 || selectedUser!= senderBtn.tag) {
        selectedUser=(int)senderBtn.tag;
        [UIView transitionWithView:tableView duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [tableView reloadData];
        } completion:nil];
        
        
               Drop++;
    }
    else{
        [UIView transitionWithView:tableView duration:0.25f options:UIViewAnimationOptionTransitionNone animations:^{
            [tableView reloadData];
        } completion:nil];
        
        Drop=0;
    }
    // [client reloadData];
    
}

// ANIMATION ENDS..


// HITTING API.
-(void)callDataFormServer
{
    
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/getWorkoutWithCategory/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"901",@"trainer_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            json3=[[NSArray alloc]init];
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                NSArray *farray = [json objectForKey:@"workouts"];
                NSDictionary *dic=[farray  objectAtIndex:0];
                NSArray *farrayNext = [dic objectForKey:@"myWorkout"];
                NSDictionary *dicNext=[farrayNext  objectAtIndex:0];
                //[self loadProductToProducts:[json objectForKey:@"workouts"]];
                json3 = [json objectForKey:@"workouts"];
                [tableView reloadData];
            }
            else{
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
    
}


-(void)loadProductToProducts:(NSArray *)response {
    int tempCount=0;
    json2 = [[NSArray alloc]init];
  //  NSMutableArray *imageArr=[NSMutableArray array];
    
//    arrayRespose=[response mutableCopy];
    
    for (int i=0; i<[[response valueForKey:@"mybundle"] count];i++ ) {
        tempCount=0;
        mybundle=[[NSMutableArray alloc]init];
        NSArray *currentDic=[[response objectAtIndex:i]valueForKey:@"myWorkout"];
        for (int j=0; j<[currentDic count]; j++) {
            NSMutableDictionary *tempArray=[[NSMutableDictionary alloc]init];
            [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"workout_name"] forKey:@"workout_name"];
            [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"category_id"] forKey:@"category_id"];
            [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"media_type"] forKey:@"media_type"];
            [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"trainer_id"] forKey:@"trainer_id"];
          
            
            //[imageArr addObject:product.image];
            [mybundle addObject:tempArray];
        }
        [productInfo addObject:mybundle];
    }
    count=(int)productInfo.count;
    
 //   [Globals saveUserImagesIntoCache:imageArr];
    [tableView reloadData];
}

@end
