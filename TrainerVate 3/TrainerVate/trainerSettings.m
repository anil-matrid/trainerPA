//
//  trainerSettings.m
//  TrainerVate
//
//  Created by Matrid on 08/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "trainerSettings.h"
#import "removeClients.h"
#import "Globals.h"
#import "clientWorkoutCustomCell.h"
#import "Constants.h"
#import "AFNetworking.h"
#import "addProfileController.h"
#import "RevenueScreen.h"
#import "ChangePasswordTrainer.h"
#import "clearChatTrainer.h"
#import "requestSnedController.h"



@interface trainerSettings (){
    NSArray *languageArray;
    BOOL flag;
}

@end

@implementation trainerSettings
@synthesize blurredView,view2,idLbl,table;


- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Trainer Settings"];
    // Do any additional setup after loading the view from its nib.
    blurredView.hidden=YES;
    view2.hidden=YES;
    idLbl.text=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"];
    languageArray=[NSArray arrayWithObjects:@"English",@"Polski", nil];
    if(IS_IPHONE_4_OR_LESS) {
        float sizeOfContent = 0;
        UIView *lLast = [_scrollView.subviews lastObject];
        NSInteger wd = lLast.frame.origin.y;
        NSInteger ht = lLast.frame.size.height;
        sizeOfContent = wd+ht;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 668+170);
    }
    else{
         _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 755);
    }
    flag=NO;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textTapped:)];
    tap.numberOfTapsRequired = 1;
    [idLbl addGestureRecognizer:tap];
    idLbl.userInteractionEnabled = YES;
    table.hidden=YES;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
        _notification.on=YES;
    }
    else {
        _notification.on=NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return languageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleCell=@"simpleTableCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleCell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleCell];
    }
    
    UILabel *language=[[UILabel alloc] initWithFrame:CGRectMake(2,1, cell.frame.size.width-2, cell.frame.size.height)];
    language.text=[languageArray objectAtIndex:indexPath.row];
    [cell addSubview:language];
    return cell;
    
}



- (void) textTapped:(UITapGestureRecognizer *) gestureRecognizer {
    blurredView.hidden=YES;
    view2.hidden=YES;
    if (gestureRecognizer.state == UIGestureRecognizerStateRecognized &&
        [gestureRecognizer.view isKindOfClass:[UILabel class]]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:idLbl.text];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"ID has been copied to clipboard." delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedLanguage"] isEqualToString:@""]) {
       [_select setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedLanguage"] forState:normal];
    }
}

- (IBAction)removeBtn:(id)sender {
    removeClients *imli =[[removeClients alloc]init];
    [self.navigationController pushViewController:imli animated:YES];
}

- (IBAction)clearBtn:(id)sender {
    clearChatTrainer *iml =[[clearChatTrainer alloc]init];
    [self.navigationController pushViewController:iml animated:YES];
    
}

- (IBAction)revenueBtn:(id)sender {
    RevenueScreen *rem =[[RevenueScreen alloc]init];
    [self.navigationController pushViewController:rem animated:YES];
}

- (IBAction)addProffilepic:(id)sender {
    addProfileController *pic=[[addProfileController alloc]init];
    [self.navigationController pushViewController:pic animated:YES];
}

- (IBAction)passBtn:(id)sender {
    ChangePasswordTrainer *lom = [[ChangePasswordTrainer alloc]init];
    [self.navigationController pushViewController:lom animated:YES];
}

- (IBAction)emailBtn:(id)sender {
    ChangeEmailGetCode *change =[[ChangeEmailGetCode alloc]init];
    [self.navigationController pushViewController:change animated:YES];
}

- (IBAction)languageBtn:(id)sender {
    flag=NO;
    [self commitAnimationPickerView];
}

- (IBAction)notifications:(id)sender {
    NSString *isNoti;
    if([sender isOn]){
        isNoti=@"1";
    }
    else {
        isNoti=@"0";
    }
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *userCode=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"Notification/" apiKey:[Globals apiKey]];
    NSMutableDictionary *SendingDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:isNoti,@"status",userCode,@"user_code", nil];
    [Globals PostApiURL:urlString data:SendingDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            
            [[NSUserDefaults standardUserDefaults]setValue:isNoti forKey:@"notification"];
            
        }
        else{
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
                _notification.on=YES;
            }
            else {
                _notification.on=NO;
            }
        }
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
            _notification.on=YES;
        }
        else {
            _notification.on=NO;
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"notification"] isEqualToString:@"1"]) {
            _notification.on=YES;
        }
        else {
            _notification.on=NO;
        }
    }];
    

}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)navBtn:(id)sender {
    }

- (IBAction)logoutBtn:(id)sender {
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"hash"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)uniqueBtn:(id)sender {
    blurredView.hidden=NO;
    view2.hidden=NO;
}
- (IBAction)okBtn:(id)sender {
    blurredView.hidden=YES;
    view2.hidden=YES;
}

- (IBAction)clientReq:(id)sender {
    requestSnedController *req=[[requestSnedController alloc]init];
    [self.navigationController pushViewController:req animated:YES];
}

- (IBAction)clientPendingReq:(id)sender {
    requsetManagementController *req=[[requsetManagementController alloc]init];
    [self.navigationController pushViewController:req animated:YES];
}

- (IBAction)done:(id)sender {
    flag=YES;
    [self commitAnimationPickerView];
}


- (void)commitAnimationPickerView {
    if (flag==NO) {
        CGRect newFrame = _done.frame;
        if(IS_IPHONE_4_OR_LESS) {
            newFrame.origin.y = 480-_done.frame.size.height-_pickerQty.frame.size.height;
        }
        else {
            newFrame.origin.y = 358;
        }
            // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _done.frame = newFrame;
        }];
    
        CGRect nFrame = _pickerQty.frame;
        if(IS_IPHONE_4_OR_LESS) {
            nFrame.origin.y = _done.frame.origin.y+_done.frame.size.height;
        }
        else {
            nFrame.origin.y = 406;
        }
        nFrame.origin.y = 406;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _pickerQty.frame = nFrame;
        }];
    }
    else{
        CGRect newFrame = _done.frame;
        newFrame.origin.y = 568;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _done.frame = newFrame;
        }];
        
        CGRect nFrame = _pickerQty.frame;
        nFrame.origin.y = 616;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _pickerQty.frame = nFrame;
        }];
    }
    
}

#pragma mark- picker view****************************************************************

#pragma mark- picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return languageArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [languageArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_select setTitle:[languageArray objectAtIndex:row] forState:normal];
    [[NSUserDefaults standardUserDefaults] setObject:[languageArray objectAtIndex:row] forKey:@"selectedLanguage"];
}

@end
