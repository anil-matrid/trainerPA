//
//  SMController.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SMController.h"
#import "Constants.h"
@interface SMController ()


@end

@implementation SMController
@synthesize smArmL,smArmR,smLegL,smLegR,smTrunk;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"SMController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"SMController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"SM Controller"];
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
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    smArmR.text=[[SingletonClass singleton].smStats objectForKey:@"arm_r"];
    smArmL.text=[[SingletonClass singleton].smStats objectForKey:@"arm_l"];
    smLegR.text=[[SingletonClass singleton].smStats objectForKey:@"leg_r"];
    smLegL.text=[[SingletonClass singleton].smStats objectForKey:@"leg_l"];
    smTrunk.text=[[SingletonClass singleton].smStats objectForKey:@"trunk"];
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
    SkinFoldController *addSf=[[SkinFoldController alloc]init];
    [self.navigationController pushViewController:addSf animated:YES];
                
    



}
int bmi1,bmi2,bmi3,bmi4,bmi5;
- (IBAction)next:(id)sender {
    
    if (![smArmR.text isEqualToString:@""]) {
        int bmi1i = [smArmR.text floatValue];
        if (bmi1i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Arm size should be less then 50 cm";
            bmi1=0;
            return;
        }
        [[SingletonClass singleton].smStats setValue:[smArmR.text mutableCopy] forKey:@"arm_r"];
        bmi1++;
    }
    
    if (![smArmL.text isEqualToString:@""]) {
        int bmi2i = [smArmL.text floatValue];
        if (bmi2i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Arm size should be less then 50 cm";
            bmi2=0;
            return;
        }
        [[SingletonClass singleton].smStats setValue:[smArmL.text mutableCopy] forKey:@"arm_l"];
        bmi2++;
    }
    if (![smTrunk.text isEqualToString:@""]) {
        int bmi3i = [smTrunk.text floatValue];
        if (bmi3i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"trunk should be less then 150 cm";
            bmi3=0;
            return;
        }
        [[SingletonClass singleton].smStats setValue:[smTrunk.text mutableCopy] forKey:@"trunk"];
        
        bmi3++;
    }
    if (![smLegR.text isEqualToString:@""]) {
        int bmi4i = [smLegR.text floatValue];
        if (bmi4i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Leg size should be less then 150 cm";
            bmi4=0;
            return;
        }
        [[SingletonClass singleton].smStats setValue:[smLegR.text mutableCopy] forKey:@"leg_r"];
        bmi4++;
    }
    if (![smLegL.text isEqualToString:@""]) {
        int bmi5i = [smLegL.text floatValue];
        if (bmi5i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Leg size should be less then 150 cm";
            bmi5=0;
            return;
        }
        [[SingletonClass singleton].smStats setValue:[smLegL.text mutableCopy] forKey:@"leg_l"];
        bmi5++;
    }
    
    [self.view endEditing:YES];
    SkinFoldController *addSf=[[SkinFoldController alloc]init];
    [self.navigationController pushViewController:addSf animated:YES];
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

-(IBAction)btnOk:(id)sender{
    _viewError.hidden=YES;
    _viewBlured.hidden=YES;
}
- (void)keyboardDidHide: (NSNotification *) notif{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    _scorllViews.scrollEnabled = NO;
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}


@end
