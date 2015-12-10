//
//  forgot password.m
//  TrainerVate
//
//  Created by Matrid on 17/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "forgotPasswordConfirmaion.h"
#import "Constants.h"

@interface forgotPasswordConfirmaion ()

@end

@implementation forgotPasswordConfirmaion
@synthesize email;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Forgot Password Confirmation"];
    // Do any additional setup after loading the view from its nib.
    _txt1.text=email;
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    _txt1bg.layer.cornerRadius=_txt1bg.bounds.size.height/2;
    _txt1bg.clipsToBounds=YES;
    _txt2bg.layer.cornerRadius=_txt2bg.bounds.size.height/2;
    _txt2bg.clipsToBounds=YES;
    _txt3bg.layer.cornerRadius=_txt3bg.bounds.size.height/2;
    _txt3bg.clipsToBounds=YES;
    _txt4bg.layer.cornerRadius=_txt4bg.bounds.size.height/2;
    _txt4bg.clipsToBounds=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitBtn:(id)sender {
    if ([_txt2.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Please enter OTP code!";
        return;
    }
    if ([_txt3.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Please enter password.";
        return;
    }
    if ([_txt4.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Please enter password.";
        return;
    }
    if (![_txt4.text isEqualToString:_txt3.text]) {
        [self.view endEditing:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Password mismatch. Re-enter the password correctly.";
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
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:email,@"email",_txt2.text,@"code",[_txt3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],@"pwd",time,@"time",nil];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"UpdatePassword/" apiKey:[Globals apiKey]];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [self.view endEditing:YES];
                for (UIViewController* viewController in self.navigationController.viewControllers)
                    if ([viewController isKindOfClass:[LoginContoller class]] ) {
                        LoginContoller *tom = (LoginContoller*)viewController;
                        [self.navigationController popToViewController:tom animated:YES];
                    }
                }
            else{
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblMessage.text=@"Old Password is not Matching!";
                
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

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
}
@end
