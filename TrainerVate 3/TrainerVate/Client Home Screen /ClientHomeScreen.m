//
//  ClientHomeScreen.m
//  TrainerVate
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ClientHomeScreen.h"
#import "workoutController.h"
#import "Constants.h"
#import "shopController.h"
#import "messagesMainChatController.h"
#import "clientSideRecommendation.h"

@interface ClientHomeScreen ()

@end

@implementation ClientHomeScreen
@synthesize userprofilePic;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"ClientHomeScreen_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"ClientHomeScreen" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"ClientHomeScreen_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    _userName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
//    userprofilePic.image=[UIImage imageNamed:@"download1.jpeg"];
//    userprofilePic.layer.cornerRadius = userprofilePic.frame.size.width / 2;
//    userprofilePic.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutPerform) name:@"logouts" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutPerform) name:@"workouts" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dietplanPerform) name:@"dietplans" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statPerform) name:@"stats" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagePerform) name:@"messages" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopPerform) name:@"shops" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsPerform) name:@"settings" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recommendationPerform) name:@"recomends" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calendarPerform) name:@"calendars" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homePerform) name:@"homes" object:nil];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    NSString *userPic=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userPic"] ];
   if (userPic==nil || [userPic isEqual:[NSNull null] ] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"null"]) {
        self.userprofilePic.image=[UIImage imageNamed:@"default8.png"];
    }
    else{
        NSString *usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",userPic];
        [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:usrImage]];
        self.userprofilePic.image=[Globals getImagesFromCache:usrImage];
    }
    self.userprofilePic.layer.cornerRadius = self.userprofilePic.frame.size.width / 2;
    self.userprofilePic.clipsToBounds = YES;
    _userName.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"trainerName"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutPerform {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)homePerform{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[ClientHomeScreen class]] ) {
            ClientHomeScreen *myClient=(ClientHomeScreen *)viewController;
            [self.navigationController popToViewController:myClient animated:YES];
        }
    }
}

-(void)workoutPerform{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[workoutController class]] ) {
            workoutController *tom = (workoutController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        workoutController *myClient=[[workoutController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
    
}

-(void)dietplanPerform{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]] ) {
            DietPlanController *tom = (DietPlanController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        DietPlanController *myClient=[[DietPlanController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
    
}

-(void)statPerform{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[MyStats class]] ) {
            MyStats *tom = (MyStats*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        MyStats *myClient=[[MyStats alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
    
}

-(void)messagePerform{
    
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]] ) {
            DietPlanController *tom = (DietPlanController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        DietPlanController *myClient=[[DietPlanController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
}

-(void)shopPerform{
    
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[shopController class]] ) {
            shopController *tom = (shopController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        shopController *myClient=[[shopController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
}

-(void)recommendationPerform{
    
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[clientSideRecommendation class]] ) {
            clientSideRecommendation *tom = (clientSideRecommendation*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        clientSideRecommendation *myClient=[[clientSideRecommendation alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
}

-(void)settingsPerform{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[SettingController class]] ) {
            SettingController *tom = (SettingController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        SettingController *myClient=[[SettingController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
}

-(void)calendarPerform{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[calenderViewController class]] ) {
            calenderViewController *tom = (calenderViewController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        calenderViewController *myClient=[[calenderViewController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
    
}


- (IBAction)workoutClient:(id)sender {
    workoutController *workout=[[workoutController alloc] init];
    [self.navigationController pushViewController:workout animated:YES];
}

- (IBAction)dietPlanClient:(id)sender {
    DietPlanController *diet=[[DietPlanController alloc]init];
    [self.navigationController pushViewController:diet animated:YES];
}

- (IBAction)calendarClient:(id)sender {
    calenderViewController *calendar=[[calenderViewController alloc]init];
    [self.navigationController pushViewController:calendar animated:YES];
}

- (IBAction)messagesClient:(id)sender {
    messagesMainChatController *message=[[messagesMainChatController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}

- (IBAction)myStats:(id)sender {
    MyStats *stats=[[MyStats alloc]init];
    [self.navigationController pushViewController:stats animated:YES];
}

- (IBAction)recommended:(id)sender {
    clientSideRecommendation *reco=[[clientSideRecommendation alloc]init];
    [self.navigationController pushViewController:reco animated:YES];
}

- (IBAction)shopClient:(id)sender {
    shopController *shop=[[shopController alloc]init];
    [self.navigationController pushViewController:shop animated:YES];
}

- (IBAction)settingClient:(id)sender {
    SettingController *settingControl=[[SettingController alloc]init];
    [self.navigationController pushViewController:settingControl animated:YES];
}

- (IBAction)signOut:(id)sender {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    [AppDelegate generateTheAPiKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
