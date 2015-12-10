//
//  SetReminderController.m
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SetReminderController.h"
#import "Constants.h"

@interface SetReminderController (){
    NSMutableDictionary *clientInfo;
     NSMutableDictionary *clientData;
}

@end

@implementation SetReminderController
@synthesize reminderArmSize,reminderBodyFat,reminderBoneMass,reminderChestSize,reminderLegSize,reminderPhysicalrating,reminderWaistSize,reminderWater,reminderWeight;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"SetReminderController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"SetReminderController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"SetReminderController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Set Reminder Controller"];
    
    // setting buttons outlets
        reminderWeight.layer.cornerRadius=reminderWeight.bounds.size.width/2;
    reminderWaistSize.layer.cornerRadius=reminderWaistSize.bounds.size.width/2;
    reminderBodyFat.layer.cornerRadius=reminderBodyFat.bounds.size.width/2;
    reminderArmSize.layer.cornerRadius=reminderArmSize.bounds.size.width/2;
    reminderLegSize.layer.cornerRadius=reminderLegSize.bounds.size.width/2;
    reminderWater.layer.cornerRadius=reminderWater.bounds.size.width/2;
    reminderChestSize.layer.cornerRadius=reminderChestSize.bounds.size.width/2;
    reminderPhysicalrating.layer.cornerRadius=reminderPhysicalrating.bounds.size.width/2;
    reminderBoneMass.layer.cornerRadius=reminderBoneMass.bounds.size.width/2;
    
    clientInfo=[[NSMutableDictionary alloc]init];
    clientData=[[NSMutableDictionary alloc]init];
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self setReminderDefaultValue];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"AboutClintController"]){
        _lblViewTitle.text=@"Update Reminders";
        _done.hidden=NO;
        _skip.hidden=YES;
        _next.hidden=YES;
        NSArray *tempArray=[[NSArray alloc]init];
        tempArray=[[SingletonClass singleton].aboutClientData objectForKey:@"rem1"];
        if ([[tempArray valueForKey:@"arm_size"] isEqualToString:@"1"]) {
            [reminderArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"ArmSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"ArmSize"];
        }
        if ([[tempArray valueForKey:@"body_fat"] isEqualToString:@"1"]) {
            [reminderBodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"BodyFat"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"BodyFat"];
        }
        if ([[tempArray valueForKey:@"bone_mass"] isEqualToString:@"1"]) {
            [reminderBoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"BoneMass"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"BoneMass"];
        }
        if ([[tempArray valueForKey:@"chest_size"] isEqualToString:@"1"]) {
            [reminderChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"ChestSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"ChestSize"];
        }
        if ([[tempArray valueForKey:@"leg_size"] isEqualToString:@"1"]) {
            [reminderLegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"LegSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"LegSize"];
        }
        if ([[tempArray valueForKey:@"physical_rating"] isEqualToString:@"1"]) {
            [reminderPhysicalrating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"Physicalrating"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"Physicalrating"];
        }
        if ([[tempArray valueForKey:@"waist_size"] isEqualToString:@"1"]) {
            [reminderWaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"WaistSize"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"WaistSize"];
        }
        if ([[tempArray valueForKey:@"water"] isEqualToString:@"1"]) {
            [reminderWater setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"Water"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"Water"];
        }

        if ([[tempArray valueForKey:@"weight"] isEqualToString:@"1"]) {
            [reminderWeight setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientInfo setObject:@"1" forKey:@"Weight"];
            
        }
        else{
            [clientInfo setObject:@"0" forKey:@"Weight"];
        }
    }
    else{
        _lblViewTitle.text=@"Set Reminders";
        _done.hidden=YES;
        _skip.hidden=NO;
        _next.hidden=NO;
        //Setting default values for reminder....................................
        
        [self setReminderDefaultValue];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)reminder:(id)sender {
    if ([clientInfo allKeys]==0 || clientInfo.count==0) {
        return;
    }
    //settin previous stored value
    [self setStoredValue];
    //setting value taken by user
    if ([sender tag]==1) {
        SetReminderController2 *reminder2=[[SetReminderController2 alloc]init];
        [self.navigationController pushViewController:reminder2 animated:YES];
    }
    UIImage *selectedImg=[UIImage imageNamed:@"tick2.png"];
    UIImage *currentImage = [sender imageForState:UIControlStateNormal];
    NSData *data1 = UIImagePNGRepresentation(selectedImg);
    NSData *data2 = UIImagePNGRepresentation(currentImage);
    
    if([sender tag]==10) {
        if ([data1 isEqual:data2]) {
        [reminderWeight setBackgroundColor:[UIColor clearColor]];
        [reminderWeight setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"Weight"];
        }
        else {
        [reminderWeight setBackgroundColor:[UIColor clearColor]];
        [reminderWeight setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"Weight"];
        }
    }
    else if([sender tag]==11)  {
        if ([data1 isEqual:data2]) {
        [reminderWaistSize setBackgroundColor:[UIColor clearColor]];
        [reminderWaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"WaistSize"];
        }
        else {
        [reminderWaistSize setBackgroundColor:[UIColor clearColor]];
        [reminderWaistSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"WaistSize"];
        }
   }
   else if([sender tag]==12) {
        if ([data1 isEqual:data2]) {
        [reminderBodyFat setBackgroundColor:[UIColor clearColor]];
        [reminderBodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"BodyFat"];
        }
        else {
        [reminderBodyFat setBackgroundColor:[UIColor clearColor]];
        [reminderBodyFat setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"BodyFat"];
        }
    }
    else if([sender tag]==13) {
        if ([data1 isEqual:data2]) {
        [reminderArmSize setBackgroundColor:[UIColor clearColor]];
        [reminderArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"ArmSize"];
        }
        else {
        [reminderArmSize setBackgroundColor:[UIColor clearColor]];
        [reminderArmSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"ArmSize"];
        }
    }
    else if ([sender tag]==14) {
        if ([data1 isEqual:data2]) {
        [reminderLegSize setBackgroundColor:[UIColor clearColor]];
        [reminderLegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"LegSize"];
       
        }
        else {
        [reminderLegSize setBackgroundColor:[UIColor clearColor]];
        [reminderLegSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"LegSize"];
        }
    }
    else if([sender tag]==15) {
        if ([data1 isEqual:data2]) {
        [reminderWater setBackgroundColor:[UIColor clearColor]];
        [reminderWater setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"Water"];
        }
        else{
        [reminderWater setBackgroundColor:[UIColor clearColor]];
        [reminderWater setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"Water"];
        }
    }
    else if([sender tag]==16) {
        if ([data1 isEqual:data2]) {
        [reminderChestSize setBackgroundColor:[UIColor clearColor]];
        [reminderChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"ChestSize"];
        }
        else{
        [reminderChestSize setBackgroundColor:[UIColor clearColor]];
        [reminderChestSize setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"ChestSize"];
        }
    }
    else if ([sender tag]==17) {
        if ([data1 isEqual:data2]) {
        [reminderPhysicalrating setBackgroundColor:[UIColor clearColor]];
        [reminderPhysicalrating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"Physicalrating"];
        }
        else {
        [reminderPhysicalrating setBackgroundColor:[UIColor clearColor]];
        [reminderPhysicalrating setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"Physicalrating"];
        }
    }
    else if([sender tag]==18) {
        if ([data1 isEqual:data2]) {
        [reminderBoneMass setBackgroundColor:[UIColor clearColor]];
        [reminderBoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"BoneMass"];
        }
        else{
        [reminderBoneMass setBackgroundColor:[UIColor clearColor]];
        [reminderBoneMass setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [clientInfo setObject:@"0" forKey:@"BoneMass"];
        }
    }
    
    [SingletonClass singleton].reminderCreateClient=[clientInfo mutableCopy];
  
}

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
                   
            NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[clientInfo objectForKey:@"Weight"],@"weight",[clientInfo objectForKey:@"WaistSize"],@"waist_size",[clientInfo objectForKey:@"BodyFat"],@"body_fat",[clientInfo objectForKey:@"ArmSize"],@"arm_size",[clientInfo objectForKey:@"LegSize"],@"leg_size",[clientInfo objectForKey:@"Water"],@"water",[clientInfo objectForKey:@"ChestSize"],@"chest_size",[clientInfo objectForKey:@"Physicalrating"],@"physical_rating",[clientInfo objectForKey:@"BoneMass"],@"bone_mass",@"daily",@"reminder",nil];
            
            AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSError* error;
                NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:kNilOptions error:&error];
                if (json !=nil && json.allKeys.count!=0) {
                    
                    if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                        [hudFirst hide:YES];
                        [clientInfo setObject:@"1" forKey:@"reminder"];
                        [SingletonClass singleton].updationValue=[clientInfo mutableCopy];
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


-(void)viewWillDisappear:(BOOL)animated
{
    [clientData removeAllObjects];
    [clientInfo removeAllObjects];
    [[SingletonClass singleton].aboutClientData removeAllObjects];
    [super viewWillDisappear:YES];
    
}

- (IBAction)skip:(id)sender {
    
    [self setReminderDefaultValue];
    [SingletonClass singleton].reminderCreateClient=[clientInfo mutableCopy];
    SetReminderController2 *reminder2=[[SetReminderController2 alloc]init];
    [self.navigationController pushViewController:reminder2 animated:YES];
}
- (void)setReminderDefaultValue {
    [clientInfo setObject:@"0" forKey:@"Weight"];
    [clientInfo setObject:@"0" forKey:@"WaistSize"];
    [clientInfo setObject:@"0" forKey:@"BodyFat"];
    [clientInfo setObject:@"0" forKey:@"ArmSize"];
    [clientInfo setObject:@"0" forKey:@"LegSize"];
    [clientInfo setObject:@"0" forKey:@"Water"];
    [clientInfo setObject:@"0" forKey:@"ChestSize"];
    [clientInfo setObject:@"0" forKey:@"Physicalrating"];
    [clientInfo setObject:@"0" forKey:@"BoneMass"];
}

- (void)setStoredValue{
    if ([[clientInfo valueForKey:@"arm_size"] isEqualToString:@"1"]) {
        [reminderArmSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"ArmSize"];
        
    }
    if ([[clientInfo valueForKey:@"body_fat"] isEqualToString:@"1"]) {
        [reminderBodyFat setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"BodyFat"];
        
    }
    if ([[clientInfo valueForKey:@"bone_mass"] isEqualToString:@"1"]) {
        [reminderBoneMass setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"BoneMass"];
        
    }
    if ([[clientInfo valueForKey:@"chest_size"] isEqualToString:@"1"]) {
        [reminderChestSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"ChestSize"];
        
    }
    if ([[clientInfo valueForKey:@"leg_size"] isEqualToString:@"1"]) {
        [reminderLegSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"LegSize"];
        
    }
    if ([[clientInfo valueForKey:@"physical_rating"] isEqualToString:@"1"]) {
        [reminderPhysicalrating setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"Physicalrating"];
        
    }
    if ([[clientInfo valueForKey:@"waist_size"] isEqualToString:@"1"]) {
        [reminderWaistSize setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"WaistSize"];
        
    }
    if ([[clientInfo valueForKey:@"water"] isEqualToString:@"1"]) {
        [reminderWater setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"Water"];
        
    }
    if ([[clientInfo valueForKey:@"weight"] isEqualToString:@"1"]) {
        [reminderWeight setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [clientInfo setObject:@"1" forKey:@"Weight"];
        
    }
    
}
@end
