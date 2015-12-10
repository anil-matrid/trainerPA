//
//  HomeScreenController.m
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "HomeScreenController.h"
#import "recommend1.h"
#import "Constants.h"

@interface HomeScreenController ()

@end

@implementation HomeScreenController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"HomeScreenController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"HomeScreenController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"HomeScreenController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //GIA
    [Globals GoogleAnalyticsScreenName:@"Home Screen Controller"];
    
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    NSString *lang = [[NSLocale currentLocale] displayNameForKey:NSLocaleLanguageCode value:language];
  // Sign out.................
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutPerform) name:@"logout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myClientPerform) name:@"myClient" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messagePerform) name:@"message" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopPerform) name:@"shop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsPerform) name:@"setting" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recommendationPerform) name:@"recomend" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(calendarPerform) name:@"calendar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homePerform) name:@"home" object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    NSString *userPic=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userPic"] ];
    if (userPic==nil || [userPic isEqual:[NSNull null]] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@"null"]) {
        self.profilePics.image=[UIImage imageNamed:@"default8.png"];
        
    }
    else{
        NSString *usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",userPic];
        self.profilePics.image=[Globals getImagesFromCache:usrImage];
    }
    self.profilePics.layer.cornerRadius = self.profilePics.frame.size.width / 2;
    self.profilePics.clipsToBounds = YES;
    self.profileUserName.text=[[[NSUserDefaults standardUserDefaults] objectForKey:@"trainerName"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.editProfile.adjustsImageWhenHighlighted=NO;
    self.editProfile.layer.cornerRadius = self.profilePics.frame.size.width / 2;
    self.editProfile.clipsToBounds = YES;
    
}

- (void)logoutPerform {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)homePerform{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[HomeScreenController class]] ) {
            HomeScreenController *myClient=(HomeScreenController *)viewController;
            [self.navigationController popToViewController:myClient animated:YES];
        }
    }
}

-(void)myClientPerform{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[MyClientController class]] ) {
            MyClientController *tom = (MyClientController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        MyClientController *myClient=[[MyClientController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
    
}

-(void)messagePerform{
    
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[messagesController class]] ) {
            messagesController *tom = (messagesController*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        messagesController *myClient=[[messagesController alloc]init];
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
        if ([viewController isKindOfClass:[recommend1 class]]) {
            recommend1 *tom = (recommend1*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
        }
    }
    if (flag==NO) {
        recommend1 *tom=[[recommend1 alloc]init];
        [self.navigationController pushViewController:tom animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnHomeScreen:(id)sender {
    
    if ([sender tag]==10) {
        MyClientController *myClient=[[MyClientController alloc]init];
        [self.navigationController pushViewController:myClient animated:YES];
    }
    
    if ([sender tag]==11) {
        recommend1 *rec=[[recommend1 alloc]init];
        [self.navigationController pushViewController:rec animated:YES];
    }
    
    if ([sender tag]==12) {
         messagesController *message=[[messagesController alloc]init];
        [self.navigationController pushViewController:message animated:YES];
    }
    
    if ([sender tag]==13) {
        calenderViewController *calendar=[[calenderViewController alloc]init];
        [self.navigationController pushViewController:calendar animated:YES];
    }
    
    if ([sender tag]==14) {
        shopController *shop=[[shopController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }
    
    if ([sender tag]==15) {
        trainerSettings *setting=[[trainerSettings alloc]init];
        [self.navigationController pushViewController:setting animated:YES];
    }
    
}



- (IBAction)profilePicEditor:(id)sender {
    addProfileController *profile=[[addProfileController alloc]init];
    [self.navigationController pushViewController:profile animated:YES];
}
@end
