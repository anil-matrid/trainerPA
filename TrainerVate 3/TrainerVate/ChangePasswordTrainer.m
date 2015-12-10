//
//  ChangePasswordTrainer.m
//  TrainerVate
//
//  Created by Matrid on 10/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ChangePasswordTrainer.h"
#import "Globals.h"
#import "clientWorkoutCustomCell.h"
#import "Constants.h"
#import "AFNetworking.h"


@interface ChangePasswordTrainer ()

@end

@implementation ChangePasswordTrainer

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"ChangePasswordTrainer_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"ChangePasswordTrainer" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"ChangePasswordTrainer_4" bundle:nibBundleOrNil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Change Passord Trainner"];
    _view2.hidden=YES;
    _textBg.layer.cornerRadius=_textBg.bounds.size.height/2;
    _textBg2.layer.cornerRadius=_textBg2.bounds.size.height/2;
    _textBg3.layer.cornerRadius=_textBg3.bounds.size.height/2;

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    _blurredVIew.hidden=YES;
    _view2.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}



- (IBAction)submitBtn:(id)sender {
    
    
    if (_txtField1.text.length==0) {
        [self.view endEditing:YES];
        _blurredVIew.hidden=NO;
        _view2.hidden=NO;
        _titleLbl.text = @"Please enter your current password.";
        return;
    }
    if ( _txtField2.text.length==0 ) {
        [self.view endEditing:YES];
        _blurredVIew.hidden=NO;
        _view2.hidden=NO;
        _titleLbl.text = @"Please enter your new password.";
        return;
    }
    if ([_txtField2.text isEqualToString:_txtField1.text]){
        _blurredVIew.hidden=NO;
        _view2.hidden=NO;
        _titleLbl.text = @"Current and new password can not be same.";
        return;
    }
    if (_txtField3.text.length==0) {
        [self.view endEditing:YES];
        _blurredVIew.hidden=NO;
        _view2.hidden=NO;
        _titleLbl.text = @"Confirm Password field must not be empty!";
        return;
    }
    if (_txtField2.text.length<6) {
        [self.view endEditing:YES];
        _blurredVIew.hidden=NO;
        _view2.hidden=NO;
        _titleLbl.text = @"Password must contain atleast 6 characters!";
        return;
    }

    if (![_txtField2.text isEqualToString:_txtField3.text]){
        _blurredVIew.hidden=NO;
        _view2.hidden=NO;
        _titleLbl.text = @"Password Mismatch. Please try again!";
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
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id",_txtField1.text,@"current_pwd",_txtField2.text,@"new_pwd",nil];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"ChangePassword/" apiKey:[Globals apiKey]];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [self.view endEditing:YES];
                _blurredVIew.hidden=YES;
                _view2.hidden=YES;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else if ([[json objectForKey:@"status_code"] isEqualToString:@"REPEATATION"])
            {
                [self.view endEditing:YES];
                _blurredVIew.hidden=NO;
                _view2.hidden=NO;
                _titleLbl.text=@"New Password can't be same as before.";
            }
            else{
                [self.view endEditing:YES];
                _blurredVIew.hidden=NO;
                _view2.hidden=NO;
                _titleLbl.text=@"Password Mismatch. Please try again!";

            }
        }
        else {
            [self.view endEditing:YES];
            _blurredVIew.hidden=NO;
            _view2.hidden=NO;

            _titleLbl.text=@"Sorry! Internal server error.";

        }
     [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _view2.hidden=NO;
        [self.view endEditing:YES];
        _blurredVIew.hidden=NO;
        _titleLbl.text=@"Sorry! Internal server error";
        [hudFirst hide:YES];
        
    }];
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okBtn:(id)sender {
    _blurredVIew.hidden=YES;
    _view2.hidden=YES;
}

@end
