//
//  requestSnedController.m
//  TrainerVate
//
//  Created by Matrid on 23/11/15.
//  Copyright © 2015 Matrid. All rights reserved.
//

#import "requestSnedController.h"
#import "Constants.h"

@interface requestSnedController () {
    UIButton *requestBtn;
}

@end

@implementation requestSnedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Request Send Controller"];
    // Do any additional setup after loading the view from its nib.
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
        txtBackground.layer.cornerRadius=txtBackground.bounds.size.height/2;
    
    //Creating Button
    
    UIImageView *btnBgImage;
    if (IS_IPHONE_4_OR_LESS) {
        btnBgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 428, 320, 52)];
    }
    else {
        btnBgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 516, 320, 52)];
    }
    [btnBgImage setImage:[UIImage imageNamed:@"footernewbg.png"] ];
    [self.view addSubview:btnBgImage];
    
    if (IS_IPHONE_4_OR_LESS) {
        requestBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 428, 320, 52)];
    }
    else {
        requestBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 516, 320, 52)];
    }
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
        headerLbl.text=@"Connect trainer";
        senderLbl.text=@"Enter Trainer Code:";
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"trainerCode"] isEqualToString:@"0"] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] isEqualToString:@"0"]) {
            [requestBtn setTitle:@"Send Request" forState:normal];
        }
        else {
            reciverCode.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"trainerCode"];
            reciverCode.userInteractionEnabled=NO;
            [requestBtn setTitle:@"Cancel Request" forState:normal];
        }
        
    }
    else {
        [requestBtn setTitle:@"Send Request" forState:normal];
    }
    requestBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
    [requestBtn setTitleColor:[UIColor whiteColor] forState:normal];
    [requestBtn addTarget:self action:@selector(request:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:requestBtn];
    [self.view bringSubviewToFront:requestBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)request:(UIButton *)sender {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"trainerCode"] isEqualToString:@"0"] || [[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
        [self sendRequest];
    }
    else {
        [self cancelRequest];
    }
}

-(void)sendRequest{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:kUrlsendRequest apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:reciverCode.text,@"user_id_code",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"],@"user_code",[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"],@"is_from_trainer",nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            [[NSUserDefaults standardUserDefaults]setObject:reciverCode.text forKey:@"trainerCode"];
            for (UIViewController *navController in self.navigationController.viewControllers) {
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
                    if ([navController isKindOfClass:[SettingController class]]) {
                        SettingController *home=(SettingController *)navController;
                        [self.navigationController popToViewController:home animated:YES];
                        break;
                    }
                }
                else {
                    trainerSettings *home=(trainerSettings *)navController;
                    [self.navigationController popToViewController:home animated:YES];
                    break;
                }
            }
        }
        else {
               [hudFirst hide:YES];
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
          [hudFirst hide:YES];
    }];
}

-(void)cancelRequest {
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"ActionOnRequest/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"],@"Logined_UserCode",reciverCode.text,@"Requested_user_code",@"0",@"action",@"1",@"cancel_request",nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"trainerCode"];
            for (UIViewController *navController in self.navigationController.viewControllers) {
                if ([navController isKindOfClass:[ClientHomeScreen class]]) {
                    ClientHomeScreen *home=(ClientHomeScreen *)navController;
                    [self.navigationController popToViewController:home animated:YES];
                }
            }
        }
        else {
            [hudFirst hide:YES];
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];;

}

@end
