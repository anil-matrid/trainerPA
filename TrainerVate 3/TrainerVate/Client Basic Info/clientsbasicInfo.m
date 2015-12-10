//
//  clientsbasicInfo.m
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "clientsbasicInfo.h"
#import "Constants.h"
#import "MBProgressHUD.h"


@interface clientsbasicInfo ()
{
    MBProgressHUD *  hudFirst;
}



@end

@implementation clientsbasicInfo
@synthesize setReminder,finish,bluredView,doneView,canDo,done;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"clientsbasicInfo_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"clientsbasicInfo" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"clientsbasicInfo_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Client Basic Info"];
    // Do any additional setup after loading the view from its nib.
    setReminder.layer.cornerRadius=10;
    finish.layer.cornerRadius=10;
    bluredView.hidden=YES;
    doneView.hidden=YES;
    if (IS_IPHONE_4_OR_LESS) {
        [self setScrollviewOffset1];
    }
    _errorView.hidden=YES;
    [[self.textViewinjurise layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.textViewinjurise layer] setBorderWidth:1];
    [[self.textViewinjurise layer] setCornerRadius:15];
    
    [self canDo];
    [[self.canDo layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.canDo layer] setBorderWidth:1];
    [[self.canDo layer] setCornerRadius:15];
    
    [self canNotDo];
    [[self.canNotDo layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[self.canNotDo layer] setBorderWidth:1];
    [[self.canNotDo layer] setCornerRadius:15];
    
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)done:(id)sender {
    
    
    if ([_height.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter height.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
    if ([_height.text floatValue] >301) {
        [self.view endEditing:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Height should be less then 300 cm.";
        return;
    }
    if ([_height.text floatValue] <101) {
        [self.view endEditing:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Height should be greater then 100 cm.";
        return;
    }

    if ([_weight.text isEqualToString:@""]) {
        [self.view endEditing:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Please enter weight.";
        [[SingletonClass singleton].errorMessages setValue:_message.text forKey:@"error"];
        return;
    }
        if ([_weight.text floatValue] >1201) {
        [self.view endEditing:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Weight should be less then 1200 pounds.";
        return;
    }
    if ([_weight.text floatValue] <67) {
        [self.view endEditing:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        _message.text=@"Weight should be greater then 67 pounds.";
        return;
    }
  
    
    [self callDataFormServer];

}
- (IBAction)setReminder:(id)sender {
    bluredView.hidden=YES;
    doneView.hidden=YES;
    SetReminderController *reminder=[[SetReminderController alloc]init];
    [self.navigationController pushViewController:reminder animated:YES];
}
-(IBAction)ok:(id)sender{
    bluredView.hidden=YES;
    _errorView.hidden=YES;
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter height."]) {
        [_height becomeFirstResponder];
        return;
    }
    if ([[[SingletonClass singleton].errorMessages objectForKey:@"error"] isEqualToString:@"Please enter weight."]) {
        [_weight becomeFirstResponder];
        return;
    }
}

- (IBAction)finish:(id)sender {

    bluredView.hidden=YES;
    doneView.hidden=YES;
    
  NSArray *currentControllers = self.navigationController.viewControllers;
    
    /* Create a mutable array out of this array */
    NSMutableArray *newControllers = [NSMutableArray arrayWithArray:currentControllers];
    if (newControllers.count==10) {
        [self.navigationController popToViewController:[newControllers objectAtIndex:5] animated:YES];
    }
    else if (newControllers.count==9) {
        [self.navigationController popToViewController:[newControllers objectAtIndex:4] animated:YES];
    }
    else{
    [self.navigationController popToViewController:[newControllers objectAtIndex:2] animated:YES];
    }
   
    
}
-(void)callDataFormServer
{
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *itemIds=[[NSUserDefaults standardUserDefaults]objectForKey:@"itemId"];
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlCreateUserProfile apiKey:[Globals apiKey]];
    
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[[SingletonClass singleton].clientInfo objectForKey:@"activity"],@"activity",itemIds,@"uid",[[SingletonClass singleton].clientInfo objectForKey:@"g_tonemuscles"],@"g_tonemuscles",[[SingletonClass singleton].clientInfo objectForKey:@"g_weight"],@"g_weight",[[SingletonClass singleton].clientInfo objectForKey:@"g_strengthen"],@"g_strengthen",[[SingletonClass singleton].clientInfo objectForKey:@"g_upperbody"],@"g_upperbody",[[SingletonClass singleton].clientInfo objectForKey:@"g_lowerbody"],@"g_lowerbody",[[SingletonClass singleton].clientInfo objectForKey:@"g_buildmuscles"],@"g_buildmuscles",[[SingletonClass singleton].clientInfo objectForKey:@"g_endurance"],@"g_endurance",[[SingletonClass singleton].clientInfo objectForKey:@"g_flexibility"],@"g_flexibility",_weight.text,@"weight",_height.text,@"height",_textViewinjurise.text,@"injuries",canDo.text,@"can_do",_canNotDo.text,@"cannot_do",nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
              [self.view endEditing:YES];
                [hudFirst hide:YES];
                bluredView.hidden=NO;
                doneView.hidden=NO;
                _errorView.hidden=YES;
            }
            else{
                [self.view endEditing:YES];
                [hudFirst hide:YES];
                bluredView.hidden=NO;
                _errorView.hidden=NO;
                doneView.hidden=YES;
                _message.text=@"Email already exists.";
                               
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.view endEditing:YES];
        [hudFirst hide:YES];
        bluredView.hidden=NO;
        _errorView.hidden=NO;
        doneView.hidden=YES;
        _message.text=@"Sorry! Internal Server Error.";
       
    }];
    
}
- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        return NO;
    }
    if ([_textViewinjurise isEqual:textField]) {
        return YES;
    }
    if ([canDo isEqual:textField]) {
        return YES;
    }
    if ([_canNotDo isEqual:textField]) {
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
    
    if (textField==_height) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 3;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 4;
}



-(void)setScrollviewOffset1 {
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width,570);
    }
    else {
        _scorllViews.contentSize = CGSizeMake(_scorllViews.frame.size.width, 472);
    }
}
- (void)keyboardDidShow: (NSNotification *) notif{
    if(IS_IPHONE_5_OR_MORE) {
        [self setScrollviewOffset1];
        
        _scorllViews.scrollEnabled = YES;
        
    }
    if (IS_IPHONE_4_OR_LESS) {
      
        [_scorllViews addSubview:done];
    }
    
    
}


- (void)keyboardDidHide: (NSNotification *) notif{
    
   if(IS_IPHONE_5_OR_MORE) {
       
       [UIView beginAnimations:nil context:NULL];
       [UIView setAnimationDuration:0.2];
       
       _scorllViews.scrollEnabled = NO;
        
    }
    if (IS_IPHONE_4_OR_LESS) {
        _scorllViews.scrollEnabled = YES;
      
    }
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}


@end
