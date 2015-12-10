//
//  SetReminderController3.m
//  TrainerVate
//
//  Created by Matrid on 22/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SetReminderController3.h"
#import "Constants.h"

@interface SetReminderController3 () {
    MBProgressHUD *  hudFirst;
    NSMutableDictionary *clientInfo;
    NSMutableDictionary *clientData;
    }

@end

@implementation SetReminderController3
@synthesize reminder3,reminder3ArmSize,reminder3BodyFat,reminder3BoneMass,reminder3ChestSize
,reminder3LegSize,reminder3PhysicalRating,reminder3WaistSize,reminder3Water;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"SetReminderController3_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"SetReminderController3" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"SetReminderController3_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Set Reminder Controller 3"];
    // Do any additional setup after loading the view from its nib.
    reminder3.layer.cornerRadius=reminder3.bounds.size.width/2;
        reminder3ArmSize.layer.cornerRadius=reminder3ArmSize.bounds.size.width/2;
        reminder3BodyFat.layer.cornerRadius=reminder3BodyFat.bounds.size.width/2;
        reminder3BoneMass.layer.cornerRadius=reminder3BoneMass.bounds.size.width/2;
        reminder3ChestSize.layer.cornerRadius=reminder3ChestSize.bounds.size.width/2;
        reminder3LegSize.layer.cornerRadius=reminder3LegSize.bounds.size.width/2;
        reminder3PhysicalRating.layer.cornerRadius=reminder3PhysicalRating.bounds.size.width/2;
        reminder3WaistSize.layer.cornerRadius=reminder3WaistSize.bounds.size.width/2;
        reminder3Water.layer.cornerRadius=reminder3Water.bounds.size.width/2;
    
    clientInfo= [[NSMutableDictionary alloc]init];
    clientData= [[NSMutableDictionary alloc]init];
    
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

