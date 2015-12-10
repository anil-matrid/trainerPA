//
//  forgetPassword.m
//  TrainerVate
//
//  Created by Matrid on 12/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "forgetPassword.h"
#import "forgotPasswordConfirmaion.h"
#import "Constants.h"

@interface forgetPassword ()

@end

@implementation forgetPassword

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"forgetPassword" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"forgetPassword_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [Globals GoogleAnalyticsScreenName:@"Forget Password"];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submit:(id)sender {
    NSString *email=[_email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([_email.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Please enter email address.";
        [[SingletonClass singleton].errorMessages setValue:_email.text forKey:@"error"];
        return;
    }
    if (![Globals validateEmailWithString:email]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Please enter valid email address.";
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
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    NSString *time = [formatter stringFromDate:[NSDate date]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[email lowercaseString],@"email",time,@"time",nil];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"GenerateRecoveryCode/" apiKey:[Globals apiKey]];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [self.view endEditing:YES];
                forgotPasswordConfirmaion *forget=[[forgotPasswordConfirmaion alloc]init];
                forget.email=_email.text;
                [self.navigationController pushViewController:forget animated:YES];
            }
            else{
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblMessage.text=@"This email id not register with trainervate.";
                
            }
        }
        else {
            [self.view endEditing:YES];
            _bluredView.hidden=NO;
            _errorView.hidden=NO;
            
            _lblMessage.text=@"Sorry! Internal server error";
            
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _errorView.hidden=NO;
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _lblMessage.text=@"Sorry! Internal server error";
        [hudFirst hide:YES];
        
    }];
}
- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
}
@end
