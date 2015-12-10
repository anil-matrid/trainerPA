//
//  SkinFoldController.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SkinFoldController.h"
#import "Constants.h"
@interface SkinFoldController ()


@end

@implementation SkinFoldController
@synthesize sfPectoral,sfAbdominal,sfThigh,sfTriceps,sfSubscapular,sfSupralic,sfAxila;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"SkinFoldController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"SkinFoldController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [Globals GoogleAnalyticsScreenName:@"Skinfold Controller"];
    // Do any additional setup after loading the view from its nib.
    //implimenting navigation bar
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];

    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    sfPectoral.text=[[SingletonClass singleton].sfStats objectForKey:@"pectoral"];
    sfAbdominal.text=[[SingletonClass singleton].sfStats objectForKey:@"abdominal"];
    sfThigh.text=[[SingletonClass singleton].sfStats objectForKey:@"thigh"];
    sfTriceps.text=[[SingletonClass singleton].sfStats objectForKey:@"tricepts"];
    sfSubscapular.text=[[SingletonClass singleton].sfStats objectForKey:@"subscapular"];
    sfSupralic.text=[[SingletonClass singleton].sfStats objectForKey:@"suprailiac"];
    sfAxila.text= [[SingletonClass singleton].sfStats objectForKey:@"axilla"];
    
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,468);
        
    }
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
    BFController *addBf=[[BFController alloc]init];
    [self.navigationController pushViewController:addBf animated:YES];
                
            }
int sf1,sf2,sf3,sf4,sf5,sf6,sf7;
- (IBAction)next:(id)sender {
    
    
    if (![sfPectoral.text isEqualToString:@""]) {
        int sf1i = [sfPectoral.text floatValue];
        if (sf1i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Pectoral should be less then 50 cm";
            sf1=0;
            return;
        }
        [[SingletonClass singleton].sfStats setValue:[sfPectoral.text mutableCopy] forKey:@"pectoral"];
        sf1++;
    }
    if (![sfAbdominal.text isEqualToString:@""]) {
        int sf1i = [sfAbdominal.text floatValue];
        if (sf1i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Abdominal should be less then 70 cm";
            sf1=0;
            return;
        }
        [[SingletonClass singleton].sfStats setValue:[sfAbdominal.text mutableCopy] forKey:@"abdominal"];
        sf1++;
    }
    if (![sfThigh.text isEqualToString:@""]) {
        int sf2i = [sfThigh.text floatValue];
        if (sf2i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Thigh should be less then 100 cm";
            sf2=0;
            return;
        }
        [[SingletonClass singleton].sfStats setValue:[sfThigh.text mutableCopy] forKey:@"thigh"];
        sf2++;
    }
    if (![sfTriceps.text isEqualToString:@""]) {
        int sf3i = [sfTriceps.text floatValue];
        if (sf3i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Triceps should be less then 55 cm";
            sf3=0;
            return;
        }
        [[SingletonClass singleton].sfStats setValue:[sfTriceps.text mutableCopy] forKey:@"tricepts"];
        sf3++;
    }
  
    if (![sfSubscapular.text isEqualToString:@""]) {
        [[SingletonClass singleton].sfStats setValue:[sfSubscapular.text mutableCopy] forKey:@"subscapular"];
    }
    if (![sfSupralic.text isEqualToString:@""]) {
        [[SingletonClass singleton].sfStats setValue:[sfSupralic.text mutableCopy] forKey:@"suprailiac"];
    }
    if (![sfAxila.text isEqualToString:@""]) {
        [[SingletonClass singleton].sfStats setValue:[sfAxila.text mutableCopy] forKey:@"axilla"];
    }
    [self.view endEditing:YES];
    BFController *addBf=[[BFController alloc]init];
    [self.navigationController pushViewController:addBf animated:YES];
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
    _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,420);
    
   }
}

-(IBAction)btnOk:(id)sender{
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
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
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,468);
        
    }
}


@end
