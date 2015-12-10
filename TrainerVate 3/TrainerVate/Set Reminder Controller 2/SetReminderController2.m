//
//  SetReminderController2.m
//  TrainerVate
//
//  Created by Matrid on 22/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SetReminderController2.h"
#import "Constants.h"

@interface SetReminderController2 () {
    NSMutableDictionary *clientInfo;
    NSMutableDictionary *clientData;
}

@end

@implementation SetReminderController2
@synthesize reminder2ArmSize,reminder2BodyFat,reminder2BoneMass,reminder2ChestSize
,reminder2LegSize,reminder2PhysicalRating,reminder2Reminder,reminder2WaistSize,reminder2Water;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"SetReminderController2_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"SetReminderController2" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"SetReminderController2_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Set Reminder Controller 2"];
    // Do any additional setup after loading the view from its nib.
        reminder2ArmSize.layer.cornerRadius=reminder2ArmSize.bounds.size.width/2;
        reminder2BodyFat.layer.cornerRadius=reminder2BodyFat.bounds.size.width/2;
        reminder2BoneMass.layer.cornerRadius=reminder2BoneMass.bounds.size.width/2;
        reminder2ChestSize.layer.cornerRadius=reminder2ChestSize.bounds.size.width/2;
        reminder2LegSize.layer.cornerRadius=reminder2LegSize.bounds.size.width/2;
        reminder2PhysicalRating.layer.cornerRadius=reminder2PhysicalRating.bounds.size.width/2;
        reminder2Reminder.layer.cornerRadius=reminder2Reminder.bounds.size.width/2;
        reminder2WaistSize.layer.cornerRadius=reminder2WaistSize.bounds.size.width/2;
        reminder2Water.layer.cornerRadius=reminder2Water.bounds.size.width/2;
        clientData = [[NSMutableDictionary alloc]init];
        clientInfo = [[NSMutableDictionary alloc]init];
        [self setReminderDefaultValue];
        [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    

}
-(void)viewWillAppear:(BOOL)animated {
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"AboutClintController"]) {
        _lblViewTitle.text=@"Update Reminders";
        _done.hidden=NO;
        _skip.hidden=YES;
        _next.hidden=YES;
        NSArray *tempArray=[[NSArray alloc]init];
        tempArray=[[SingletonClass singleton].aboutClientData objectForKey:@"rem2"];
        if ([[tempArray valueForKey:@"arm_size"] isEqualToString:@"1"]) {
            [reminder2ArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2ArmSize"];
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2ArmSize"];
        }
        if ([[tempArray valueForKey:@"body_fat"] isEqualToString:@"1"]) {
            [reminder2BodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2BodyFat"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2BodyFat"];
        }
        if ([[tempArray valueForKey:@"bone_mass"] isEqualToString:@"1"]) {
            [reminder2BoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2BoneMass"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2BoneMass"];
        }
        if ([[tempArray valueForKey:@"chest_size"] isEqualToString:@"1"]) {
            [reminder2ChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2ChestSize"];
           
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2ChestSize"];
        }
        if ([[tempArray valueForKey:@"leg_size"] isEqualToString:@"1"]) {
            [reminder2LegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2LegSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2LegSize"];
        }
        if ([[tempArray valueForKey:@"physical_rating"] isEqualToString:@"1"]) {
            [reminder2PhysicalRating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2PhysicalRating"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2PhysicalRating"];
        }
        if ([[tempArray valueForKey:@"waist_size"] isEqualToString:@"1"]) {
            [reminder2WaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2WaistSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2WaistSize"];
        }
        if ([[tempArray valueForKey:@"water"] isEqualToString:@"1"]) {
            [reminder2Water setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2Water"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2Water"];
        }
        if ([[tempArray valueForKey:@"weight"] isEqualToString:@"1"]) {
            [reminder2Reminder setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"2Weight"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"2Weight"];
        }
        
        
    }
    else{
        _lblViewTitle.text=@"Set Reminders";
        _done.hidden=YES;
        _skip.hidden=NO;
        _next.hidden=NO;
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [clientData removeAllObjects];
    [clientInfo removeAllObjects];
    [[SingletonClass singleton].aboutClientData removeAllObjects];
    [super viewWillDisappear:YES];
    
}
- (IBAction)next:(id)sender {
    SetReminderController3 *reminder3=[[SetReminderController3 alloc]init];
    [self.navigationController pushViewController:reminder3 animated:YES];
}
- (IBAction)reminder:(id)sender {
    
    if (clientInfo==nil || clientInfo.count==0) {
        return;
    }
    // setting previous stored value............................
    [self setStoredvalue];
    //storing user current values
    UIImage *selectedImg=[UIImage imageNamed:@"tick2.png"];
    UIImage *currentImage = [sender imageForState:UIControlStateNormal];
    NSData *data1 = UIImagePNGRepresentation(selectedImg);
    NSData *data2 = UIImagePNGRepresentation(currentImage);
    if([sender tag]==12) {
        if ([data1 isEqual:data2]) {
        [reminder2BodyFat setBackgroundColor:[UIColor clearColor]];
        [reminder2BodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2BodyFat"];
        }
        else {
        [reminder2BodyFat setBackgroundColor:[UIColor clearColor]];
        [reminder2BodyFat setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2BodyFat"];
        }
    }

    else if([sender tag]==10) {
        if ([data1 isEqual:data2]) {
        [reminder2Reminder setBackgroundColor:[UIColor clearColor]];
        [reminder2Reminder setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2Weight"];
        }
        else{
        [reminder2Reminder setBackgroundColor:[UIColor clearColor]];
        [reminder2Reminder setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2Weight"];
        }
    }
    else if([sender tag]==11)
    {
        if ([data1 isEqual:data2]) {
        [reminder2WaistSize setBackgroundColor:[UIColor clearColor]];
        [reminder2WaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2WaistSize"];
        }
        else
        {
        [reminder2WaistSize setBackgroundColor:[UIColor clearColor]];
        [reminder2WaistSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2WaistSize"];
        }
    }
    else if([sender tag]==13) {
        if ([data1 isEqual:data2]) {
        [reminder2ArmSize setBackgroundColor:[UIColor clearColor]];
        [reminder2ArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2ArmSize"];
        }
    else {
        [reminder2ArmSize setBackgroundColor:[UIColor clearColor]];
        [reminder2ArmSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2ArmSize"];
        }
    }
    else if([sender tag]==14) {
        if ([data1 isEqual:data2]) {
        [reminder2LegSize setBackgroundColor:[UIColor clearColor]];
        [reminder2LegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2LegSize"];
        }
        else{
        [reminder2LegSize setBackgroundColor:[UIColor clearColor]];
        [reminder2LegSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2LegSize"];
        }
    }
    else if([sender tag]==15)
    {
        if ([data1 isEqual:data2]) {
        [reminder2Water setBackgroundColor:[UIColor clearColor]];
        [reminder2Water setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2Water"];
        }
        else{
        [reminder2Water setBackgroundColor:[UIColor clearColor]];
        [reminder2Water setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2Water"];
        }
    }
    else if([sender tag]==16) {
        if ([data1 isEqual:data2]) {
        [reminder2ChestSize setBackgroundColor:[UIColor clearColor]];
        [reminder2ChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2ChestSize"];
        }
        else{
        [reminder2ChestSize setBackgroundColor:[UIColor clearColor]];
        [reminder2ChestSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2ChestSize"];
        }
    }
    else if([sender tag]==17) {
        if ([data1 isEqual:data2]) {
        [reminder2PhysicalRating setBackgroundColor:[UIColor clearColor]];
        [reminder2PhysicalRating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2PhysicalRating"];
        }
        else{
        [reminder2PhysicalRating setBackgroundColor:[UIColor clearColor]];
        [reminder2PhysicalRating setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2PhysicalRating"];
        }
    }
    else if ([sender tag]==18){
        if ([data1 isEqual:data2]) {
        [reminder2BoneMass setBackgroundColor:[UIColor clearColor]];
        [reminder2BoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2BoneMass"];
        }
        else{
        [reminder2BoneMass setBackgroundColor:[UIColor clearColor]];
        [reminder2BoneMass setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"2BoneMass"];
        }
    }
    [SingletonClass singleton].reminderCreateClient1= [[NSMutableDictionary alloc]init];
    [SingletonClass singleton].reminderCreateClient1=[clientInfo mutableCopy];


}
- (IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)skip:(id)sender {
    [self setReminderDefaultValue];
    clientData=[clientInfo mutableCopy];
    [SingletonClass singleton].reminderCreateClient1=[clientInfo mutableCopy];
    SetReminderController3 *reminder3=[[SetReminderController3 alloc]init];
    [self.navigationController pushViewController:reminder3 animated:YES];

}

- (void)setReminderDefaultValue {
    [clientInfo setObject:@"0" forKey:@"2BodyFat"];
    [clientInfo setObject:@"0" forKey:@"2Weight"];
    [clientInfo setObject:@"0" forKey:@"2WaistSize"];
    [clientInfo setObject:@"0" forKey:@"2ArmSize"];
    [clientInfo setObject:@"0" forKey:@"2LegSize"];
    [clientInfo setObject:@"0" forKey:@"2Water"];
    [clientInfo setObject:@"0" forKey:@"2ChestSize"];
    [clientInfo setObject:@"0" forKey:@"2PhysicalRating"];
    [clientInfo setObject:@"0" forKey:@"2BoneMass"];
    [SingletonClass singleton].reminderCreateClient1=[clientInfo mutableCopy];
   
    
}

- (void)setStoredvalue{
    if ([[clientInfo valueForKey:@"arm_size"] isEqualToString:@"1"]) {
        [reminder2ArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2ArmSize"];
    }
    if ([[clientInfo valueForKey:@"body_fat"] isEqualToString:@"1"]) {
        [reminder2BodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2BodyFat"];
        
    }
    if ([[clientInfo valueForKey:@"bone_mass"] isEqualToString:@"1"]) {
        [reminder2BoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2BoneMass"];
        
    }
    if ([[clientInfo valueForKey:@"chest_size"] isEqualToString:@"1"]) {
        [reminder2ChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2ChestSize"];
        
    }
    if ([[clientInfo valueForKey:@"leg_size"] isEqualToString:@"1"]) {
        [reminder2LegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2LegSize"];
        
    }
    if ([[clientInfo valueForKey:@"physical_rating"] isEqualToString:@"1"]) {
        [reminder2PhysicalRating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2PhysicalRating"];
        
    }
    if ([[clientInfo valueForKey:@"waist_size"] isEqualToString:@"1"]) {
        [reminder2WaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2WaistSize"];
        
    }
    if ([[clientInfo valueForKey:@"water"] isEqualToString:@"1"]) {
        [reminder2Water setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2Water"];
        
    }
    if ([[clientInfo valueForKey:@"weight"] isEqualToString:@"1"]) {
        [reminder2Reminder setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"2Weight"];
        
    }

}
#pragma api implimentation******************************************
- (IBAction)done:(id)sender {
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
        NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:Kurlupdate_alerts_To_Client apiKey:[Globals apiKey]];
        NSString *itemIds=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
        NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[clientInfo objectForKey:@"2Weight"],@"weight",[clientInfo objectForKey:@"2WaistSize"],@"waist_size",[clientInfo objectForKey:@"2BodyFat"],@"body_fat",[clientInfo objectForKey:@"2ArmSize"],@"arm_size",[clientInfo objectForKey:@"2LegSize"],@"leg_size",[clientInfo objectForKey:@"2Water"],@"water",[clientInfo objectForKey:@"2ChestSize"],@"chest_size",[clientInfo objectForKey:@"2PhysicalRating"],@"physical_rating",[clientInfo objectForKey:@"2BoneMass"],@"bone_mass",@"weekly",@"reminder",nil];
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
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else{
                    [hudFirst hide:YES];
                    [Globals alert:[json objectForKey:@"message"]];
                    
                }
                
            }
            else{
                [hudFirst hide:YES];
                 [Globals alert:@"Something went wrong, Please try again later"];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hudFirst hide:YES];
            [Globals alert:@"Something went wrong, Please try again later"];
        }];
 
}
@end
