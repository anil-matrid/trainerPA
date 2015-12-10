//
//  CreateAccountController.m
//  TrainerVate
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "CreateAccountController.h"
#import "Constants.h"

@interface CreateAccountController ()

@end

@implementation CreateAccountController
@synthesize  clientimage,tainerImage;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"CreateAccountController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"CreateAccountController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"CreateAccountController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    tainerImage.layer.cornerRadius = tainerImage.frame.size.width / 2;
    tainerImage.clipsToBounds = YES;
    clientimage.layer.cornerRadius = clientimage.frame.size.width / 2;
    clientimage.clipsToBounds = YES;
    
    //implimenting navigation bar
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    ClientHomeScreen *clientScreen=[[ClientHomeScreen alloc]init];
    [self.navigationController pushViewController:clientScreen animated:YES];

    
}
@end