-(void)viewWillAppear:(BOOL)animated {
    [self setReminderDefaultValue];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"AboutClintController"]){
        _lblViewTitle.text=@"Update Reminders";
        _done.hidden=NO;
        _next.hidden=YES;
        NSArray *tempArray=[[NSArray alloc]init];
        tempArray=[[SingletonClass singleton].aboutClientData objectForKey:@"rem3"];
        if ([[tempArray valueForKey:@"arm_size"] isEqualToString:@"1"]) {
            [reminder3ArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3ArmSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3ArmSize"];
        }
        if ([[tempArray valueForKey:@"body_fat"] isEqualToString:@"1"]) {
            [reminder3BodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3BodyFat"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3BodyFat"];
        }
        if ([[tempArray valueForKey:@"bone_mass"] isEqualToString:@"1"]) {
            [reminder3BoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3BoneMass"];
           
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3BoneMass"];
        }
        if ([[tempArray valueForKey:@"chest_size"] isEqualToString:@"1"]) {
            [reminder3ChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3ChestSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3ChestSize"];
        }
        if ([[tempArray valueForKey:@"leg_size"] isEqualToString:@"1"]) {
            [reminder3LegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3LegSize"];
           
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3LegSize"];
        }
        if ([[tempArray valueForKey:@"physical_rating"] isEqualToString:@"1"]) {
            [reminder3PhysicalRating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3PhysicalRating"];
           
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3PhysicalRating"];
        }
        if ([[tempArray valueForKey:@"waist_size"] isEqualToString:@"1"]) {
            [reminder3WaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3WaistSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3WaistSize"];
        }
        if ([[tempArray valueForKey:@"water"] isEqualToString:@"1"]) {
            [reminder3Water setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3Water"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3Water"];
        }
        if ([[tempArray valueForKey:@"weight"] isEqualToString:@"1"]) {
            [reminder3 setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3Weight"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"3Weight"];
        }
        
    }
    else{
        _lblViewTitle.text=@"Set Reminders";
        _done.hidden=YES;
        _next.hidden=NO;
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [clientData removeAllObjects];
    [clientInfo removeAllObjects];
    [[SingletonClass singleton].aboutClientData removeAllObjects];
    [[SingletonClass singleton].reminderCreateClient removeAllObjects];
    [super viewWillDisappear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reminder:(id)sender {
    UIImage *selectedImg=[UIImage imageNamed:@"tick2.png"];
    UIImage *currentImage = [sender imageForState:UIControlStateNormal];
    NSData *data1 = UIImagePNGRepresentation(selectedImg);
    NSData *data2 = UIImagePNGRepresentation(currentImage);
    if([sender tag]==10) {
        if ([data1 isEqual:data2]) {
            [reminder3 setBackgroundColor:[UIColor clearColor]];
            [reminder3 setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3Weight"];
            }
            else{
            [reminder3 setBackgroundColor:[UIColor clearColor]];
            [reminder3 setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientInfo setObject:@"0" forKey:@"3Weight"];
            }
        }
    else if([sender tag]==11) {
        if ([data1 isEqual:data2]) {
        [reminder3WaistSize setBackgroundColor:[UIColor clearColor]];
        [reminder3WaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3WaistSize"];
        }
        else {
        [reminder3WaistSize setBackgroundColor:[UIColor clearColor]];
        [reminder3WaistSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3WaistSize"];
        }
    }
    else if([sender tag]==12) {
        if ([data1 isEqual:data2]) {
        [reminder3BodyFat setBackgroundColor:[UIColor clearColor]];
        [reminder3BodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3BodyFat"];
        }
        else {
        [reminder3BodyFat setBackgroundColor:[UIColor clearColor]];
        [reminder3BodyFat setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3BodyFat"];
        }
     }
    else if([sender tag]==13) {
        if ([data1 isEqual:data2]) {
        [reminder3ArmSize setBackgroundColor:[UIColor clearColor]];
        [reminder3ArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3ArmSize"];
        }
        else {
        [reminder3ArmSize setBackgroundColor:[UIColor clearColor]];
        [reminder3ArmSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3ArmSize"];
        }
    }
    else if([sender tag]==15) {
        if ([data1 isEqual:data2]) {
        [reminder3Water setBackgroundColor:[UIColor clearColor]];
        [reminder3Water setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3Water"];
        }
        else {
        [reminder3Water setBackgroundColor:[UIColor clearColor]];
        [reminder3Water setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3Water"];
        }
    }
    else if([sender tag]==14) {
        if ([data1 isEqual:data2]) {
        [reminder3LegSize setBackgroundColor:[UIColor clearColor]];
        [reminder3LegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3LegSize"];
        }
        else {
        [reminder3LegSize setBackgroundColor:[UIColor clearColor]];
        [reminder3LegSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3LegSize"];
        }
    }
    else if([sender tag]==16) {
        if ([data1 isEqual:data2]) {
        [reminder3ChestSize setBackgroundColor:[UIColor clearColor]];
        [reminder3ChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3ChestSize"];
        }
        else {
        [reminder3ChestSize setBackgroundColor:[UIColor clearColor]];
        [reminder3ChestSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3ChestSize"];
        }
    }
    else if([sender tag]==17) {
        if ([data1 isEqual:data2]) {
        [reminder3PhysicalRating setBackgroundColor:[UIColor clearColor]];
        [reminder3PhysicalRating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3PhysicalRating"];
        }
        else {
        [reminder3PhysicalRating setBackgroundColor:[UIColor clearColor]];
        [reminder3PhysicalRating setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3PhysicalRating"];
        }
    }
    else if([sender tag]==18) {
        if ([data1 isEqual:data2]) {
        [reminder3BoneMass setBackgroundColor:[UIColor clearColor]];
        [reminder3BoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3BoneMass"];
        }
        else {
        [reminder3BoneMass setBackgroundColor:[UIColor clearColor]];
        [reminder3BoneMass setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"3BoneMass"];
        }
    }
   

}



- (IBAction)next:(id)sender {
      [self setReminderDaily];
}



#pragma api**************************************************************************************
-(void)setReminderDaily
{
   
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate2/api/alerts_To_Client/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
    NSString *itemIds=[[NSUserDefaults standardUserDefaults]objectForKey:@"itemId"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[[SingletonClass singleton].reminderCreateClient objectForKey:@"Weight"],@"weight",[[SingletonClass singleton].reminderCreateClient objectForKey:@"WaistSize"],@"waist_size",[[SingletonClass singleton].reminderCreateClient objectForKey:@"BodyFat"],@"body_fat",[[SingletonClass singleton].reminderCreateClient objectForKey:@"ArmSize"],@"arm_size",[[SingletonClass singleton].reminderCreateClient objectForKey:@"LegSize"],@"leg_size",[[SingletonClass singleton].reminderCreateClient objectForKey:@"Water"],@"water",[[SingletonClass singleton].reminderCreateClient objectForKey:@"ChestSize"],@"chest_size",[[SingletonClass singleton].reminderCreateClient objectForKey:@"Physicalrating"],@"physical_rating",[[SingletonClass singleton].reminderCreateClient objectForKey:@"BoneMass"],@"bone_mass",@"daily",@"reminder",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                
               
            [self setReminderWeekly];
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
                
            }
               
        }
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Something went wrong, Please try again later"];
    }];
}

-(void)setReminderWeekly
{
    NSString *urlString;
    NSString *itemIds;
   
        urlString=@"http://dev.wellbeingnetwork.com/trainervate2/api/alerts_To_Client/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
        itemIds=[[NSUserDefaults standardUserDefaults]objectForKey:@"itemId"];
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2Weight"],@"weight",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2WaistSize"],@"waist_size",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2BodyFat"],@"body_fat",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2ArmSize"],@"arm_size",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2LegSize"],@"leg_size",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2Water"],@"water",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2ChestSize"],@"chest_size",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2PhysicalRating"],@"physical_rating",[[SingletonClass singleton].reminderCreateClient1 objectForKey:@"2BoneMass"],@"bone_mass",@"weekly",@"reminder",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                
               
              [self setReminderMonthly];
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
                
            }
            
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Something went wrong, Please try again later"];
    }];
}

-(void)setReminderMonthly
{
    
    
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate2/api/alerts_To_Client/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
    NSString *itemIds=[[NSUserDefaults standardUserDefaults]objectForKey:@"itemId"];

    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[clientInfo objectForKey:@"3Weight"],@"weight",[clientInfo objectForKey:@"3WaistSize"],@"waist_size",[clientInfo objectForKey:@"3BodyFat"],@"body_fat",[clientInfo objectForKey:@"3ArmSize"],@"arm_size",[clientInfo objectForKey:@"3LegSize"],@"leg_size",[clientInfo objectForKey:@"3Water"],@"water",[clientInfo objectForKey:@"3ChestSize"],@"chest_size",[clientInfo objectForKey:@"3PhysicalRating"],@"physical_rating",[clientInfo objectForKey:@"3BoneMass"],@"bone_mass",@"monthly",@"reminder",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [hudFirst hide:YES];
                [[SingletonClass singleton].updationValue setObject:[@"1" mutableCopy] forKey:@"reminder"];
                for (UIViewController* viewController in self.navigationController.viewControllers) {
                    
                    if ([viewController isKindOfClass:[MyClientController class]] ) {
                        
                        MyClientController *tom = (MyClientController*)viewController;
                        [self.navigationController popToViewController:tom animated:YES];
                    }
                }
                
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
            }
            
        }
        else {
            [hudFirst hide:YES];
            [Globals alert:@"Something went wrong, Please try again later"];
        }
     
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Something went wrong, Please try again later"];
    }];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setStoredvalue{
        if ([[clientInfo valueForKey:@"arm_size"] isEqualToString:@"1"]) {
        [reminder3ArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"3ArmSize"];
        }
        if ([[clientInfo valueForKey:@"body_fat"] isEqualToString:@"1"]) {
            [reminder3BodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3BodyFat"];
            
        }
        if ([[clientInfo valueForKey:@"bone_mass"] isEqualToString:@"1"]) {
            [reminder3BoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3BoneMass"];
            
        }
        if ([[clientInfo valueForKey:@"chest_size"] isEqualToString:@"1"]) {
            [reminder3ChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3ChestSize"];
            
        }
        if ([[clientInfo valueForKey:@"leg_size"] isEqualToString:@"1"]) {
            [reminder3LegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3LegSize"];
            
        }
        if ([[clientInfo valueForKey:@"physical_rating"] isEqualToString:@"1"]) {
            [reminder3PhysicalRating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3PhysicalRating"];
            
        }
        if ([[clientInfo valueForKey:@"water"] isEqualToString:@"1"]) {
            [reminder3Water setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3Water"];
            
        }
        if ([[clientInfo valueForKey:@"weight"] isEqualToString:@"1"]) {
            [reminder3 setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"3Weight"];
            
        }
}
- (void)setReminderDefaultValue{
   
    [clientInfo setObject:@"0" forKey:@"3Weight"];
    [clientInfo setObject:@"0" forKey:@"3WaistSize"];
    [clientInfo setObject:@"0" forKey:@"3BodyFat"];
    [clientInfo setObject:@"0" forKey:@"3ArmSize"];
    [clientInfo setObject:@"0" forKey:@"3Water"];
    [clientInfo setObject:@"0" forKey:@"3LegSize"];
    [clientInfo setObject:@"0" forKey:@"3ChestSize"];
    [clientInfo setObject:@"0" forKey:@"3PhysicalRating"];
    [clientInfo setObject:@"0" forKey:@"3BoneMass"];
}

#pragma api implimentation*****************************************************

- (IBAction)done:(id)sender {
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:Kurlupdate_alerts_To_Client apiKey:[Globals apiKey]];
     NSString *itemIds=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[clientInfo objectForKey:@"3Weight"],@"weight",[clientInfo objectForKey:@"3WaistSize"],@"waist_size",[clientInfo objectForKey:@"3BodyFat"],@"body_fat",[clientInfo objectForKey:@"3ArmSize"],@"arm_size",[clientInfo objectForKey:@"3LegSize"],@"leg_size",[clientInfo objectForKey:@"3Water"],@"water",[clientInfo objectForKey:@"3ChestSize"],@"chest_size",[clientInfo objectForKey:@"3PhysicalRating"],@"physical_rating",[clientInfo objectForKey:@"3BoneMass"],@"bone_mass",@"monthly",@"reminder",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [hudFirst hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
            }
            
        }
        else {
            [hudFirst hide:YES];
            [Globals alert:@"Something went wrong, Please try again later"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Something went wrong, Please try again later"];
    }];

}

@end
