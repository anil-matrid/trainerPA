//
//  MainScreenController.m
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "MainScreenController.h"
#import "Constants.h"

@interface MainScreenController ()

@end

@implementation MainScreenController
@synthesize userID2;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"MainScreenController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"MainScreenController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"MainScreenController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Main Screen Controller"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Register:(id)sender {
    RegisterController *regiController=[[RegisterController alloc]initWithNibName:@"RegisterController" bundle:nil];
    [self.navigationController pushViewController:regiController animated:YES];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)login:(id)sender {
    
    LoginContoller *loginControl=[[LoginContoller alloc]initWithNibName:@"LoginContoller" bundle:nil];
    loginControl.userIdLogin=userID2;
    loginControl.userType=self.useType;
    [self.navigationController pushViewController:loginControl animated:YES];
}

@end
