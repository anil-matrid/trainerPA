//
//  AddBodyStats.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AddBodyStats.h"
#import "Constants.h"
@interface AddBodyStats()

@end

@implementation AddBodyStats
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"AddBodyStats" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"AddBodyStats_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Globals GoogleAnalyticsScreenName:@"Add Body Stats"];
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




- (IBAction)backStats:(id)sender {
    MyStats *stats =[[MyStats alloc]initWithNibName:@"MyStats" bundle:nil];
    [self.navigationController pushViewController:stats animated:YES];

}

- (IBAction)basic:(id)sender {
    BasicController *basic =[[BasicController alloc]initWithNibName:@"BasicController" bundle:nil];
    [self.navigationController pushViewController:basic animated:YES];
    
}

- (IBAction)bmi:(id)sender {
    BMIController *bmiCon=[[BMIController alloc]initWithNibName:@"BMIController" bundle:nil];
    [self.navigationController pushViewController:bmiCon animated:YES];
}

- (IBAction)sm:(id)sender {
    SMController *smCon=[[SMController alloc]initWithNibName:@"SMController" bundle:nil];
    [self.navigationController pushViewController:smCon animated:YES];
}

- (IBAction)skinFold:(id)sender {
    SkinFoldController *skinCon=[[SkinFoldController alloc]initWithNibName:@"SkinFoldController" bundle:nil];
    [self.navigationController pushViewController:skinCon animated:YES];
}

- (IBAction)bf:(id)sender {
    BFController *bfCon=[[BFController alloc]initWithNibName:@"BFController" bundle:nil];
    [self.navigationController pushViewController:bfCon animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
