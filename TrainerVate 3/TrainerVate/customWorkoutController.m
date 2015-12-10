//
//  customWorkoutController.m
//  My Client- Workout
//
//  Created by Matrid on 31/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "customWorkoutController.h"
#import "ResultController.h"
#import "ResultControllerCustomCell.h"
#import "SingletonClass.h"
#import "WorkoutName2.h"
#import "Constants.h"


@interface customWorkoutController () {
    BOOL saved;
}

@end

@implementation customWorkoutController
@synthesize textField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"MyClientController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"customWorkoutController" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"customWorkoutController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Custom Workout Controller"];
     _viewTextBg.layer.cornerRadius=_viewTextBg.bounds.size.height/2;
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [textField becomeFirstResponder];
    saved=NO;
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
    _lblError.hidden=NO;
    _lblToHide.hidden=NO;
    
// CHANGING LAYOUT ACCORDING TO THE PREVIOUS PAGE CALLED..
    
//    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
//    if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"customWorkoutController2"]){
//        textlabel.hidden=YES;
//    }
}

// ACTIONS FOR THE BUTTONS.

- (IBAction)nextbtn:(id)sender {
    
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [textField.text stringByTrimmingCharactersInSet:charSet];
    textField.text = trimmedString;
    if ([trimmedString isEqualToString:@""]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        [self.view endEditing:YES];
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        _lblMessage.text=@"Workout Name must not be empty.";
        return;
    }
    [[SingletonClass singleton].clientDat setObject:textField.text forKey:@"WorkoutName"];
    WorkoutName2 *lol =[[WorkoutName2 alloc]init];
    [self.navigationController pushViewController:lol animated:YES];
    
}

- (IBAction)backbtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)menubtn:(id)sender {
}
- (IBAction)ok:(id)sender {
    if (saved==YES) {
         WorkoutName2 *tempg=[[WorkoutName2 alloc]init];
        [self.navigationController pushViewController:tempg animated:YES];
        
    }
    else {
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
    }
}
@end
