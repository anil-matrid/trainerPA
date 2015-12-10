//
//  AccountTypeController.m
//  TrainerVate
//
//  Created by Matrid on 08/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AccountTypeController.h"
#import "Constants.h"
#import "UpdateTrainnerController.h"
#import "ClientHomeScreen.h"
#import "ReminderView.h"
#import "AppoinmentViewController.h"
#import "Globals.h"


@interface AccountTypeController (){
    
    AVPlayerLayer* lay;
    NSDictionary *userId;
    ReminderView *reminder;
}
@end

@implementation AccountTypeController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
   
//    if (IS_IPAD) {
//       self = [super initWithNibName:@"AccountTypeController_ipad" bundle:nibBundleOrNil];
//    }
//   else
    if(IS_IPHONE_5_OR_MORE) {
        self = [super initWithNibName:@"AccountTypeController" bundle:nibBundleOrNil];
    }
    else{
        self = [super initWithNibName:@"AccountTypeController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [Globals GoogleAnalyticsScreenName:@"Account Screen"];
    
//    AppoinmentViewController *rem =[[AppoinmentViewController alloc]init];
//    [self.navigationController pushViewController:rem animated:YES];
//    return;
//    reminderNEw.center = self.view.center;
//    reminderNEw.delegate=self;
//    [self.view addSubview:reminderNEw];
    
   //checking if user is login or not
   NSString *checkUserLogin=[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    if (checkUserLogin.length!=0) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
            HomeScreenController *home=[[HomeScreenController alloc]init];
            [self.navigationController pushViewController:home animated:NO];
        }
        else {
            ClientHomeScreen *home=[[ClientHomeScreen alloc]init];
            [self.navigationController pushViewController:home animated:NO];
        }
    }

    BtnClient.frame = CGRectMake(BtnClient.frame.origin.x, BtnClient.frame.origin.y, BtnClient.frame.size.height, BtnClient.frame.size.height);
    BtnTrainer.frame = CGRectMake(BtnTrainer.frame.origin.x, BtnTrainer.frame.origin.y, BtnTrainer.frame.size.height, BtnTrainer.frame.size.height);
    
    userId=[[NSDictionary alloc]init];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
  

}
- (void)addSplashImage{
    
    NSURL* m = [[NSBundle mainBundle] URLForResource:@"splash" withExtension:@"mp4"];
    AVURLAsset* asset = [AVURLAsset URLAssetWithURL:m options:nil];
    AVPlayerItem* item = [AVPlayerItem playerItemWithAsset:asset];
    AVPlayer* p = [AVPlayer playerWithPlayerItem:item];
    self.player = p;
     lay = [AVPlayerLayer playerLayerWithPlayer:p];
    lay.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer addSublayer:lay];
    [p play];
    [self performSelector:@selector(hideVideo) withObject:nil afterDelay:3.0];
}

- (void)hideVideo {

    [lay removeFromSuperlayer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trainner:(id)sender {
    //send user to trainer application
    MainScreenController *main=[[MainScreenController alloc]initWithNibName:@"MainScreenController" bundle:nil];
    main.userID2=[userId objectForKey:@"UserLoginId"];
    main.useType=@"1";
    [self.navigationController pushViewController:main animated:YES];
    
    
}
- (IBAction)trainne:(id)sender {
   
   //send user to client application
    LoginContoller *main=[[LoginContoller alloc]initWithNibName:@"LoginContoller" bundle:nil];
    main.userIdLogin=[userId objectForKey:@"UserLoginId"];
    main.userType=@"0";
    [self.navigationController pushViewController:main animated:YES];
 
}


@end
