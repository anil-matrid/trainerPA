//
//  requsetManagementController.m
//  TrainerVate
//
//  Created by Matrid on 24/11/15.
//  Copyright © 2015 Matrid. All rights reserved.
//

#import "requsetManagementController.h"
#import "Constants.h"

@interface requsetManagementController () {
    UITableView *tblShop;
    NSMutableArray *requestArray;
    NSMutableArray *imageArray;
    NSString *reciverCode;
}

@end

@implementation requsetManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Request Management Controller"];
    // Do any additional setup after loading the view from its nib.
    
    requestArray=[[NSMutableArray alloc]init];
    imageArray=[[NSMutableArray alloc]init];
    
    if (IS_IPHONE_5_OR_MORE) {
        tblShop=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 484)];
    }
    else {
        tblShop=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 393)];
    }
    tblShop.delegate=self;
    tblShop.dataSource=self;
    tblShop.rowHeight=82;
    [tblShop setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblShop];
    [self.view bringSubviewToFront:tblShop];
    [self sendRequest];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return requestArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTablecell=@"simpleTableViewCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTablecell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTablecell];
    }
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 8, 156, 21)];
    [label setFont:[UIFont fontWithName:@"Lato-Regular" size:17]];
    [label setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    NSString *string =[[requestArray objectAtIndex:indexPath.row ] valueForKey:@"name"];
    /* Section header is in 0th index... */
    [label setText:string];
    UIImageView *circle=[[UIImageView alloc]initWithFrame:CGRectMake(5, 9, 62, 62)];
    circle.image=[UIImage imageNamed:@"sign_circle.png"];
    [views addSubview:circle];
    
    UIImageView *userImages=[[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 56, 56)];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *userPic=[[requestArray objectAtIndex:indexPath.row] valueForKey:@"avatar"];
    if (userPic==nil || [userPic isEqual:[NSNull null]] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@"null"]) {
        userImages.image=[UIImage imageNamed:@"default8.png"];
        
    }
   else {
       NSString *clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[requestArray objectAtIndex:indexPath.row]];
        userImages.image=[Globals getImagesFromCache:clientImage];
    }
    
    userImages.layer.cornerRadius = userImages.frame.size.width / 2;
    userImages.clipsToBounds = YES;
    
    if ([[[requestArray objectAtIndex:indexPath.row] valueForKey:@"is_sent"] isEqualToString:@"0"]) {
        // Button with aciton
        UIButton *accept=[[UIButton alloc] initWithFrame:CGRectMake(211, 12, 98, 21)];
        accept.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
        [accept setTitle:@"Accept" forState:normal];
        [accept setTitleColor:[UIColor whiteColor] forState:normal];
        accept.layer.cornerRadius=accept.bounds.size.height/2;
        accept.backgroundColor=[UIColor colorWithRed:133/255.0 green:152/255.0 blue:160/255.0 alpha:1.0];
        [accept addTarget:self action:@selector(acceptRejectApi:) forControlEvents:UIControlEventTouchUpInside];
        accept.tag=indexPath.row;
        
        UIButton *reject=[[UIButton alloc] initWithFrame:CGRectMake(211, 47, 98, 21)];
        reject.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
        [reject setTitle:@"Reject" forState:normal];
        [reject setTitleColor:[UIColor whiteColor] forState:normal];
        reject.layer.cornerRadius=reject.bounds.size.height/2;
        reject.backgroundColor=[UIColor colorWithRed:133/255.0 green:152/255.0 blue:160/255.0 alpha:1.0];
        [reject addTarget:self action:@selector(acceptRejectApi:) forControlEvents:UIControlEventTouchUpInside];
        reject.tag=indexPath.row;
        
        UILabel *requestMessage = [[UILabel alloc] initWithFrame:CGRectMake(80, 36, 107, 21)];
        [requestMessage setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [requestMessage setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        requestMessage.numberOfLines=0;
        NSString *string =@"sent you a request.";
        [requestMessage setText:string];
        [requestMessage sizeToFit];
        
        [views addSubview:requestMessage];
        [views addSubview:accept];
        [views addSubview:reject];
    }
    else {
        UIButton *cancel=[[UIButton alloc] initWithFrame:CGRectMake(211, 30, 98, 21)];
        cancel.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
        [cancel setTitle:@"Cancel" forState:normal];
        [cancel setTitleColor:[UIColor whiteColor] forState:normal];
        cancel.layer.cornerRadius=cancel.bounds.size.height/2;
        cancel.backgroundColor=[UIColor colorWithRed:133/255.0 green:152/255.0 blue:160/255.0 alpha:1.0];
        [cancel addTarget:self action:@selector(acceptRejectApi:) forControlEvents:UIControlEventTouchUpInside];
        cancel.tag=indexPath.row;
        
        UILabel *requestMessage = [[UILabel alloc] initWithFrame:CGRectMake(80, 36, 100, 21)];
        [requestMessage setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [requestMessage setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        requestMessage.numberOfLines=0;
        NSString *string =@"Pending confirmation.";
        [requestMessage setText:string];
        [requestMessage sizeToFit];
        
        [views addSubview:requestMessage];
        [views addSubview:cancel];
    }
    
    [views addSubview:userImages];
    [views addSubview:label];
    [views setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]]; //your background color...
    [cell addSubview:views];
    
    return cell;
}

-(void)acceptRejectApi:(UIButton *)sender {
    
    reciverCode=[[requestArray objectAtIndex:sender.tag] valueForKey:@"user_code"];
    if ([sender.titleLabel.text isEqualToString:@"Accept"]) {
        [self requestApi];
    }
    else {
       [self cancelRequest];
    }
    
}

-(void)requestApi{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"ActionOnRequest/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"],@"Logined_UserCode",reciverCode,@"Requested_user_code",@"accept",@"action",[[NSUserDefaults standardUserDefaults]valueForKey:@"userType"],@"is_trainer",nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            for (int i=0; i<requestArray.count; i++) {
                if ([[[requestArray objectAtIndex:i] valueForKey:@"user_code"] isEqualToString:reciverCode]) {
                    [requestArray removeObjectAtIndex:i];
                }
            }
            tblShop.hidden=NO;
            if(requestArray.count==0) {
                tblShop.hidden=YES;
            }
            [tblShop reloadData];
            // [Globals saveUserImagesIntoCache:imageArray];
        }
        else {
            [hudFirst hide:YES];
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        tblShop.hidden=YES;
        _lblMsg.text=@"Sorry! Internal server error.";
        [hudFirst hide:YES];
    }];

}

