//
//  SettingController.m
//  Settings
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SettingController.h"
#import "Constants.h"
#import "clearChatClient.h"
#import "trainerSettings.h"
#import "requestSnedController.h"

@interface SettingController ()

@end

@implementation SettingController
@synthesize settingScrollView,blurredView,view2,idLbl;
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    if (IS_IPAD) {
//        self = [super initWithNibName:@"SettingController_ipad" bundle:nibBundleOrNil];
//    }
//    else if(IS_IPHONE_5_OR_MORE) {
//        
//        self = [super initWithNibName:@"SettingController" bundle:nibBundleOrNil];
//    }
//    else
//    {
//        self = [super initWithNibName:@"SettingController_4" bundle:nibBundleOrNil];
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    blurredView.hidden=YES;
    view2.hidden=YES;
    idLbl.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"];
    //implimenting navigation bar
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTapped:)];
    tap.numberOfTapsRequired = 1;
    [idLbl addGestureRecognizer:tap];
    idLbl.userInteractionEnabled = YES;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"] isEqualToString:@"0"]) {
        [_disconnectTrainer setTitle:@"       Connect Trainer" forState:normal];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
        _notification.on=YES;
    }
    else {
        _notification.on=NO;
    }
}

- (void) textTapped:(UITapGestureRecognizer *) gestureRecognizer {
    blurredView.hidden=YES;
    view2.hidden=YES;
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized &&
        [gestureRecognizer.view isKindOfClass:[UILabel class]]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:idLbl.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"ID has been copied to clipboard." delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    if (IS_IPHONE_5_OR_MORE) {
         _scroll.contentSize = CGSizeMake(_scroll.frame.size.width, 655);
    }
    else {
        _scroll.contentSize = CGSizeMake(_scroll.frame.size.width, 744);
    }
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pushNotification:(id)sender {
    NSString *isNoti;
    if([sender isOn]){
        isNoti=@"1";
    }
    else {
        isNoti=@"0";
    }
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *userCode=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"Notification/" apiKey:[Globals apiKey]];
    NSMutableDictionary *SendingDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:isNoti,@"status",userCode,@"user_code", nil];
    [Globals PostApiURL:urlString data:SendingDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            
            [[NSUserDefaults standardUserDefaults]setValue:isNoti forKey:@"notification"];
           
        }
        else{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
                _notification.on=YES;
            }
            else {
                _notification.on=NO;
            }
        }
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
            _notification.on=YES;
        }
        else {
            _notification.on=NO;
        }
         [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
            _notification.on=YES;
        }
        else {
            _notification.on=NO;
        }
    }];
    
}

- (IBAction)language:(id)sender {
    
}

- (IBAction)voiceOver:(id)sender {
}

- (IBAction)changeEmail:(id)sender {
    ChangeEmailGetCode *cegt = [[ChangeEmailGetCode alloc]init];
    [self.navigationController pushViewController:cegt animated:YES];
}

- (IBAction)changePassword:(id)sender {
    ChangePasswordTrainer *ctp = [[ChangePasswordTrainer alloc]init];
    [self.navigationController pushViewController:ctp animated:YES];
}

- (IBAction)addProfilePic:(id)sender {
    addProfileController *addPicture=[[addProfileController alloc]init];
    [self.navigationController pushViewController:addPicture animated:YES];
}

- (IBAction)disconnectTrainer:(id)sender {
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"] isEqualToString:@"0"]) {
        requestSnedController *requset=[[requestSnedController alloc] init];
        [self.navigationController pushViewController:requset animated:YES];
    }
    else {
        DisconnectTrainer *disc=[[DisconnectTrainer alloc]init];
        [self.navigationController pushViewController:disc animated:YES];
    }
    
}

- (IBAction)termsConditions:(id)sender {
}

- (IBAction)privacyPolicy:(id)sender {
}
- (IBAction)signoutBtn:(id)sender {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    [AppDelegate generateTheAPiKey];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)clearChatBtn:(id)sender {
    clearChatClient *cct = [[clearChatClient alloc]init];
    [self.navigationController pushViewController:cct animated:YES];
}
- (IBAction)uniqueBtn:(id)sender {
    blurredView.hidden=NO;
    view2.hidden=NO;
}
- (IBAction)okBtn:(id)sender {
    blurredView.hidden=YES;
    view2.hidden=YES;
}
@end
