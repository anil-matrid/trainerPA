//
//  clientSideRecommendation.m
//  TrainerVate
//
//  Created by Matrid on 30/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "clientSideRecommendation.h"
#import "recommendationCustomCell.h"
#import "recommendationBundelInfo.h"
#import "Constants.h"

@interface clientSideRecommendation ()
{
    
    NSMutableArray *recomProduct;
    NSArray *recomNumber;
    NSMutableArray *recomDate;
    NSMutableArray *myBundels;
    UITableView *table;
}

@end

@implementation clientSideRecommendation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    if (IS_IPHONE_5_OR_MORE) {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 482)];
    }
    else {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 394)];
    }
    table.delegate=self;
    table.dataSource=self;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    [self.view bringSubviewToFront:table];
    myBundels=[[NSMutableArray alloc]init];
    recomProduct =[[NSMutableArray alloc] init];
    recomNumber =[[NSArray alloc]init];
    recomDate =[[NSMutableArray alloc]init];
   // [self callDataFormServer];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}


-(void)viewWillAppear:(BOOL)animated{
    [self PostCheckForServerCartToken];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recomProduct.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 106;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    recommendationCustomCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==NULL) {
        NSArray *data= [[NSBundle mainBundle]loadNibNamed:@"recommendationCustomCell" owner:self options:nil];
        cell = [data objectAtIndex:0];
    }
    UIButton *senderBtnAction=[[UIButton alloc]initWithFrame:CGRectMake(284,1,34,21)];
    senderBtnAction.backgroundColor=[UIColor clearColor];
    [senderBtnAction  setImage:[UIImage imageNamed:@"cross.png"] forState:normal ];
    
   // [senderBtnAction addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    myBundels = [[recomProduct objectAtIndex:indexPath.row]valueForKey:@"mybundle"];
    cell.NameLbl.text = [[recomProduct objectAtIndex:indexPath.row]valueForKey:@"Name"];
    cell.dayLbl.text = [NSString stringWithFormat:@"%lu",(unsigned long)myBundels.count];
    cell.croosBnt.hidden=YES;
    cell.setTime2.hidden=YES;
    cell.setTime3.hidden=YES;
    cell.lblError.hidden=YES;
    NSString *dateStr =[[recomProduct objectAtIndex:indexPath.row]valueForKey:@"CreatedDate"];
    cell.timeLbl.text = [dateStr substringToIndex:10];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    recommendationBundelInfo *bundleInfo=[[recommendationBundelInfo alloc]init];
    bundleInfo.bundleName=[[recomProduct objectAtIndex:indexPath.row]valueForKey:@"Name"];
    bundleInfo.bundleProduct=[[recomProduct objectAtIndex:indexPath.row]valueForKey:@"mybundle"];
    [self.navigationController pushViewController:bundleInfo animated:YES];
}

//get bundle api
-(void)PostCheckForServerCartToken{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *apiDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"client_id", nil];
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:KurlgetBundleProducts apiKey:[Globals apiKey]];
    [Globals PostApiURL:urlString data:apiDic success:^(id responseObject) {
        if (responseObject!=nil && [[responseObject allKeys] count]!=0) {
            recomProduct=[responseObject objectForKey:@"Recommendations"];
            if (recomProduct.count==0) {
                table.hidden=YES;
            }
            else  {
                table.hidden=NO;
            }
            [table reloadData];
        }
        else {
            table.hidden=YES;
            _lblError.text=@"Sorry! Internal server error.";
        }
        
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        table.hidden=YES;
         _lblError.text=@"Sorry! Internal server error.";
        [hudFirst hide:YES];
    }];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)callDataFormServer {
//
//    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlGetTrainersClient apiKey:[Globals apiKey]];
//    NSDictionary *inputDic=[NSDictionary dictionary];
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError* error;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                             options:kNilOptions error:&error];
//        if (json !=nil && json.allKeys.count!=0) {
//            
//            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
//                mys =[json objectForKey:@"returnset"];
////                [SingletonClass singleton].MyClientDetail=[[json objectForKey:@"returnset"] mutableCopy];
////                clientsName=[mys valueForKey:@"name"];
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//       
//       
//    }];
//    
//}


@end
