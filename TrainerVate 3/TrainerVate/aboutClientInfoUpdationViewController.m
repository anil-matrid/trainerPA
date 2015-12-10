//
//  aboutClientInfoUpdationViewController.m
//  TrainerVate
//
//  Created by Matrid on 25/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "aboutClientInfoUpdationViewController.h"
#import "Constants.h"

@interface aboutClientInfoUpdationViewController () {
    NSMutableDictionary *clientData;
    NSString *genders;
}

@end

@implementation aboutClientInfoUpdationViewController
@synthesize basicInfo;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"aboutClientInfoUpdationViewController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"aboutClientInfoUpdationViewController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"aboutClientInfoUpdationViewController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
     //[self setScrollviewOffset];
    clientData = [[NSMutableDictionary alloc]init];
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"About Client Info Updation Controller"];
    // Do any additional setup after loading the view from its nib.
    _male.layer.cornerRadius=_male.bounds.size.height/2;
    _female.layer.cornerRadius=_female.bounds.size.height/2;
    _nameBg.layer.cornerRadius=_nameBg.bounds.size.height/2;
    _ageBg.layer.cornerRadius=_ageBg.bounds.size.height/2;
    _heightBg.layer.cornerRadius=_heightBg.bounds.size.height/2;
    _weightBg.layer.cornerRadius=_weightBg.bounds.size.height/2;
    
    [[self.txtInjuries layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.txtInjuries layer] setBorderWidth:1];
    [[self.txtInjuries layer] setCornerRadius:15];
    
    [[self.txtCando layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.txtCando layer] setBorderWidth:1];
    [[self.txtCando layer] setCornerRadius:15];
    
    [[self.txtcantdo layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.txtcantdo layer] setBorderWidth:1];
    [[self.txtcantdo layer] setCornerRadius:15];
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,1050);
    }
    else {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 1100);
    }

}

- (void)viewWillAppear:(BOOL)animated {
    
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    
    [clientData setObject:@"0" forKey:@"g_weight"];
    [clientData setObject:@"0" forKey:@"g_strengthen"];
    [clientData setObject:@"0" forKey:@"g_upperbody"];
    [clientData setObject:@"0" forKey:@"g_lowerbody"];
    [clientData setObject:@"0" forKey:@"g_buildmuscles"];
    [clientData setObject:@"0" forKey:@"g_tonemuscles"];
    [clientData setObject:@"0" forKey:@"g_endurance"];
    [clientData setObject:@"0" forKey:@"g_flexibility"];
   
    if (![[basicInfo objectForKey:@"can_do"] isEqualToString:@"0"]) {
        _txtCando.text=[basicInfo objectForKey:@"can_do"];
    }
    if (![[basicInfo objectForKey:@"cannot_do"] isEqualToString:@"0"]) {
        _txtcantdo.text=[basicInfo objectForKey:@"cannot_do"];
    }
    if (![[basicInfo objectForKey:@"injuries"] isEqualToString:@"0"]) {
         _txtInjuries.text=[basicInfo objectForKey:@"injuries"];
    }
    
    _name.text=[basicInfo objectForKey:@"name"];
    _age.text=[basicInfo objectForKey:@"age"];
    _height.text=[basicInfo objectForKey:@"height"];
    _weight.text=[basicInfo objectForKey:@"weight"];
    
    if ([[basicInfo objectForKey:@"g_weight"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_weight"];
        [_weights setBackgroundColor:[UIColor clearColor]];
        [_weights setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_strengthen"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_strengthen"];
        [_strength setBackgroundColor:[UIColor clearColor]];
        [_strength setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_upperbody"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_upperbody"];
        [_upperBody setBackgroundColor:[UIColor clearColor]];
        [_upperBody setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_lowerbody"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_lowerbody"];
        [_lowerBody setBackgroundColor:[UIColor clearColor]];
        [_lowerBody setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_buildmuscles"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_buildmuscles"];
        [_build setBackgroundColor:[UIColor clearColor]];
        [_build setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_tonemuscles"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_tonemuscles"];
        [_tone setBackgroundColor:[UIColor clearColor]];
        [_tone setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_endurance"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_endurance"];
        [_endurance setBackgroundColor:[UIColor clearColor]];
        [_endurance setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"g_flexibility"] isEqualToString:@"1"]) {
        [clientData setObject:@"1" forKey:@"g_flexibility"];
        [_flexibility setBackgroundColor:[UIColor clearColor]];
        [_flexibility setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    }
    if ([[basicInfo objectForKey:@"gender"] isEqualToString:@"m"] || [[basicInfo objectForKey:@"gender"] isEqualToString:@"M"]) {
        [_male setTitleColor:[UIColor whiteColor] forState:normal];
        [_male setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [_male setBackgroundImage:nil forState:normal];
        genders=@"M";
    }
    else{
        [_female setTitleColor:[UIColor whiteColor] forState:normal];
        [_female setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [_female setBackgroundImage:nil forState:normal];
        genders=@"F";
    }
    

}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardDidShow: (NSNotification *) notif {
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,850);
    }
    else
    {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 820);
    }
}

- (void)keyboardDidHide: (NSNotification *) notif {
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,1050);
    }
    else
    {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 1100);
    }
}

