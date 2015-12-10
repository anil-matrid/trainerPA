//
//  recommend.m
//  TrainerVate
//
//  Created by Matrid on 29/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "recommend.h"
#import "recommend1.h"
#import "recommend2.h"
#import "Constants.h"
#import "recommendCustomCell.h"
@interface recommend () {

  

    NSMutableArray *productInfo;
    NSArray *temp;
    MBProgressHUD *  hudFirst;
    int count;
    NSMutableArray *mybundle;
    NSMutableArray *arrayRespose;
    NSMutableArray *tempBundelId;
    int senderTag;
    NSString *bundleId;
}


@end

@implementation recommend

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"recommend_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"recommend" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"recommend_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [Globals GoogleAnalyticsScreenName:@"Recommend"];
    _recommendView.hidden=YES;
    _blurdView.hidden=YES;
    _yourBundel.layer.cornerRadius=10;
    _premadeBundel.layer.cornerRadius=10;
    _yes.layer.cornerRadius=_yes.bounds.size.height/2;
    _no.layer.cornerRadius=_no.bounds.size.height/2;
    _Bundle.layer.cornerRadius=10;
    count=0;
    tempBundelId = [[NSMutableArray alloc]init];
    mybundle=[[NSMutableArray alloc]init];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"HomeScreenController"]) {
        [_recommends setTitle:@"Create New Bundle" forState:normal];
        senderTag=10;
    }
    [SingletonClass singleton].cartSelectedProduct=[[NSMutableArray alloc]init];
    [self callDataFormServer];
    _errorLabel.hidden=YES;
    _warningView.hidden=YES;
}


-(void)addSuppliment
{
    NSLog(@"add suppliment");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableView method**************************************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=[productInfo objectAtIndex:section];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return productInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTable=@"simpleTableCell";
    recommendCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
    
    if (cell==nil) {
        NSArray *temps=[[NSBundle mainBundle]loadNibNamed:@"recommendCustomCell" owner:self options:nil];
        cell=[temps objectAtIndex:0];
    }
    
    NSString  *str = [NSString stringWithFormat:@"%@",[[[productInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"quantity"]];
    cell.lblProductQty.text=str;
    float number = [str floatValue];
    cell.lblProductName.text = [[[productInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"title"];
    float price = [[[[productInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"price"] floatValue];
    number = number * price;
    cell.lblProductPrice.text = [NSString stringWithFormat:@"%.2f",number];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
     NSArray *array=[productInfo objectAtIndex:section];
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *header1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 3)];
    [header1 setBackgroundColor:[UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:1.0]];
    
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 29, 320, 3)];
    [header2 setBackgroundColor:[UIColor colorWithRed:233/255.0f green:233/255.0f blue:233/255.0f alpha:1.0]];
    
    UILabel *headerName=[[UILabel alloc]initWithFrame:CGRectMake(11, 5, 184, 21)];
    [headerName setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [headerName setText:[[arrayRespose objectAtIndex:section]valueForKey:@"Name"]];
    [headerName setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
    
    UILabel *headerProductQty=[[UILabel alloc]initWithFrame:CGRectMake(180, 6, 28, 21)];
    [headerProductQty setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [headerProductQty setText:[NSString stringWithFormat:@"%d",(int)[array count]]];
    [headerProductQty setFont:[UIFont fontWithName:@"Lato-Regular" size:12]];
    
    UILabel *headerProduct=[[UILabel alloc]initWithFrame:CGRectMake(212, 5, 65, 21)];
    [headerProduct setText:@"products"];
    [headerProduct setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [headerProduct setFont:[UIFont fontWithName:@"Lato-Regular" size:12]];
    headerProductQty.textAlignment = NSTextAlignmentRight;
    
    UIButton *btnHeader=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    btnHeader.tag=section;
    [btnHeader addTarget:self action:@selector(editBundle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnCross=[[UIButton alloc]initWithFrame:CGRectMake(260, 0, 50, 35)];
    btnCross.tag=section;
    [btnCross setImage:[UIImage imageNamed:@"cross.png"] forState:normal];
    [btnCross addTarget:self action:@selector(deleteBundle:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:header1];
    [headerView addSubview:header2];
    [headerView addSubview:headerName];
    [headerView addSubview:headerProductQty];
    [headerView addSubview:headerProduct];
    [headerView addSubview:btnHeader];
    [headerView addSubview:btnCross];
    if (section==[[mybundle valueForKey:@"Name"] count]-1) {
        section=0;
    }
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 9)];
    [headerView setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    return headerView;
    
}



- (void) editBundle:(UIButton *)senderBtn {
    
    NSArray *array=[productInfo objectAtIndex:senderBtn.tag];
    NSArray *productConvertedArray =[self loadProductToProductsWhenSending:array];
    [SingletonClass singleton].cartSelectedProduct = [productConvertedArray mutableCopy];
    [[SingletonClass singleton].bundelSelectedProduct setValue:[[arrayRespose objectAtIndex:senderBtn.tag]valueForKey:@"ID"] forKey:@"name"];
    recommendBundleEditing *editing=[[recommendBundleEditing alloc]init];
   // editing.RecommendID=ID
    [self.navigationController pushViewController:editing animated:YES];
}

#pragma api***************************************************************************

- (void) deleteBundle:(UIButton *)senderBtn {
    _warningView.hidden=NO;
    _blurdView.hidden=NO;
    [tempBundelId removeObjectAtIndex:senderBtn.tag];
    bundleId = [[arrayRespose objectAtIndex:senderBtn.tag] valueForKey:@"ID"];
    
}

-(void)callDataFormServer
{
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *userID= [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:KurlgetBundleProducts apiKey:[Globals apiKey]];
  
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",userID,@"client_id", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                
                [self loadProductToProducts: [json objectForKey:@"Recommendations"]];
        //    [self loadProductToProducts:[json objectForKey:@"Recommendations"]];
                [hudFirst hide:YES];
            }
            else{
                _errorLabel.hidden=NO;
                [hudFirst hide:YES]; 
            }
        }
        else {
            _errorLabel.hidden=NO;
            _errorLabel.text=@"Sorry! Internal Server Error.";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _errorLabel.text=@"Sorry! Internal Server Error.";
         _errorLabel.hidden=NO;
        
    }];
    
}

#pragma getProduct api****************************************************************
-(void)loadProductToProducts:(NSArray *)response {
    [response valueForKey:@"BundleID"];
    tempBundelId=[[NSMutableArray alloc]init];
    int tempCount=0;
    productInfo = [[NSMutableArray alloc]init];
    NSMutableArray *imageArr=[NSMutableArray array];
    arrayRespose=[response mutableCopy];
        for (int i=0; i<[[response valueForKey:@"mybundle"] count];i++ ) {
            [tempBundelId addObject:[[response objectAtIndex:i]valueForKey:@"BundleID"]];
            tempCount=0;
            mybundle=[[NSMutableArray alloc]init];
            NSArray *currentDic=[[response objectAtIndex:i]valueForKey:@"mybundle"];
            for (int j=0; j<[currentDic count]; j++) {
                 NSMutableDictionary *tempArray=[[NSMutableDictionary alloc]init];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"title"] forKey:@"title"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"price"] forKey:@"price"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"Qty"] forKey:@"quantity"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"image"] forKey:@"image"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"product_id"] forKey:@"product_id"];
                
                //[imageArr addObject:product.image];
                [mybundle addObject:tempArray];
            }
            [productInfo addObject:mybundle];
    }
        count=(int)productInfo.count;
    
    [Globals saveUserImagesIntoCache:imageArr];
    [_tblRecommend reloadData];
}

