//
//  SentToClientController.m
//  TrainerVate
//
//  Created by Matrid on 09/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "SentToClientController.h"
#import "Constants.h"
#import "recommendReminderController.h"
#import "recommend1.h"

@interface SentToClientController ()
{
    NSMutableArray *myClienData;
    NSMutableArray *client_id;
    NSString *jsonString;
    NSString *uidString;
    NSString *preClass;
    
}

@end

@implementation SentToClientController
@synthesize bundleName,preClass,recommendId;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"SentToClientController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"SentToClientController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"SentToClientController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Sent To Client Controller"];
    _myClientsList.delegate = self;
    _myClientsList.dataSource =self;
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
    _reminderView.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _setREminder.layer.cornerRadius=_setREminder.frame.size.height/2;
    _finish.layer.cornerRadius=_finish.frame.size.height/2;
    client_id=[[NSMutableArray alloc]init];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [_myClientsList setAllowsSelection:YES];
    [self callDataFormServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return myClienData.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simple=@"simpleTable";
    sentToClientCustomCell *cell12=(sentToClientCustomCell *)[tableView dequeueReusableCellWithIdentifier:simple];
    if (cell12==nil) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"sentToClientCustomCell" owner:self options:nil];
        cell12=[mArray objectAtIndex:0];
    }
    cell12.customUserImage.layer.cornerRadius = cell12.customUserImage.frame.size.width / 2;
    cell12.customUserImage.clipsToBounds = YES;
    
    if ([[myClienData objectAtIndex:indexPath.row] valueForKey:@"avatar"]==nil || [[[myClienData objectAtIndex:indexPath.row] valueForKey:@"avatar"] isEqual:[NSNull null] ] || [[[myClienData objectAtIndex:indexPath.row] valueForKey:@"avatar"] isEqualToString:@"NULL"] || [[[myClienData objectAtIndex:indexPath.row] valueForKey:@"avatar"] isEqualToString:@""] || [[[myClienData objectAtIndex:indexPath.row] valueForKey:@"avatar"] isEqualToString:@"null"]) {
        cell12.customUserImage.image=[UIImage imageNamed:@"default8.png"];
    }
    else {
        NSString *clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[[myClienData objectAtIndex:indexPath.row] valueForKey:@"avatar"]];
        cell12.customUserImage.image=[Globals getImagesFromCache:clientImage];
        
    }
    
    cell12.CustomUserName.text=[[myClienData objectAtIndex:indexPath.row ] valueForKey:@"name"];
    //cell12.tickImage.image = [UIImage imageNamed:@""];
    if ([[[myClienData objectAtIndex:indexPath.row ] valueForKey:@"is_exists"] isEqual:@"1"]) {
        cell12.selectionStyle = UITableViewCellSelectionStyleNone;
        cell12.userInteractionEnabled = NO;
        UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,74)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
        [cell12 addSubview:views];
    }
    if ([client_id containsObject:[[myClienData objectAtIndex:indexPath.row ] valueForKey:@"id"]]) {
        cell12.tick.image=[UIImage imageNamed:@"tick.png"];
        // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        cell12.tick.image=nil;
    }
    
    cell12.tick.backgroundColor=[UIColor clearColor];
    UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,3)];
    [views setBackgroundColor:[UIColor whiteColor]];
    [cell12 addSubview:views];
        return cell12;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([client_id containsObject:[[myClienData objectAtIndex:indexPath.row ] valueForKey:@"id"]]) {
        NSInteger indexValue =[client_id indexOfObject:[[myClienData objectAtIndex:indexPath.row ] valueForKey:@"id"]];
        [client_id removeObjectAtIndex:indexValue];
    }
    else {
        [client_id addObject:[[myClienData objectAtIndex:indexPath.row ] valueForKey:@"id"]];
    }
    [_myClientsList reloadData];
    
}


-(void)callDataFormServer
{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    

    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *bundelID;
    if ([preClass isEqualToString:@"recomend1"]) {
        bundelID =recommendId;
    }
    else {
        bundelID =[[SingletonClass singleton].bundelSelectedProduct valueForKey:@"name"];
    }
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:KurlCheckRecommendationToReminder apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",bundelID,@"bundle_id", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                myClienData=[json objectForKey:@"returnset"];
                [Globals saveUserImagesIntoCache:[myClienData valueForKey:@"avatar"]];
                [_myClientsList reloadData];
                [hudFirst hide:YES];
            }
            else{
                [Globals alert:@"error"];
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"somthing went wrong"];
        
    }];
    
}

-(void)callDataFormServerss
{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:KurlsetRecommendationToReminder apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"data", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [hudFirst hide:YES];
                [[SingletonClass singleton].dietPlanBundelArray removeAllObjects];
                //This for loop iterates through all the view controllers in navigation stack.
                uidString=[json objectForKey:@"recommendated_ids"];
                _bluredView.hidden=NO;
                _reminderView.hidden=NO;
            }
            else{
                [Globals alert:@"error"];
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _ok.hidden=NO;
        _lblMessage.text=@"Sorry! Internal Server Error.";

        
    }];
    
}


- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)send:(id)sender {
    NSString *bundelID;
    if ([preClass isEqualToString:@"recomend1"]) {
        bundelID =recommendId;
    }
    else {
        bundelID =[[SingletonClass singleton].bundelSelectedProduct valueForKey:@"name"];
    }
    NSMutableDictionary *data1=[[NSMutableDictionary alloc]init];
    data1=[[NSMutableDictionary alloc]init];
    // [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct objectForKey:@"bundelId"] forKey:@"bundle_id"];
    [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"trainer_id"];
    [data1 setObject:bundelID forKey:@"bundle_id"];
    [data1 setObject:client_id forKey:@"client_id"];
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data1
                                                   options:0
                                                     error:&error];
    jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    if (client_id!=nil && client_id.count!=0) {
        [self callDataFormServerss];
    }
    else {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _ok.hidden=NO;
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
    }
  
}
- (IBAction)done:(id)sender {
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
}
- (IBAction)setREminder:(id)sender {
    recommendReminderController *groupViewController = [[recommendReminderController alloc]init];
    groupViewController.clientID=[client_id mutableCopy];
    groupViewController.bundelName=bundleName;
    groupViewController.uidStr=uidString;
    [self.navigationController pushViewController:groupViewController animated:YES];
}
- (IBAction)finish:(id)sender {
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommend1 class]]) {
            recommend1 *recommend=(recommend1 *)viewController;
            [self.navigationController popToViewController:recommend animated:YES];
        }
    }
}
@end