- (void)sendRequest{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"GetRequests/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"],@"user_id",nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            requestArray=[responseObject objectForKey:@"returnset"];
            
            if (requestArray!=nil) {
                [Globals saveUserImagesIntoCache:[requestArray valueForKey:@"avatar"]];
            }

            [tblShop reloadData];
            tblShop.hidden=NO;
           // [Globals saveUserImagesIntoCache:imageArray];
        }
        else if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"EMPTY"]) {
            [hudFirst hide:YES];
            tblShop.hidden=YES;
        }
        else {
            tblShop.hidden=YES;
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        tblShop.hidden=YES;
        _lblMsg.text=@"Sorry! Internal server error.";
        [hudFirst hide:YES];
    }];
}

-(void)cancelRequest {
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"ActionOnRequest/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]valueForKey:@"user_code"],@"Logined_UserCode",reciverCode,@"Requested_user_code",@"0",@"action",@"1",@"cancel_request",nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"trainerCode"];
            for (UIViewController *navController in self.navigationController.viewControllers) {
                if ([navController isKindOfClass:[ClientHomeScreen class]]) {
                    ClientHomeScreen *home=(ClientHomeScreen *)navController;
                    [self.navigationController popToViewController:home animated:YES];
                }
            }
            for (int i=0; i<requestArray.count; i++) {
                if ([[[requestArray objectAtIndex:i] valueForKey:@"user_code"] isEqualToString:reciverCode]) {
                    [requestArray removeObjectAtIndex:i];
                }
            }
            tblShop.hidden=NO;
            if(requestArray.count==0) {
                tblShop.hidden=YES;
            }
            [tblShop reloadData];
            // [Globals saveUserImagesIntoCache:imageArray];
        }
        else {
            [hudFirst hide:YES];
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
