//
//  Exercise Name.m
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ExerciseName.h"
#import "WorkoutName2.h"
#import "AFNetworking.h"
#import "workoutController.h"
#import "SearchExerciseController.h"
#import "WorkoutName.h"
#import "Constants.h"

@interface ExerciseName (){
    NSDictionary *mdict;
}

@end

@implementation ExerciseName
@synthesize addbtn,removebtn,savebtn,blurredView,errorView,webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Exercise Name"];
    blurredView.hidden=YES;
    _view2.hidden=YES;
    //ALLOCATE DICTIONARY.
    mdict = [[NSDictionary alloc]init];
    _yes.layer.cornerRadius=_yes.bounds.size.height/2;
    _no.layer.cornerRadius=_no.bounds.size.height/2;
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,830);
    }
    else {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 745);
    }
    [[self.lblInstruction layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.lblInstruction layer] setBorderWidth:1];
    [[self.lblInstruction layer] setCornerRadius:15];
    [[self.txtViewDetail layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.txtViewDetail layer] setBorderWidth:1];
    [[self.txtViewDetail layer] setCornerRadius:15];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

    NSString *videoURLString = [[SingletonClass singleton].selectedWorkout valueForKey:@"media_url"];
    NSURL *videoURL = [NSURL URLWithString:videoURLString];
    NSURLRequest* requestUrl = [[NSURLRequest alloc] initWithURL:videoURL];
    webView.scrollView.scrollEnabled = FALSE;
    [webView loadRequest:requestUrl];
//    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityView.center = CGPointMake(320/2, 132/2);
//    [activityView startAnimating];
//    activityView.color=[UIColor whiteColor];
//    activityView.tag = 100;
//    [webView addSubview:activityView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view viewWithTag:100].hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

// CHANGING THE LAYOUT OF THIS PAGE WITH ACCORDANCE TO THE VIEW THIS PAGE IS CALLED.
-(void)viewWillAppear:(BOOL)animated{

    errorView.hidden=YES;
    blurredView.hidden=YES;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
        [_txtViewDetail setUserInteractionEnabled:NO];
        [_lblInstruction setUserInteractionEnabled:NO];
        _img1.hidden=YES;
        _img2.hidden=YES;

        [_txtfield1 setEnabled:NO];
        [_textfield2 setEnabled:NO];
        [_textfield3 setEnabled:NO];
        [_txtReps setEnabled:NO];
        [_txtViewDetail endEditing:NO];
        [_lblInstruction endEditing:NO];
    }
    else{
        _viewToHide.hidden=YES;
    }

    _lblExerciseName.text= [[SingletonClass singleton].selectedWorkout valueForKey:@"exercise_name"];
    _txtfield1.text = [[SingletonClass singleton].selectedWorkout valueForKey:@"exercise_time"];
    _textfield2.text = [[SingletonClass singleton].selectedWorkout valueForKey:@"weights"];
    _textfield3.text = [[SingletonClass singleton].selectedWorkout valueForKey:@"speed"];
    _txtReps.text = [[SingletonClass singleton].selectedWorkout valueForKey:@"reps"];
    _lblInstruction.text = [[SingletonClass singleton].selectedWorkout valueForKey:@"instruction"];
    _txtViewDetail.text = [[SingletonClass singleton].selectedWorkout valueForKey:@"detail"];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"WorkoutName"]){
        addbtn.hidden=YES;
        savebtn.hidden=NO;
        removebtn.hidden=NO;
    }
    else if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"WorkoutName2"]){
        addbtn.hidden=YES;
        savebtn.hidden=NO;
        removebtn.hidden=NO;
    }
    else if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"SearchExerciseController"]){
        addbtn.hidden=NO;
        savebtn.hidden=YES;
        removebtn.hidden=YES;
        
    }
    else if ([NSStringFromClass([viewContrlls class]) isEqualToString:@"ResultController"]){
        addbtn.hidden=NO;
        savebtn.hidden=YES;
        removebtn.hidden=YES;
        
    }
    
}


// ENDS..




- (IBAction)addbtn:(id)sender {
    if ([_txtfield1.text floatValue]>120 ) {
        _view2.hidden=NO;
        blurredView.hidden=NO;
        return;
    }
    if ([_textfield2.text floatValue]>2840) {
        _view2.hidden=NO;
        _view2Lbl.text=@"Weight must be less than 2840 kg.";
        blurredView.hidden=NO;
        return;
    }
        if ([_textfield3.text floatValue]>50) {
        _view2.hidden=NO;
        _view2Lbl.text=@"Speed must be less than 50.";
        blurredView.hidden=NO;
        return;
    }
    if ([_txtReps.text floatValue]>100) {
        _view2.hidden=NO;
        _view2Lbl.text=@"Reps must be less than 100.";
        blurredView.hidden=NO;
        return;
    }

    //ADDING SELECTED EXERCISE VALUES TO DICTIONARY
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtfield1.text,@"exercise_time",_textfield2.text,@"weights",_textfield3.text,@"speed",_txtReps.text,@"reps",[[SingletonClass singleton].selectedWorkout valueForKey:@"workout_exc_id"],@"workout_exc_id",[[SingletonClass singleton].selectedWorkout valueForKey:@"exercise_name"],@"exercise_name",_txtViewDetail.text,@"detail",_lblInstruction.text,@"instruction",nil];
    
    //COPY DICTIONARY VALUES TO SINGLTON ARRAY
    [SingletonClass singleton].selectedWorkout=[inputDic mutableCopy];
    
    //CHECKING THE EXISTING NIBS IN ARRAY TO POP VIEW TO TAHT VIEW FROM WHERE WE CAME
    
    
    
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        
        //This if condition checks whether the viewController's class is MyGroupViewController
        // if true that means its the MyGroupViewController (which has been pushed at some point)
        if ([viewController isKindOfClass:[WorkoutName2 class]] ) {
            
            // Here viewController is a reference of UIViewController base class of MyGroupViewController
            // but viewController holds MyGroupViewController  object so we can type cast it here
            WorkoutName2 *tom = (WorkoutName2*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            
            
        }
        else   if ([viewController isKindOfClass:[WorkoutName class]] ) {
            
            // Here viewController is a reference of UIViewController base class of MyGroupViewController
            // but viewController holds MyGroupViewController  object so we can type cast it here
            WorkoutName *poi = (WorkoutName*)viewController;
            [self.navigationController popToViewController:poi animated:YES];
        }
    }
    
}



- (IBAction)removebtn:(id)sender {
    errorView.hidden=NO;
    blurredView.hidden=NO;
}

- (IBAction)backbtn:(id)sender {
    [SingletonClass singleton].selectedWorkout=nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)yesBtn:(id)sender {
    [SingletonClass singleton].workoutRemove=[[SingletonClass singleton].selectedWorkout valueForKey:@"workout_exc_id"];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)noBtn:(id)sender {
    errorView.hidden=YES;
    blurredView.hidden=YES;
}



- (IBAction)okBtn2:(id)sender {
    _view2.hidden=YES;
    blurredView.hidden=YES;
}
@end
