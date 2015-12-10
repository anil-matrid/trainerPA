//
//  DietPlanIndividual.m
//  TrainerVate
//
//  Created by Matrid on 14/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DietPlanIndividual.h"
#import "Constants.h"

@interface DietPlanIndividual ()

@end

@implementation DietPlanIndividual
@synthesize yearly,daily,weekly,daysOptions,btnImage,btnImage2,navigationBar;
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Diet Plan Individual"];
    // Do any additional setup after loading the view from its nib.
    [self setScrollviewOffset];
    weekly.hidden=YES;
    yearly.hidden=YES;
    daily.hidden=YES;
    btnImage2.hidden=YES;

    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setScrollviewOffset
{
    if (IS_IPHONE_4_OR_LESS) {
        dietPlanIndividualViews.contentSize = CGSizeMake(dietPlanIndividualViews.frame.size.width, 1990);
    }
    else
    {
        dietPlanIndividualViews.contentSize = CGSizeMake(dietPlanIndividualViews.frame.size.width, 1880);
    }
    
}
int days=0;
- (IBAction)navigationBar:(id)sender {
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)weekly:(id)sender {
    [daysOptions setTitle:@"    Weekly" forState:normal];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    daily.hidden=YES;
    animation.duration = 0.8;
    [daily.layer addAnimation:animation forKey:nil];
    weekly.hidden=YES;
    animation.duration = 0.6;
    [weekly.layer addAnimation:animation forKey:nil];
    yearly.hidden=YES;
    animation.duration = 0.4;
    [yearly.layer addAnimation:animation forKey:nil];
    btnImage2.hidden=YES;
    btnImage.hidden=NO;
    days=0;
}
- (IBAction)yearly:(id)sender {
    [daysOptions setTitle:@"    Monthly" forState:normal];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    daily.hidden=YES;
    animation.duration = 0.8;
    [daily.layer addAnimation:animation forKey:nil];
    weekly.hidden=YES;
    animation.duration = 0.6;
    [weekly.layer addAnimation:animation forKey:nil];
    yearly.hidden=YES;
    animation.duration = 0.4;
    [yearly.layer addAnimation:animation forKey:nil];
    btnImage2.hidden=YES;
    btnImage.hidden=NO;
    days=0;
    
}
- (IBAction)daily:(id)sender {
  [daysOptions setTitle:@"    Daily" forState:normal];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    daily.hidden=YES;
    animation.duration = 0.8;
    [daily.layer addAnimation:animation forKey:nil];
    weekly.hidden=YES;
    animation.duration = 0.6;
    [weekly.layer addAnimation:animation forKey:nil];
    yearly.hidden=YES;
    animation.duration = 0.4;
    [yearly.layer addAnimation:animation forKey:nil];
    btnImage2.hidden=YES;
    btnImage.hidden=NO;
    days=0;
   
    
}
- (IBAction)daysOptions:(id)sender {
    btnImage.hidden=YES;
    btnImage2.hidden=NO;
    
    if(days==0)
    {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    daily.hidden=NO;
    animation.duration = 0.4;
    [daily.layer addAnimation:animation forKey:nil];
    weekly.hidden=NO;
    animation.duration = 0.6;
    [weekly.layer addAnimation:animation forKey:nil];
    yearly.hidden=NO;
    animation.duration = 0.8;
    [yearly.layer addAnimation:animation forKey:nil];
        days++;
    }
    else
    {
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        daily.hidden=YES;
        animation.duration = 0.8;
        [daily.layer addAnimation:animation forKey:nil];
        weekly.hidden=YES;
        animation.duration = 0.6;
        [weekly.layer addAnimation:animation forKey:nil];
        yearly.hidden=YES;
        animation.duration = 0.4;
        [yearly.layer addAnimation:animation forKey:nil];
        days=0;
        btnImage2.hidden=YES;
        btnImage.hidden=NO;

    }
    
    
}
@end
