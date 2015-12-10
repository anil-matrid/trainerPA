//
//  RegisterController.m
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "RegisterController.h"
#import "Constants.h"
@interface RegisterController ()
@end

@implementation RegisterController
@synthesize emailId,name,Password,Next,registerationInformation,gymCode;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"RegisterController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"RegisterController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"RegisterController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   [Globals GoogleAnalyticsScreenName:@"Register Controller"];



}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
        _messagesView.hidden=YES;
    _bluredView.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)Next:(id)sender {
    
    // adding validations
    if ([name.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _messagesView.hidden=NO;
        _message.text=@"Please enter your name.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
       
        return;
    }
    if (![Globals validate:name.text]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _messagesView.hidden=NO;
        _message.text=@"Please enter valid name.";
       [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];

        return;
    }
    if ([emailId.text isEqualToString:@""]) {
        [self.view endEditing:YES];
         _bluredView.hidden=NO;
         _messagesView.hidden=NO;
         _message.text=@"Please enter email address.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
     NSString *email=[emailId.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![Globals validateEmailWithString:email]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _messagesView.hidden=NO;
        _message.text=@"Please enter valid email address.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        
        
        return;
    }
    if ([Password.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _messagesView.hidden=NO;
        _message.text=@"Please enter password";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        
        return;
    }
    if (Password.text.length<6) {
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _messagesView.hidden=NO;
        _message.text=@"Password must contain atleast 6 characters!";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        
        return;
    }
    // checking network status
    if (![Globals NetworkStatus]) {
        return;
    }
    
    // adding loading hud in the view
    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombile:kApiDomin ClassUrl:kUrlRegister apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"name",[email lowercaseString],@"email",[Password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"password",@"1",@"trainer",gymCode.text,@"gym_code",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {

            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
               
                
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                _messagesView.hidden=NO;
                _bluredView.hidden=NO;
                _okView.hidden=YES;
                _lblToHide.hidden=YES;
                _errorToHide.hidden=YES;
                _message.text=@"You have been registered successfully.";
                return ;
                
            }
            else {
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                _okView.hidden=NO;
                _messagesView.hidden=NO;
                _bluredView.hidden=NO;
                _message.text=@"Email already exists.";
                [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
                
            }
            
            
    }
         
        [hudFirst hide:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [self.view endEditing:YES];
        _messagesView.hidden=NO;
        _bluredView.hidden=NO;
        _message.text=@"Sorry! Internal Server Error.";
//        [Globals alert:@"Something went wrong. Please try again later"];
    }];
}
- (void)pushWhenLoginSecuss {
    LoginContoller *home=[[LoginContoller alloc]init];
    home.userType=@"1";
    [self.navigationController pushViewController:home animated:YES];
     _lblToHide.hidden=NO;
    _errorToHide.hidden=NO;
    // _errorToHide.frame=CGRectMake(_errorToHide.frame.origin.x,65, _errorToHide.frame.size.width,_errorToHide.frame.size.height);
}
- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}
#pragma mark- alerview delegat4
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==1000) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//lifting keybord up while editing data

- (void)setScrollviewOffset {
    
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,370);
    }
    else
    {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 450);
    }
    
    
    
}
- (void)keyboardDidShow: (NSNotification *) notif {
    [self setScrollviewOffset];
    
    _scorllViews.scrollEnabled = YES;
    
}

- (IBAction)ok1:(id)sender {
    _bluredView.hidden=YES;
    _messagesView.hidden=YES;
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter your name."]) {
        [name becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter valid name."]) {
        [name becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter email address."]) {
        [emailId becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter valid email address."]) {
        [emailId becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter password"]) {
        [Password becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Password length minimum 5 words"]) {
        [Password becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Email already exists."]) {
        [emailId becomeFirstResponder];
        return;
    }
    
}

- (IBAction)ok:(id)sender {
[self.view endEditing:YES];
    [self pushWhenLoginSecuss];
    
}

- (void)keyboardDidHide: (NSNotification *) notif {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    _scorllViews.scrollEnabled = NO;
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    
    if (textField == name) {
        
        if (textField.text.length >= 50 && range.length == 0)
        {
            return NO; // return NO to not change text
        }
        else
        {
            return YES;
        }
    }
    return YES;
   
}
@end
