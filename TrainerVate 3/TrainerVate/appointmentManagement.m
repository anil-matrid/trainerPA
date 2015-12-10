//
//  appointmentManagement.m
//  TrainerVate
//
//  Created by Matrid on 20/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "appointmentManagement.h"
#import "amCustomCell.h"
#import "MBProgressHUD.h"
#import "Globals.h"
#import "Constants.h"
#import "AppointmentScreen.h"

@interface appointmentManagement (){
    NSMutableArray *userImage;
    UITableView *table;
}

@end

@implementation appointmentManagement
@synthesize pendingRequest;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

    if (IS_IPHONE_5_OR_MORE) {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 89, 320, 479)];
    }
    else {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 89, 320, 391)];
    }
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=76;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    [self.view bringSubviewToFront:table];
    // Do any additional setup after loading the view from its nib.
    userImage=[[NSMutableArray alloc]init];
    
    if (pendingRequest.count==0) {
        table.hidden=YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self callDataFormServer];
//}
//
//table view starts
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return pendingRequest.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 76;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 4;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppointmentScreen *as =[[AppointmentScreen alloc]init];
    as.apppointmentData = [pendingRequest objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:as animated:YES];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCell = @"default";
     amCustomCell *cell = (amCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *fArray = [[NSBundle mainBundle]loadNibNamed:@"amCustomCell" owner:self options:nil];
        cell = [fArray objectAtIndex:0];
    }
    cell.dp.layer.cornerRadius=cell.dp.bounds.size.height/2.0;
    cell.dp.layer.cornerRadius=cell.dp.bounds.size.width/2.0;
    cell.dp.clipsToBounds=YES;
    NSString *clientImage=[[pendingRequest objectAtIndex:indexPath.row] valueForKey:@"avatar"];
    if (![clientImage isEqual:[NSNull null]]) {
        if (![clientImage isEqualToString:@""] && clientImage!=nil) {
            NSString *clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[[pendingRequest objectAtIndex:indexPath.row] valueForKey:@"avatar"]];
            cell.dp.image=[Globals getImagesFromCache:clientImage];
        }
    }
    else {
        cell.dp.image=[UIImage imageNamed:@"noimage.png"];
    }
   // cell.dp.image=[Globals getImagesFromCache:[userImage objectAtIndex:indexPath.row]];
    cell.nameLbl.text=[[pendingRequest objectAtIndex:indexPath.row]valueForKey:@"name"];
    return cell;
}

//- (void)callDataFormServer {
//    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hudFirst.delegate = self;
//    hudFirst.labelText=@"Please wait";
//    hudFirst.center=self.view.center;
//    hudFirst.dimBackground=YES;
//    [hudFirst show:YES];
//    NSString *uid;
//    NSString *urlString = [Globals urlCombileHash:kApiDominStage ClassUrl:@"apointments/" apiKey:[Globals apiKey]];
//    NSDictionary *inputDic;
//    NSString *isTrainer = [[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
//    if ([isTrainer isEqualToString:@"1"]) {
//        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    }
//    else {
//        uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
//    }
//    inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"user_id",isTrainer,@"is_trainer", nil];
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError* error;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                             options:kNilOptions error:&error];
//        if (json !=nil && json.allKeys.count!=0) {
//            
//            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
//                if (json2==nil) {
//                    json2 = [[NSMutableArray alloc]init];
//                }
//                json2 = [json objectForKey:@"Appointments"];
//                [hudFirst hide:YES];
//                userImage=[json2 valueForKey:@"avatar"];
//                [Globals saveUserImagesIntoCache:userImage];
//                [_table reloadData];
//                
//            }
//            else{
//                
//                [hudFirst hide:YES];
//            }
//        }
//        [hudFirst hide:YES];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [hudFirst hide:YES];
//        
//    }];
//    
//}

- (IBAction)navBtn:(id)sender {
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