#pragma api updation***********************


- (IBAction)sex:(id)sender {
    if ([sender tag ]==100) {
        [_male setTitleColor:[UIColor whiteColor] forState:normal];
        [_male setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [_male setBackgroundImage:nil forState:normal];
        [_female setTitleColor:[UIColor blackColor] forState:normal];
        [_female setBackgroundColor:[UIColor clearColor]];
        [_female setBackgroundImage:[UIImage imageNamed:@"ok1.png"] forState:normal];
        genders=@"M";
    }
    else{
        [_female setTitleColor:[UIColor whiteColor] forState:normal];
        [_female setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [_female setBackgroundImage:nil forState:normal];
        [_male setTitleColor:[UIColor blackColor] forState:normal];
        [_male setBackgroundColor:[UIColor clearColor]];
        [_male setBackgroundImage:[UIImage imageNamed:@"ok1.png"] forState:normal];
        genders=@"F";
    }
}

- (IBAction)goals:(id)sender {
    UIImage *selectedImg=[UIImage imageNamed:@"tick2.png"];
    UIImage *currentImage = [sender imageForState:UIControlStateNormal];
    NSData *data1 = UIImagePNGRepresentation(selectedImg);
    NSData *data2 = UIImagePNGRepresentation(currentImage);
    if([sender tag]==10) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_weight"];
            
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_weight"];
            
        }
    }
    else if([sender tag]==11) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_strengthen"];
            
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_strengthen"];
            
        }
    }
    else if([sender tag]==12) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_upperbody"];
            
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_upperbody"];
        }
    }
    
    else if([sender tag]==13) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_lowerbody"];
            
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_lowerbody"];
        }
    }
    else if([sender tag]==14) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_buildmuscles"];
            
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_buildmuscles"];
        }
    }
    else if([sender tag]==15) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_tonemuscles"];
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_tonemuscles"];
        }
    }
    else if([sender tag]==16) {
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_endurance"];
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_endurance"];
        }
    }
    else if([sender tag]==17){
        if ([data1 isEqual:data2]) {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
            [clientData setObject:@"1" forKey:@"g_flexibility"];
            
        }
        else {
            [sender setBackgroundColor:[UIColor clearColor]];
            [sender setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
            [clientData setObject:@"0" forKey:@"g_flexibility"];
        }
    }

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_name == textField) {
        return YES;
    }
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    if (_txtInjuries==textField) {
        return YES;
    }
    if (_txtCando==textField) {
        return YES;
    }
    if (_txtcantdo==textField) {
        return YES;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;
    
    if(range.length + range.location > textField.text.length) {
        return NO;
    }
    if (_height == textField) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 3;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 4;
}

- (IBAction)upDtae:(id)sender {
    
    if ([_name.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Please enter client's name.";
        return;
    }
    if (![Globals validate:_name.text]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Please enter valid name.";
        return;
    }
    if ([_age.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Please enter client's age.";
        return;
    }
    if ([_age.text floatValue] >100) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Age should be less then 100.";
        return;
    }
    if ([_age.text floatValue] <15) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Age should be more then 15.";
        return;
    }
    
    if ([_height.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Please enter height.";
        return;
    }
    if ([_height.text floatValue] >301) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Height should be less then 300 cm.";
        return;
    }
    if ([_height.text floatValue] <101) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Height should be more then 100 cm.";
        return;
    }
    if ([_weight.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Please enter weight.";
        return;
    }
    if ([_weight.text floatValue] >1201) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Weight should be less then 1200 pounds.";
        return;
    }
    if ([_weight.text floatValue] <67) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblMessages.text=@"Weight should be more then 67 pounds.";
        return;
    }
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *itemIds=[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"UpdateClientProfile/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:itemIds,@"uid",[_name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"name",_age.text,@"age",genders,@"gender",_height.text,@"height",_weight.text,@"weight",_txtCando.text,@"can_do",_txtcantdo.text,@"cannot_do",_txtInjuries.text,@"injuries",[clientData objectForKey:@"g_tonemuscles"],@"g_tonemuscles",[clientData objectForKey:@"g_weight"],@"g_weight",[clientData objectForKey:@"g_strengthen"],@"g_strengthen",[clientData objectForKey:@"g_upperbody"],@"g_upperbody",[clientData objectForKey:@"g_lowerbody"],@"g_lowerbody",[clientData objectForKey:@"g_buildmuscles"],@"g_buildmuscles",[clientData objectForKey:@"g_endurance"],@"g_endurance",[clientData objectForKey:@"g_flexibility"],@"g_flexibility",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [hudFirst hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Sorry! Internal Server Error."];
    }];
}

- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
}
@end
