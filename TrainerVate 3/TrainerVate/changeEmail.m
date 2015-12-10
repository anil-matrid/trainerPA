//
//  changeEmail.m
//  TrainerVate
//
//  Created by Matrid on 12/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "changeEmail.h"
#import "Constants.h"

@interface changeEmail () {
    BOOL flag;
}

@end

@implementation changeEmail
@synthesize Current,latest;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Change Email"];
    if (IS_IPHONE_4_OR_LESS) {
        _scroll.contentSize=CGSizeMake(320,569);
    }
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewWillAppear:(BOOL)animated {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    flag=NO;
    _emailBg.layer.cornerRadius=_emailBg.bounds.size.height/2;
    _EmailBg1.layer.cornerRadius=_EmailBg1.bounds.size.height/2;
    _currentCodeBg.layer.cornerRadius=_currentCodeBg.bounds.size.height/2;
    _emailNewCodeBg.layer.cornerRadius=_emailNewCodeBg.bounds.size.height/2;
    _passwordBg.layer.cornerRadius=_passwordBg.bounds.size.height/2;
    _email.text=Current;
    _Email1.text=latest;
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submit:(id)sender {
    
    if ([_password.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter Password!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if ([_currentCode.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter code of your current email!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if (![Globals validateEmailWithString:_email.text] || ![Globals validateEmailWithString:_Email1.text]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter valid email address!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if ([_email.text isEqualToString:@""] || [_Email1.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter email address!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if ([_emailNewCode.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter code of your new email!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *clientID;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]){
        clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    }
    else{
        clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"id",_email.text,@"current_email",_Email1.text,@"new_email",_password.text,@"pwd",_currentCode.text,@"current_email_code",_emailNewCode.text,@"new_email_code",nil];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"UpdateMail/" apiKey:[Globals apiKey]];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblMesage.text=@"Email changed successfully!";
                _lblError.text = @"";
                flag=YES;
               
            }
            else{
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblMesage.text=@"Code does not match!";
                
            }
        }
        else {
            [self.view endEditing:YES];
            _bluredView.hidden=NO;
            _errorView.hidden=NO;
            _lblMesage.text=@"Sorry! Internal server error.";
            
        }
       [hudFirst hide:YES]; 
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _errorView.hidden=NO;
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _lblMesage.text=@"Sorry! Internal server error.";
        [hudFirst hide:YES];
        
    }];

}
- (IBAction)ok:(id)sender {
    if (flag==YES) {
        NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
        NSDictionary * dict = [defs dictionaryRepresentation];
        for (id key in dict) {
            [defs removeObjectForKey:key];
        }
        [defs synchronize];
        [AppDelegate generateTheAPiKey];
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    
}
@end
