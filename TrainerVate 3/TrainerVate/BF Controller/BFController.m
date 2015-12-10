//
//  BFController.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "BFController.h"
#import "Constants.h"

@interface BFController (){
    MBProgressHUD *  hudFirst;
}


@end

@implementation BFController
@synthesize bfArmL,bfArmR,bfLegL,bfLegR;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"BFController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"BFController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"BF Controller"];
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
    
    _viewError.hidden=YES;
    _viewBlured.hidden=YES;
    _okIfSuccess.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    bfArmL.text=[[SingletonClass singleton].bfStats objectForKey:@"bfArmL"];
    bfArmR.text=[[SingletonClass singleton].bfStats objectForKey:@"bfArmR"];
    bfLegL.text=[[SingletonClass singleton].bfStats objectForKey:@"bfLegL"];
    bfLegR.text=[[SingletonClass singleton].bfStats objectForKey:@"bfLegR"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}


- (IBAction)back:(id)sender {
    [[SingletonClass singleton].bfStats setValue:[bfArmL.text mutableCopy] forKey:@"bfArmL"];
    [[SingletonClass singleton].bfStats setValue:[bfArmR.text mutableCopy] forKey:@"bfArmR"];
    [[SingletonClass singleton].bfStats setValue:[bfLegL.text mutableCopy] forKey:@"bfLegL"];
    [[SingletonClass singleton].bfStats setValue:[bfLegR.text mutableCopy] forKey:@"bfLegR"];
   [self.navigationController popViewControllerAnimated:YES];
}


int bf1,bf2,bf3,bf4;
-(IBAction)btnOk:(id)sender{
    _viewBlured.hidden=YES;
    _viewError.hidden=YES;
}
- (IBAction)next:(id)sender {    
    

    
    if (![bfArmR.text isEqualToString:@""]) {
        int bf1i = [bfArmR.text floatValue];
        if (bf1i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Arm size should be less then 50 cm";
            bf1=0;
            return;
        }
        bf1++;
    }
    if (![bfArmL.text isEqualToString:@""]) {
        int bf2i = [bfArmL.text floatValue];
        if (bf2i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Arm size should be less then 50 cm";
            bf2=0;
            return;
        }
        bf2++;
    }
   
    if (![bfLegR.text isEqualToString:@""]) {
        int bf3i = [bfLegR.text floatValue];
        if (bf3i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Leg size should be less then 150 cm";
            bf3=0;
            return;
        }
        bf3++;
    }
    if (![bfLegL.text isEqualToString:@""]) {
        int bf4i = [bfLegL.text floatValue];
        if (bf4i>1200) {
            [self.view endEditing:YES];
            _viewBlured.hidden=NO;
            _viewError.hidden=NO;
            _lblMessages.text=@"Leg size should be less then 150 cm";
            bf4=0;
            return;
        }
        bf4++;
    }
    [NSThread detachNewThreadSelector:@selector(callDataFormServer) toTarget:self withObject:nil];

    
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
-(void)callDataFormServer
{
    NSString *trainerID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *uid=[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];

    
    NSMutableDictionary *inputDic4=[[NSMutableDictionary alloc]init];
    
    if (![bfArmR.text isEqualToString:@""]) {
        [inputDic4  setObject:bfArmR.text forKey:@"arm_r"];
    }
    if (![bfArmL.text isEqualToString:@""]) {
        [inputDic4  setObject:bfArmL.text forKey:@"arm_l"];
    }
    if (![bfLegR.text isEqualToString:@""]) {
        [inputDic4  setObject:bfLegR.text forKey:@"leg_r"];
    }
    if (![bfLegL.text isEqualToString:@""]) {
        [inputDic4  setObject:bfLegL.text forKey:@"leg_l"];
    }
    
    NSMutableDictionary *data1=[[NSMutableDictionary alloc]init];
    if ([SingletonClass singleton].basicStats.count!=0) {
        [[SingletonClass singleton].basicStats setObject:uid forKey:@"uid"];
        [[SingletonClass singleton].basicStats setObject:trainerID forKey:@"trainer_id"];
        [data1 setObject:[SingletonClass singleton].basicStats forKey:@"client_body_basic"];
    }
    if ([SingletonClass singleton].bmiStats.count!=0) {
        [[SingletonClass singleton].bmiStats setObject:uid forKey:@"uid"];
        [[SingletonClass singleton].bmiStats setObject:trainerID forKey:@"trainer_id"];
        [data1 setObject:[SingletonClass singleton].bmiStats forKey:@"client_body_bmi"];
    }
    if ([SingletonClass singleton].smStats.count!=0) {
        [[SingletonClass singleton].smStats setObject:uid forKey:@"uid"];
        [[SingletonClass singleton].smStats setObject:trainerID forKey:@"trainer_id"];
        [data1 setObject:[SingletonClass singleton].smStats forKey:@"client_body_sm"];
    }
    if ([SingletonClass singleton].sfStats.count!=0) {
        [[SingletonClass singleton].sfStats setObject:uid forKey:@"uid"];
        [[SingletonClass singleton].sfStats setObject:trainerID forKey:@"trainer_id"];
        [data1 setObject:[SingletonClass singleton].sfStats forKey:@"client_body_skinfold"];
    }
    if (inputDic4.count!=0) {
        [inputDic4 setObject:uid forKey:@"uid"];
        [inputDic4 setObject:trainerID forKey:@"trainer_id"];
        [data1 setObject:inputDic4 forKey:@"client_body_bf"];
    }
    if (data1.count==0) {
        _viewBlured.hidden=NO;
        _viewError.hidden=NO;
        _lblMessages.text=@"Information must contain atleast one value!";
        return;
    }
//    [data1 addObject:inputDic];
//    [data1 addObject:inputDic1];
//    [data1 addObject:inputDic2];
//    [data1 addObject:inputDic3];
//    [data1 addObject:inputDic4];
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data1
                        
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonValue = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *inputDic5=[NSDictionary dictionaryWithObjectsAndKeys:jsonValue,@"data",nil];
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"AddStatisticsRecord/" apiKey:[Globals apiKey]];
  //  NSString* result = [_txtBundleName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic5 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                [self.view endEditing:YES];
               
                _viewBlured.hidden=NO;
                _viewError.hidden=NO;
                _okIfSuccess.hidden=NO;
                _lblError.hidden=YES;
                _lblToHide.hidden=YES;
                _ok.hidden=YES;
                _lblMessages.frame=CGRectMake(_lblMessages.frame.origin.x,53,_lblMessages.frame.size.width,_lblMessages.frame.size.height);
                _lblMessages.text=@"Body Stats have been submitted to your device.";
                
            }
            else{
                [hudFirst hide:YES];                [self.view endEditing:YES];
                _viewBlured.hidden=NO;
                _viewError.hidden=NO;
                _lblMessages.text=[json objectForKey:@"message"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view endEditing:YES];
        [hudFirst hide:YES];
        _viewBlured.hidden=NO;
        _viewError.hidden=NO;
        _lblMessages.text=@"Sorry! Internal Server Error.";
    }];
    
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


- (IBAction)okIfSuccess:(id)sender {
    _viewError.hidden=YES;
    _viewBlured.hidden=YES;
    _okIfSuccess.hidden=YES;
    _ok.hidden=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
      
        if ([viewController isKindOfClass:[MyStats class]] ) {
         
            MyStats *tom = (MyStats*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            
            
        }
    }
}
@end