- (NSArray *)loadProductToProductsWhenSending:(NSArray *)response {
     NSMutableArray *prductArray=[NSMutableArray array];
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
            NSDictionary *currentDic=[response objectAtIndex:i];
            ProductRecommend   * product=[ProductRecommend new];
            product.title=[currentDic valueForKey:@"title"];
            product.image=[currentDic valueForKey:@"image"];
            product.imageLarge=[currentDic valueForKey:@"image_normal"];
            product.price=[[currentDic  valueForKey:@"price"] floatValue];
            product.quantity=[[currentDic valueForKey:@"quantity"] intValue];
            product.uid=[[currentDic valueForKey:@"product_id"] intValue];
            [imageArr addObject:product.image];
            [prductArray addObject:product];
        }
    [Globals saveUserImagesIntoCache:imageArr];
    return prductArray;
}

#pragma buttons actions***************************************************************

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)bundelSelection:(id)sender {
    if ([sender tag]==10) {
        recommend1 *rec=[[recommend1 alloc]init];
        rec.bundelID=tempBundelId;
        [self.navigationController pushViewController:rec animated:YES];
        _recommendView.hidden=YES;
        _blurdView.hidden=YES;

    }
    else if([sender tag]==11) {
        recommend2 *rec=[[recommend2 alloc]init];
        rec.bundelID=tempBundelId;
        [self.navigationController pushViewController:rec animated:YES];
        _recommendView.hidden=YES;
        _blurdView.hidden=YES;
    }
    else if ([sender tag]==12) {
        senderTag=12;
        [SingletonClass singleton].cartSelectedProduct=[[NSMutableArray alloc]init];
        shopController *shop=[[shopController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
        _recommendView.hidden=YES;
        _blurdView.hidden=YES;

    }
    
}


- (IBAction)recommends:(id)sender{
    [[SingletonClass singleton].bundelSelectedProduct removeAllObjects];
    [[SingletonClass singleton].dietPlanBundelArray removeAllObjects];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"HomeScreenController"]) {
        
        recommendShopController *shop=[[recommendShopController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }
    else{
        _blurdView.hidden=NO;
        _recommendView.hidden=NO;
        [Globals showBounceAnimatedView:self.recommendView completionBlock:nil];
    }
}
- (IBAction)cross:(id)sender {
    _recommendView.hidden=YES;
    _blurdView.hidden=YES;
}
- (IBAction)yes:(id)sender {
    
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *userID= [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:kUrlRemoveRecommendationBundles apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",userID,@"client_id",bundleId,@"bundle_id", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                for (int i=0; i<arrayRespose.count; i++) {
                    if ([[arrayRespose objectAtIndex:i] containsObject:bundleId]) {
                        [arrayRespose removeObjectAtIndex:i];
                        [self loadProductToProducts:arrayRespose];
                        _warningView.hidden=YES;
                        _blurdView.hidden=YES;
                        break;
                    }
                    
                }
                [hudFirst hide:YES];
                _warningView.hidden=YES;
                _blurdView.hidden=YES;
            }
            else{
                _warningView.hidden=YES;
                _blurdView.hidden=YES;
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _errorLabel.hidden=NO;
        
    }];

}
- (IBAction)no:(id)sender {
    _warningView.hidden=YES;
    _blurdView.hidden=YES;
    
}
@end
