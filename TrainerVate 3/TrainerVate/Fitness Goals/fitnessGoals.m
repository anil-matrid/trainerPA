//
//  fitnessGoals.m
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "fitnessGoals.h"
#import "Constants.h"


@interface fitnessGoals () {
  
    NSString *strengthen;
    NSString *upperbody;
    NSString *lowerBody;
    NSString *buildmucles;
    NSString *endurance;
    NSString *flexibility;
    NSString *g_tonemuscles;
    NSString *g_weight;

}

@end

@implementation fitnessGoals
@synthesize loseWeight,strengthCore,targetLower,targetUpper,buildMuscle,toneMuscle,improveFlexi,improveIndurance;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"fitnessGoals_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"fitnessGoals" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"fitnessGoals_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Fitness Goals"];
    // Do any additional setup after loading the view from its nib.
    loseWeight.layer.cornerRadius = loseWeight.bounds.size.width / 2.0;
    strengthCore.layer.cornerRadius = strengthCore.bounds.size.width / 2.0;
    targetLower.layer.cornerRadius = targetLower.bounds.size.width / 2.0;
    targetUpper.layer.cornerRadius = targetUpper.bounds.size.width / 2.0;
    buildMuscle.layer.cornerRadius = buildMuscle.bounds.size.width / 2.0;
    toneMuscle.layer.cornerRadius = toneMuscle.bounds.size.width / 2.0;
    improveFlexi.layer.cornerRadius = improveFlexi.bounds.size.width / 2.0;
    improveIndurance.layer.cornerRadius = improveIndurance.bounds.size.width / 2.0;
    
    //setting default values for fitness goal***********************************************
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_weight"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_strengthen"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_upperbody"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_lowerbody"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_buildmuscles"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_tonemuscles"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_endurance"];
    [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_flexibility"];
    
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)goal:(id)sender{
    UIImage *selectedImg=[UIImage imageNamed:@"tick2.png"];
    UIImage *currentImage = [sender imageForState:UIControlStateNormal];
    NSData *data1 = UIImagePNGRepresentation(selectedImg);
    NSData *data2 = UIImagePNGRepresentation(currentImage);
    if([sender tag]==10) {
        if ([data1 isEqual:data2]) {
        [loseWeight setBackgroundColor:[UIColor clearColor]];
        [loseWeight setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_weight"];
        
        }
        else {
        [loseWeight setBackgroundColor:[UIColor clearColor]];
        [loseWeight setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_weight"];
        
        }
    }
    else if([sender tag]==11) {
        if ([data1 isEqual:data2]) {
        [strengthCore setBackgroundColor:[UIColor clearColor]];
        [strengthCore setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_strengthen"];
       
        }
        else {
        [strengthCore setBackgroundColor:[UIColor clearColor]];
        [strengthCore setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_strengthen"];
        
        }
    }
    else if([sender tag]==12) {
        if ([data1 isEqual:data2]) {
        [targetUpper setBackgroundColor:[UIColor clearColor]];
        [targetUpper setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_upperbody"];
       
        }
        else {
        [targetUpper setBackgroundColor:[UIColor clearColor]];
        [targetUpper setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_upperbody"];
        }
        }

    else if([sender tag]==13) {
        if ([data1 isEqual:data2]) {
        [targetLower setBackgroundColor:[UIColor clearColor]];
        [targetLower setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_lowerbody"];
    
        }
        else {
        [targetLower setBackgroundColor:[UIColor clearColor]];
        [targetLower setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_lowerbody"];
        }
        }
    else if([sender tag]==14) {
        if ([data1 isEqual:data2]) {
        [buildMuscle setBackgroundColor:[UIColor clearColor]];
        [buildMuscle setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_buildmuscles"];
     
        }
        else {
        [buildMuscle setBackgroundColor:[UIColor clearColor]];
        [buildMuscle setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_buildmuscles"];
        }
        }
    else if([sender tag]==15) {
        if ([data1 isEqual:data2]) {
        [toneMuscle setBackgroundColor:[UIColor clearColor]];
        [toneMuscle setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_tonemuscles"];
        }
        else {
        [toneMuscle setBackgroundColor:[UIColor clearColor]];
        [toneMuscle setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_tonemuscles"];
        }
        }
    else if([sender tag]==16) {
        if ([data1 isEqual:data2]) {
        [improveIndurance setBackgroundColor:[UIColor clearColor]];
        [improveIndurance setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_endurance"];
        }
        else {
        [improveIndurance setBackgroundColor:[UIColor clearColor]];
        [improveIndurance setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_endurance"];
        }
    }
    else {
        if ([data1 isEqual:data2]) {
        [improveFlexi setBackgroundColor:[UIColor clearColor]];
        [improveFlexi setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"1" forKey:@"g_flexibility"];
        
        }
        else {
        [improveFlexi setBackgroundColor:[UIColor clearColor]];
        [improveFlexi setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
        [[SingletonClass singleton].clientInfo setObject:@"0" forKey:@"g_flexibility"];
        }
    }
}
- (IBAction)next:(id)sender {
    
//    if ([[[SingletonClass singleton].clientInfo objectForKey:@"g_weight"] isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_strengthen"]isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_upperbody"]isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_lowerbody"]isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_buildmuscles"]isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_tonemuscles"]isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_endurance"]isEqualToString:@"0"] &&
//    [[[SingletonClass singleton].clientInfo objectForKey:@"g_flexibility"]isEqualToString:@"0"]){
//        
//        _bluredView.hidden=NO;
//        _errorView.hidden=NO;
//        return;
//    };
    clientsbasicInfo *basicInfo = [[clientsbasicInfo alloc]init];
    [self.navigationController pushViewController:basicInfo animated:YES];
}
- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
}
@end
