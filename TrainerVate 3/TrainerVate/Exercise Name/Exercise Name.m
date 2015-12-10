//
//  Exercise Name.m
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "Exercise Name.h"
#import "Workout Name 2.h"
#import "AFNetworking.h"
#import "Search Exercise Controller.h"
#import "SearchExerciseControllerCustomCell.h"
#import "Workout Name.h"
#import "WorkoutNameCustomCell.h"

@interface Exercise_Name (){
    NSDictionary *mdict;
}

@end

@implementation Exercise_Name
@synthesize addbtn,removebtn,savebtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ALLOCATE DICTIONARY.
    mdict = [[NSDictionary alloc]init];
    
    
    
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

// CHANGING THE LAYOUT OF THIS PAGE WITH ACCORDANCE TO THE VIEW THIS PAGE IS CALLED.
-(void)viewWillAppear:(BOOL)animated{
    
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"Workout_Name_2"]){
        addbtn.hidden=YES;
        savebtn.hidden=NO;
        removebtn.hidden=NO;
    }
    else if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"Search Exercise Controller"]){
        addbtn.hidden=NO;
        savebtn.hidden=YES;
        removebtn.hidden=YES;

    }
    else if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"ResultController"]){
        addbtn.hidden=NO;
        savebtn.hidden=YES;
        removebtn.hidden=YES;
        
    }
    else {
        savebtn.hidden=YES;
        removebtn.hidden=YES;
        addbtn.hidden=NO;
    }
    
}

// ENDS..




- (IBAction)addbtn:(id)sender {
    
    
    
    // IMPLEMENTING APIS IN ACCORDANCE FROM VIEW THIS PAGE IS CALLED.
    
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    
    if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"ResultController"]){
        
        NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/addCustomExercise/abc266661b7732d92ffb8e264de00474/960b1c88c2cc38c2836ddb4872aea6ea";
        
        NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"956",@"trainer_id",@"media_url",@"media_url",@"media_type",@"media_type",@"detail",@"detail",@"instruction",@"instruction",@"exercise_time",@"exercise_time",@"weights",@"weights",@"speed",@"speed",@"reps",@"reps",@"tiktok",@"exercise_name",nil];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions error:&error];
            if (json !=nil && json.allKeys.count!=0) {
                
                if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                    
                }
                else{
                    
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
        }];

        
        Workout_Name_2 *tempf = [[Workout_Name_2 alloc]initWithNibName:@"Workout Name 2" bundle:nil];
        [self.navigationController pushViewController:tempf animated:YES];
    }
    
   else{
       
      // API CALLED FROM THE SEARCH EXERCISE CONTROLLER
       NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/addExerciseToRecommendedWorkouts/abc266661b7732d92ffb8e264de00474/960b1c88c2cc38c2836ddb4872aea6ea";
       
       NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"901",@"trainer_id",@"956",@"client_id",@"7:00AM",@"exercise_time",@"32",@"weights",@"21",@"speed",@"4",@"reps",@"testing",@"exercise_name",@"5",@"workout_id",nil];
       AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
       [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSError* error;
           NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:kNilOptions error:&error];
           if (json !=nil && json.allKeys.count!=0) {
               
               if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                   
               }
               else{
                   
               }
           }
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           
       }];
       
       Workout_Name *teml = [[Workout_Name alloc]initWithNibName:@"Workout Name" bundle:nil];
       
       // SAVING THE VALUES ENTERED IN THE TEXT FIELDS TO THE DICTIONARY OF THE NEXT VIEW THIS PAGE HAS CALLED.
       
       teml.ndict=mdict;
       [self.navigationController pushViewController:teml animated:YES];
   }

    
    
        
    

   }

- (IBAction)savebtn:(id)sender {
    
}
- (IBAction)removebtn:(id)sender {
    
}



- (IBAction)backbtn:(id)sender {
}

- (IBAction)menubtn:(id)sender {
}






@end
