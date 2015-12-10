//
//  Client'sInformationController.m
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ClientsInformationController.h"
#import "Constants.h"

@interface ClientsInformationController () {
    NSMutableDictionary *clientData;
    NSString *genders;
    NSMutableArray *ageArray;
    NSString *ages;
    NSMutableData *mutableData;
    NSString *error;
}


@end

@implementation ClientsInformationController
@synthesize clientEmail,clientName,sdk2,sdk,age,male,feMale;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"ClientsInformationController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"ClientsInformationController" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"ClientsInformationController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Clients Informatiion Controller"];
    // setting buttons outlet................
    _btnOkIfSucces.hidden=YES;
    sdk.layer.cornerRadius=10;
    sdk2.layer.cornerRadius=10;
    _age1.layer.cornerRadius=10;
    male.layer.cornerRadius = male.bounds.size.width / 2.0;
    male.layer.cornerRadius = male.bounds.size.height/ 2.0;
    feMale.layer.cornerRadius = feMale.bounds.size.width / 2.0;
    feMale.layer.cornerRadius = feMale.bounds.size.height/ 2.0;
    
    clientData=[[NSMutableDictionary alloc]init];
    genders=nil;
    _done.hidden=YES;
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    _cross.hidden=YES;
    //setting default value for gender button...................
    
    [male setTitleColor:[UIColor whiteColor] forState:normal];
    [male setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [male setBackgroundImage:nil forState:normal];
    [feMale setTitleColor:[UIColor blackColor] forState:normal];
    [feMale setBackgroundColor:[UIColor clearColor]];
    [feMale setBackgroundImage:[UIImage imageNamed:@"ok1.png"] forState:normal];
    genders=@"m";
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Picker View Data Source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [ageArray count];
}


int sexMF=0;

- (IBAction)gender:(id)sender {
    
    NSString *buttonName = [sender titleForState:UIControlStateNormal];
    if ([buttonName isEqualToString: @"M"]) {
        [male setTitleColor:[UIColor whiteColor] forState:normal];
        [male setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [male setBackgroundImage:nil forState:normal];
        [feMale setTitleColor:[UIColor blackColor] forState:normal];
        [feMale setBackgroundColor:[UIColor clearColor]];
        [feMale setBackgroundImage:[UIImage imageNamed:@"ok1.png"] forState:normal];
        genders=@"M";
    }
    else{
        [feMale setTitleColor:[UIColor whiteColor] forState:normal];
        [feMale setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [feMale setBackgroundImage:nil forState:normal];
        [male setTitleColor:[UIColor blackColor] forState:normal];
        [male setBackgroundColor:[UIColor clearColor]];
        [male setBackgroundImage:[UIImage imageNamed:@"ok1.png"] forState:normal];
        genders=@"F";
    }
}


#pragma implimentation*********************************************

- (void)callDataFormServer {
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlCreateUserAccount apiKey:[Globals apiKey]];
    NSString *email=[clientEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[clientName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"name",[email lowercaseString],@"email",age.text,@"age",genders,@"gender",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                _ok.hidden=YES;
                [hudFirst hide:YES];
                _cross.hidden=NO;
                [self.view endEditing:YES];
                _btnOkIfSucces.hidden=NO;
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _hideViewIfSuccess.hidden=YES;
                _lblToHide.hidden=YES;
                _message.frame=CGRectMake(_message.frame.origin.x,53,_message.frame.size.width,_message.frame.size.height);
                _message.text=@"Client registered successfully. Select OK to add further detail of client.";
                [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"itemID"] forKey:@"itemId"];
            }
            else {
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _ok.hidden=NO;
                _message.text=@"Email already exists.";
                mutableData = [_message.text mutableCopy];
                [[SingletonClass singleton].errorMessages setObject:mutableData forKey:@"error"];
            }
        }
        else {
            [hudFirst hide:YES];
            [self.view endEditing:YES];
            _bluredView.hidden=NO;
            _errorView.hidden=NO;
            _message.text=@"Sorry! Internal Server Error.";
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Sorry! Internal Server Error.";
        
    }];
    
}


- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scorllViews.contentInset = contentInsets;
    _scorllViews.scrollIndicatorInsets = contentInsets;
}

- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}
- (IBAction)done:(id)sender {
    
    _done.hidden=YES;
}

- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    _done.hidden=YES;
    if ([error isEqualToString:@"Please enter name."]) {
        [clientName becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Please enter name."]) {
        [clientName becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Age should be more than 15."]) {
        [age becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Please enter age."]) {
        [age becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Please enter valid name."]) {
        [clientName becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Please enter valid email address."]) {
        [clientEmail becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Please enter email address."]) {
        [clientEmail becomeFirstResponder];
        return;
    }
    if ([error isEqualToString:@"Email already exists."]) {
        [clientEmail becomeFirstResponder];
        return;
    }
    
}
- (IBAction)btnOkIfSucces:(id)sender {
    howActiveYouAre *howActive=[[howActiveYouAre alloc]init];
    [self.navigationController pushViewController:howActive animated:YES];
    _btnOkIfSucces.hidden=YES;
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    _hideViewIfSuccess.hidden=NO;
}

- (IBAction)next:(id)sender {
    
    if (![Globals validate:clientName.text]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter valid name.";
        error = _message.text;
       
        return;
    }
    
    if ([clientName.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter Client’s name.";
       error = _message.text;
        return;
        
    }
    
    if([age.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter age..";
       error = _message.text;
        return;
        
    }
    
    if ([age.text floatValue] <15) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Age should be more than 15.";
        error = _message.text;
        return;
    }
    
    if ([clientEmail.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter Email address.";
        error = _message.text;
        return;
        
    }
    
    NSString *email=[clientEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(![Globals validateEmailWithString:email]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter valid email address.";
        mutableData = [_message.text mutableCopy];
       // [[SingletonClass singleton].errorMessages setObject:mutableData forKey:@"error"];
        return;
        
    }
    [self callDataFormServer];
    
}
#pragma mark- textfild delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (clientEmail==textField) {
        return YES;
    }
    if (clientName==textField) {
        return YES;
    }
    
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *expression = @"^([0-9]+)?$";
    
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
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 2;
    
    
}

-(void)setScrollviewOffset1
{
    
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,385);
    }
    else {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 472);
    }
    
    
    
}
- (void)keyboardDidShow: (NSNotification *) notif {
    [self setScrollviewOffset1];
    
    _scorllViews.scrollEnabled = YES;
    
}


- (void)keyboardDidHide: (NSNotification *) notif {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    _scorllViews.scrollEnabled = NO;
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}


- (IBAction)cross:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
