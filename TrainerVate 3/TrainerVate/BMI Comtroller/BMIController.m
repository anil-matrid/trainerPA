//
//  BMIController.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "BMIController.h"
#import "Constants.h"
@interface BMIController ()


@end

@implementation BMIController
@synthesize bmiBmr,bmiBoneMass,bmiPhysicalRating,bmiTotalWeight,bmiVisceralFat;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"BMIController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BMIController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"BMI Controller"];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    //implimenting navigation bar
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;

    bmiBoneMass.text =[[SingletonClass singleton].bmiStats objectForKey:@"mass"];
    bmiTotalWeight.text =[[SingletonClass singleton].bmiStats objectForKey:@"weight"];
    bmiPhysicalRating.text =[[SingletonClass singleton].bmiStats objectForKey:@"physical_rating"];
    bmiBmr.text =[[SingletonClass singleton].bmiStats objectForKey:@"bmr"];
    bmiVisceralFat.text =[[SingletonClass singleton].bmiStats objectForKey:@"visceral_fat"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
 [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)skip:(id)sender {
    [self.view endEditing:YES];
    SMController *addBm=[[SMController alloc]initWithNibName:@"SMController" bundle:nil];
    [self.navigationController pushViewController:addBm animated:YES];
}
int sm1,sm2,sm3,sm4,sm5;
//adding & sending data. Implimenting validations on all text feilds 
- (IBAction)next:(id)sender {
    
    
   

    if (![bmiPhysicalRating.text isEqualToString:@""]) {
        int sms1 = [bmiPhysicalRating.text floatValue];
        if (sms1>100) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Physical Rating should be less then 100";
            sm2=0;
            return;
        }
        [[SingletonClass singleton].bmiStats setValue:[bmiPhysicalRating.text mutableCopy] forKey:@"physical_rating"];
        sm2++;
    
    }
    if (![bmiBoneMass.text isEqualToString:@""]) {
        int sms3 = [bmiBoneMass.text floatValue];
        if (sms3>99) {
            [self.view endEditing:YES];
            _viewError.hidden=NO;
            _viewBlured.hidden=NO;
            _lblMessages.text=@"Bone Mass should be less then 100 ";
            sm3=0;
            return;
        }
        [[SingletonClass singleton].bmiStats setValue:[bmiBoneMass.text mutableCopy] forKey:@"mass"];
        sm3++;
    }
    if (![bmiBmr.text isEqualToString:@""]) {
        int sms4 = [bmiBmr.text floatValue];
        if (sms4>4000) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"BMR should be less then 4000";
            sm4=0;
            return;
        }
        [[SingletonClass singleton].bmiStats setValue:[bmiBmr.text mutableCopy] forKey:@"bmr"];
        sm4++;
    }
    if (![bmiVisceralFat.text isEqualToString:@""]) {
        int sms5 = [bmiVisceralFat.text floatValue];
        if (sms5>50) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"VisceralFat should be less then 50.00 lbs!";
            sm5=0;
            return;
        }
        [[SingletonClass singleton].bmiStats setValue:[bmiBmr.text mutableCopy] forKey:@"bmr"];
        sm5++;
    }
  
    if (![bmiVisceralFat.text isEqualToString:@""]) {
    [[SingletonClass singleton].bmiStats setValue:[bmiVisceralFat.text mutableCopy] forKey:@"visceral_fat"];
    }
  [self.view endEditing:YES];
    SMController *addBm=[[SMController alloc]init];
    [self.navigationController pushViewController:addBm animated:YES];
    
}
#pragma mark- textfild delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    
    NSString *newString;
    
    @try {
        newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
    }
    
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;
    
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 6;
    
    
}

- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}



- (IBAction)btnOk:(id)sender {
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
   
}
-(void)setScrollviewOffset1
{
    
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,385);
    }
    else
    {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 472);
    }
    
    
    
}
- (void)keyboardDidShow: (NSNotification *) notif{
    [self setScrollviewOffset1];
    
    _scorllViews.scrollEnabled = YES;
    
}


- (void)keyboardDidHide: (NSNotification *) notif{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    _scorllViews.scrollEnabled = NO;
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}



@end
