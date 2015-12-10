//
//  ChangeEmailGetCode.m
//  TrainerVate
//
//  Created by Matrid on 12/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ChangeEmailGetCode.h"
#import "Constants.h"

@interface ChangeEmailGetCode () {
    BOOL flagEmail;
}

@end

@implementation ChangeEmailGetCode

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"ChangeEmailGetCode_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"ChangeEmailGetCode" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"ChangeEmailGetCode_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Change Email Get Code"];
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewWillAppear:(BOOL)animated {
    _emailBg.layer.cornerRadius=_emailBg.bounds.size.height/2;
    _emailNewBg.layer.cornerRadius=_emailNewBg.bounds.size.height/2;
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    flagEmail=NO;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
    NSString *email=[[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    email=[email stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([_email.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter email address!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if (![Globals validateEmailWithString:email]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter a valid email address!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    
    if (![_email.text isEqualToString:email]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Your Current Email is incorrect!";
        return;
        
    }
    if ([_emailNew.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter email address!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    NSString *emailNew=[_emailNew.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![Globals validateEmailWithString:emailNew]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Please enter valid email address!";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if ([_email.text isEqualToString:_emailNew.text]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMesage.text=@"Current Email and New Email cannot be same!";
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
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[email lowercaseString],@"old_email",[emailNew lowercaseString],@"new_email",nil];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"SendConfCode/" apiKey:[Globals apiKey]];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESSFULL"]) {
                [self.view endEditing:NO];
                flagEmail=YES;
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblError.hidden=YES;
                _lblToHide.hidden=YES;
                 _lblMesage.text=@"Verification code has been sent to your mail addresses.";
            }
            else{
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblMesage.text=[json objectForKey:@"message"];
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
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    
    if (flagEmail==YES) {
        _lblToHide.hidden=NO;
        _lblError.hidden=NO;
        changeEmail *change=[[changeEmail alloc]init];
        change.Current = _email.text;
        change.latest = _emailNew.text;
        [self.navigationController pushViewController:change animated:YES];
    }
    
}
@end
