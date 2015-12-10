//
//  TraineeregisterController.m
//  TrainerVate
//
//  Created by Matrid on 08/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "TraineeregisterController.h"
#import "Constants.h"

@interface TraineeregisterController ()

@end

@implementation TraineeregisterController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"TraineeregisterController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"TraineeregisterController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"TraineeregisterController_4" bundle:nibBundleOrNil];
    }
    return self;
}
@synthesize traineeEmail,trainnePhoneNum,traineePassword,traineeGymCode;
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Trainer Signup Controller"];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTapped)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer];
    
    self.termsCondition.layer.cornerRadius = self.termsCondition.bounds.size.width / 2.0;
    self.termsCondition.layer.cornerRadius = self.termsCondition.bounds.size.height/ 2.0;
    [self.termsCondition setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    
}
#pragma mark - Keyboard Resign
//method to resign keyboard on touch outside the textview
-(void)touchTapped{
    
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backMainScreen:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
   
    int passwordCount=(int)[traineePassword.text length];
    if ([traineeEmail.text isEqualToString:@""]) {
        [Globals alert:@"Please check your email"];
        return;
    }
   if ([traineePassword.text isEqualToString:@""] || passwordCount<6 ) {
    
       [Globals alert:@"Please check your Password"];
       return;
   }
    if (tic==0) {
        [Globals alert:@"Please accept Terms & Conditions"];
        return;
    }
    CreateAccountController *clientAccount=[[CreateAccountController alloc]init];
    [self.navigationController pushViewController:clientAccount animated:YES];
}
int tic=0;
- (IBAction)termsCondition:(id)sender {
    UIImage *selectedImg=[UIImage imageNamed:@"tick2.png"];
    UIImage *currentImage = [sender imageForState:UIControlStateNormal];
    NSData *data1 = UIImagePNGRepresentation(selectedImg);
    NSData *data2 = UIImagePNGRepresentation(currentImage);
    if(data1==data2)
    {
        [self.termsCondition setBackgroundImage:[UIImage imageNamed:@"tick.png"] forState:normal];
       
    }
    else{
        [self.termsCondition setBackgroundImage:[UIImage imageNamed:nil] forState:normal];
    }
}

#pragma mark- textfild delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == trainnePhoneNum){
        
        
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
        
        if(range.length + range.location > textField.text.length){
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 11;
        
    }
    
    return YES;
}
- (IBAction)txtResign:(id)sender {
    [sender resignFirstResponder];
}
@end
