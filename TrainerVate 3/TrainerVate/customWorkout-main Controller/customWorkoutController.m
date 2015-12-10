//
//  customWorkoutController.m
//  My Client- Workout
//
//  Created by Matrid on 31/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "customWorkoutController.h"
#import "ResultController.h"
#import "ResultControllerCustomCell.h"
#import "SingletonClass.h"
#import "AFNetworking.h"
@interface customWorkoutController ()

@end

@implementation customWorkoutController
@synthesize textField,textlabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
// CHANGING LAYOUT ACCORDING TO THE PREVIOUS PAGE CALLED..
    
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"customWorkoutController2"]){
        textlabel.hidden=YES;
    }
}

// ACTIONS FOR THE BUTTONS.

- (IBAction)nextbtn:(id)sender {
    
    
    // IMPLEMENTING API TO THE NEXT BUTTON
    
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate3/api/addCustomWorkout/abc266661b7732d92ffb8e264de00474/960b1c88c2cc38c2836ddb4872aea6ea";
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"901",@"trainer_id",@"Morn",@"workout_name",@"fdfjdfdfdfdd",@"media_url",@"34",@"media_type",nil];
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
    
    ResultController *tempg=[[ResultController alloc]initWithNibName:@"ResultController" bundle:nil];
    [self.navigationController pushViewController:tempg animated:YES];
    [[SingletonClass singleton].clientDat setObject:textField.text forKey:@"WorkoutBundleName"];
    

}
- (IBAction)searchbtn:(id)sender {
    ResultController *tempv = [[ResultController alloc]initWithNibName:@"ResultController" bundle:nil];
    [self.navigationController pushViewController:tempv animated:YES];
}
- (IBAction)backbtn:(id)sender {
}

- (IBAction)menubtn:(id)sender {
}
@end
