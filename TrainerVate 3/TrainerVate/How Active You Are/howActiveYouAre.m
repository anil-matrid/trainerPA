//
//  howActiveYouAre.m
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "howActiveYouAre.h"
#import "Constants.h"

@interface howActiveYouAre () {
    NSString *checkOption;
    NSMutableData *mutableData;
}

@end

@implementation howActiveYouAre
@synthesize veryActive,iGoThrough,notAtAll;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"howActiveYouAre_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"howActiveYouAre" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"howActiveYouAre_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"How Active You Are"];
    // Do any additional setup after loading the view from its nib.
    veryActive.layer.cornerRadius = 10;
    iGoThrough.layer.cornerRadius = 10;
    notAtAll.layer.cornerRadius = 10;
    [veryActive setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [[SingletonClass singleton].clientInfo setObject:[@"veryActive" mutableCopy] forKey:@"activity"];
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
     NSArray *currentControllers = self.navigationController.viewControllers;
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    if (newControllers.count==8) {
        [self.navigationController popToViewController:[newControllers objectAtIndex:5] animated:YES];
    }
    else if (newControllers.count==7) {
        [self.navigationController popToViewController:[newControllers objectAtIndex:4] animated:YES];
    }
    else{
        [self.navigationController popToViewController:[newControllers objectAtIndex:2] animated:YES];
    }
   
}


- (IBAction)next:(id)sender {
  
    fitnessGoals *fit =[[fitnessGoals alloc]init];
    [self.navigationController pushViewController:fit animated:YES];
    
}

- (IBAction)btnActive:(id)sender {
    if ([sender tag]==10) {
        [veryActive setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [iGoThrough setBackgroundColor:[UIColor colorWithRed:149/255.0 green:169/255.0 blue:177/255.0 alpha:1.0]];
        [notAtAll setBackgroundColor:[UIColor colorWithRed:149/255.0 green:169/255.0 blue:177/255.0 alpha:1.0]];
        
        checkOption=[veryActive titleForState:normal];
        [[SingletonClass singleton].clientInfo setObject:[checkOption mutableCopy]forKey:@"activity"];
    }
    else if([sender tag]==11) {
        [iGoThrough setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [veryActive setBackgroundColor:[UIColor colorWithRed:149/255.0 green:169/255.0 blue:177/255.0 alpha:1.0]];
        [notAtAll setBackgroundColor:[UIColor colorWithRed:149/255.0 green:169/255.0 blue:177/255.0 alpha:1.0]];
        checkOption=[iGoThrough titleForState:normal];
        [[SingletonClass singleton].clientInfo setObject:[checkOption mutableCopy] forKey:@"activity"];
    }
    else {
        [veryActive setBackgroundColor:[UIColor colorWithRed:149/255.0 green:169/255.0 blue:177/255.0 alpha:1.0]];
        [notAtAll setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [iGoThrough setBackgroundColor:[UIColor colorWithRed:149/255.0 green:169/255.0 blue:177/255.0 alpha:1.0]];
        
        checkOption=[notAtAll titleForState:normal];
        [[SingletonClass singleton].clientInfo setObject:[checkOption mutableCopy] forKey:@"activity"];
    }
    
}
@end
