//
//  LoginContoller.m
//  TrainerVate
//
//  Created by Matrid on 29/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "LoginContoller.h"
#import "Constants.h"
#define kOFFSET_FOR_KEYBOARD 50


@interface LoginContoller ()
{
    MBProgressHUD * hudFirst;
}

@end

@implementation LoginContoller
@synthesize userName,userPassword,userIdLogin,userType;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"LoginContoller_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"LoginContoller" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"LoginContoller_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     //GIA
      [Globals GoogleAnalyticsScreenName:@"Login Controller"];
     
     
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated {
       [super viewWillAppear:YES];
    _messageView.hidden=YES;
    _bluredView.hidden=YES;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- iBActions

- (IBAction)userLogin:(id)sender {
    NSString *email=[userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // adding validations
    if ([userName.text isEqualToString:@""] && [userPassword.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _messageView.hidden=NO;
        _bluredView.hidden=NO;
        
        _message.text=@"Please enter email and password.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
    if ([userName.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _messageView.hidden=NO;
        _bluredView.hidden=NO;
        _message.text=@"Please enter email address.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
    if ([userPassword.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        _messageView.hidden=NO;
        _bluredView.hidden=NO;
        _message.text=@"Please enter password.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
   
  
    if (![Globals validateEmailWithString:email]) {
        [self.view endEditing:YES];
        _messageView.hidden=NO;
        _bluredView.hidden=NO;
        _message.text=@"Please enter valid email address.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
 
    // adding loading hud in the view
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
//    NSString *apiKey=[Globals apiKey];
    
     
     
    NSString *urlString=[Globals urlCombile:kApiDomin ClassUrl:kUrlLoign apiKey:[Globals apiKey]];
    NSString *token=[AppDelegate shared].StrDeviceToken;
    if (token.length==0) {
        token = @"dummy";
    }
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:token,@"device_key",@"1",@"is_iOS",[email lowercaseString],@"email",userPassword.text,@"password",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"message"] isEqualToString:@"You've been logged on!"]) {
                 [[NSUserDefaults standardUserDefaults]setObject:[json  objectForKey:@"hash"] forKey:@"hash"];
                 [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"name"] forKey:@"trainerName"];
                 [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"user_code"] forKey:@"user_code"];
                 [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"trainer"] forKey:@"userType"];
                 [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"notify"] forKey:@"notification"];
                 
                 if ([json objectForKey:@"avatar"]==nil || [[json objectForKey:@"avatar"] isEqual:[NSNull null]]) {
                      [[NSUserDefaults standardUserDefaults]setValue:@"" forKey:@"userPic"];
                 }
                 else {
                    [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"avatar"] forKey:@"userPic"];
                      NSString *usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[json objectForKey:@"avatar"]];
                      [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:usrImage]];
                 }
                 
                 [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"affiliate_id"] forKey:@"afId"];
                 [[NSUserDefaults standardUserDefaults]setValue:[json objectForKey:@"email"] forKey:@"email"];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"reload" object:self];
                if (![[json objectForKey:@"trainer"]isEqualToString:userType]) {
                    [hudFirst hide:YES];
                     [self.view endEditing:YES];
                    _bluredView.hidden=NO;
                    _messageView.hidden=NO;
                    _message.text=@"You are not authorised to login!";
                    return;
                }
                
               // [self getUserInfo];
                if ([[json objectForKey:@"trainer"] isEqualToString:@"1"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"uid"] forKey:@"userId"];
                    [self pushWhenLoginSecuss];
                }
                else {
                    ClientHomeScreen *home = [[ClientHomeScreen alloc]init];
                    [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"code"] forKey:@"trainerCode"];
                    [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"uid"] forKey:@"uid"];
                    [[NSUserDefaults standardUserDefaults]setObject:[json objectForKey:@"trainer_id"] forKey:@"userId"];
                    [self.navigationController pushViewController:home animated:YES];
                }
                 
            }
            else if ([[json objectForKey:@"status_code"]isEqualToString:@"E_LOGIN"]) {
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _messageView.hidden=NO;
                _message.text=@"Wrong email or password.";
            }
            else {
                 [hudFirst hide:YES];
                [self.view endEditing:YES];
                _bluredView.hidden=NO;
                _messageView.hidden=NO;
                _message.text=@"Sorry! Internal Server Error.";
            }
        }
        else {
            [hudFirst hide:YES];
            [self.view endEditing:YES];
            _bluredView.hidden=NO;
            _messageView.hidden=NO;
            _message.text=@"Sorry! Internal Server Error.";
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _messageView.hidden=NO;
        _message.text=@"Sorry! Internal Server Error.";
    }];
}


- (void)pushWhenLoginSecuss {
    HomeScreenController *home=[[HomeScreenController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}
- (IBAction)back:(id)sender {
     if ([userType isEqualToString:@"0"]) {
          [self.navigationController popViewControllerAnimated:YES];
     }
     else {
          for (UIViewController *viewController in self.navigationController.viewControllers) {
               if ([viewController isKindOfClass:[MainScreenController class]]) {
                    MainScreenController *main=(MainScreenController *)viewController;
                    [self.navigationController popToViewController:main animated:YES];
               }
          }
     }
     
}
- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}



#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hud removeFromSuperview];
    hud = nil;
}
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


- (void)keyboardDidHide: (NSNotification *) notif {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
   
    _scorllViews.scrollEnabled = NO;
     
    [self.view setNeedsDisplay];
     [UIView commitAnimations];
}


- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _messageView.hidden=YES;
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter email and password."]) {
        [userName becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter email and password."]) {
        [userName becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter email address."]) {
        [userName becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter valid email address."]) {
        [userName becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter password."]) {
        [userPassword becomeFirstResponder];
        return;
    }
}
- (IBAction)forgetPassword:(id)sender {
    forgetPassword *forget=[[forgetPassword alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
    
}
@end
