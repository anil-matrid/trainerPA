//
//  BasicController.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "BasicController.h"
#import "Constants.h"
@interface BasicController ()
{
    float offset;
}

@end

@implementation BasicController
@synthesize basicArmSize,basicBodyFat,basicChestSize,basicHeight,basicLegSize,basicWaist,basicWater,basicWeight;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        offset=700;
        self = [super initWithNibName:@"BasicController" bundle:nibBundleOrNil];
    }
    else
    {
        offset=100;
        self = [super initWithNibName:@"BasicController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Basic Controller"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,562);
        
    }

}

-(void)viewWillAppear:(BOOL)animated{
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
    
    
    // Setting textFields stored values
    basicHeight.text =[[SingletonClass singleton].basicStats objectForKey:@"height"];
    basicWeight.text =[[SingletonClass singleton].basicStats objectForKey:@"weight"];
    basicWaist.text =[[SingletonClass singleton].basicStats objectForKey:@"waist"];
    basicBodyFat.text =[[SingletonClass singleton].basicStats objectForKey:@"body_fat"];
    basicArmSize.text =[[SingletonClass singleton].basicStats objectForKey:@"arm"];
    basicLegSize.text =[[SingletonClass singleton].basicStats objectForKey:@"leg"];
    basicWater.text = [[SingletonClass singleton].basicStats objectForKey:@"water"];
    basicChestSize.text =[[SingletonClass singleton].basicStats objectForKey:@"chest"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




int basic1,basic2,basic3,basic4,basic5,basic6,basic7,basic8;
- (IBAction)backAddStats:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
  
  
    if (![basicWeight.text isEqualToString:@""]) {
        int value1 = [basicWeight.text floatValue];
        if (value1>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Weight should be less then 1200 lbs";
            basic2=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicWeight.text mutableCopy] forKey:@"weight"];
        basic2++;
        
    }
    
    if (![basicWaist.text isEqualToString:@""]) {
        int value2 = [basicWaist.text floatValue];
        if (value2>150) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Waist size should be less then 150 cm";
            basic7=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicWaist.text mutableCopy] forKey:@"waist"];
        basic7++;
    }
    
    if (![basicBodyFat.text isEqualToString:@""]) {
        int value3 = [basicBodyFat.text floatValue];
        if (value3>100) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Bodyfats should be less then 100%";
            basic3=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicBodyFat.text mutableCopy] forKey:@"body_fat"];
        basic3++;
        
    }
    
    if (![basicArmSize.text isEqualToString:@""]) {
        int value4 = [basicArmSize.text floatValue];
        if (value4>50) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Arm size should be less then 50 cm";
            basic4=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicArmSize.text mutableCopy] forKey:@"arm"];
        basic4++;
    }
    
    if (![basicLegSize.text isEqualToString:@""]) {
        int value5 = [basicLegSize.text floatValue];
        if (value5>150) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Leg size should be less then 150 cm";
            basic5=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicLegSize.text mutableCopy] forKey:@"leg"];
        basic5++;
        
    }
    
    if (![basicWater.text isEqualToString:@""]) {
        int value6 = [basicWater.text floatValue];
        if (value6>100) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Water should be less then 100%";
            basic6=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicWater.text mutableCopy] forKey:@"water"];
        basic6++;
        
    }
    
    if (![basicChestSize.text isEqualToString:@""]) {
        int value7 = [basicChestSize.text floatValue];
        if (value7>150) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Chest size should be less then 150 cm";
            basic8=0;
            return;
        }
        [[SingletonClass singleton].basicStats setValue:[basicChestSize.text mutableCopy] forKey:@"chest"];
        basic8++;
        
    }
   
    [self.view endEditing:YES];
    BMIController *bmi= [[BMIController alloc]init];
    [self.navigationController pushViewController:bmi animated:YES];
   
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
    if (numberOfMatches == 0){
        return NO;
    }
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 6;
    
    
}
- (IBAction)skip:(id)sender {
    [self.view endEditing:YES];
    BMIController *addStat=[[BMIController alloc]initWithNibName:@"BMIController" bundle:nil];
    [self.navigationController pushViewController:addStat animated:YES];
    
}
- (IBAction)txtResign:(id)sender {
    //[sender resignFirstResponder];
    [self.view endEditing:YES];
}

- (IBAction)btnOk:(id)sender {
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
    }
-(void)setScrollviewOffset1
{
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 472);
}
- (void)keyboardDidShow: (NSNotification *) notif{
    if(IS_IPHONE_5_OR_MORE) {
    [self setScrollviewOffset1];
    _scorllViews.scrollEnabled = YES;
    }
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,470);
        
    }
}


- (void)keyboardDidHide: (NSNotification *) notif{
    if(IS_IPHONE_5_OR_MORE) {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _scorllViews.scrollEnabled = NO;
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
    }
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,562);
        
    }
   
}



@end
