//
//  shopController.m
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopController.h"
#import "recommend1.h"
#import "Constants.h"
#import "recommend2.h"
#import "shopSearchControllerViewController.h"

@interface shopController () {
    NSMutableArray *shopCate;
    MBProgressHUD *  hudFirst;
    NSMutableArray *cartArray;
    UITableView *tblShop;
    BOOL flagScreen;
}

@end

@implementation shopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SingletonClass singleton].ShopSelectedProduct removeAllObjects];
    if (IS_IPHONE_5_OR_MORE) {
        tblShop=[[UITableView alloc]initWithFrame:CGRectMake(0, 132, 320, 436)];
    }
    else {
        tblShop=[[UITableView alloc]initWithFrame:CGRectMake(0, 132, 320, 348)];
    }
    tblShop.delegate=self;
    tblShop.dataSource=self;
    [tblShop setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblShop];
    [self.view bringSubviewToFront:tblShop];
    cartArray=[[NSMutableArray alloc]init];
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    _lblQty.text=@"0";
//    [super viewWillAppear:YES];
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]]) {
            _btnCart.userInteractionEnabled=NO;
            break;
        }
    }
    
    NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"HomeScreenController"]) {
        [self getTrainerToken];
        [self callDataFormServer];
      //  [self PostCheckForServerCartToken];
    }
    else {
        [self callDataFormServer];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        [self getTrainerToken];
        [self callDataFormServer];
     //   [self PostCheckForServerCartToken];;
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[recommend2 class]]) {
            _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
            flag=YES;
            break;
        }
    }
    if (flag==NO) {
        _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shopTextField"];
    }
    if ([_preClass isEqualToString:@"breakfast"]) {
        _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].breakfastdietPlanBundelSuppliment.count];
    }
    else if ([_preClass isEqualToString:@"lunch"]){
        _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].lunchdietPlanBundelSuppliment.count];
    }
    else if ([_preClass isEqualToString:@"dinner"]){
        _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].dinnerdietPlanBundelSuppliment.count];
    }
    else if ([_preClass isEqualToString:@"snaks"]){
        _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].snaksdietPlanBundelSuppliment.count];
    }

    //Checking previous screen
    flagScreen=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[DietPlanController class]]) {
            flagScreen=YES;
            break;
        }
    }
}


#pragma tableView delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return shopCate.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCell=@"myTableCell";
    shopCustomCellControllerTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell==nil) {
        NSArray *myData=[[NSBundle mainBundle]loadNibNamed:@"shopCustomCellControllerTableViewCell" owner:self options:nil];
        cell=[myData objectAtIndex:0];
    }
    cell.lblTitle.text=[[shopCate objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *temp=[[shopCate objectAtIndex:indexPath.row] valueForKey:@"subcategories"];
    if (temp.count==0) {
        if (flagScreen==YES) {
            recommendShopController *shop=[[recommendShopController alloc]init];
            shop.uid=[[shopCate objectAtIndex:indexPath.row] valueForKey:@"uid"];
            shop.name=[[shopCate  objectAtIndex:indexPath.row] valueForKey:@"name"];
            shop.preClass = self.preClass;
            [self.navigationController pushViewController:shop animated:YES];
                
        }
        else {
            shopProductController *shop=[[shopProductController alloc]init];
            shop.name=[[shopCate  objectAtIndex:indexPath.row] valueForKey:@"name"];
            shop.uid=[[shopCate objectAtIndex:indexPath.row] valueForKey:@"uid"];
            [self.navigationController pushViewController:shop animated:YES];
        }
        
    }
    else {
        shopSubCategoryViewController *sub=[[shopSubCategoryViewController alloc]init];
        sub.name=[[shopCate  objectAtIndex:indexPath.row] valueForKey:@"name"];
        sub.subCategoryHolder=[[shopCate  objectAtIndex:indexPath.row] valueForKey:@"subcategories"];
         sub.preClass = self.preClass;
        [self.navigationController pushViewController:sub animated:YES];
    }
   
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,2)];
    [view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    return view;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCart:(id)sender {
    
    BOOL flag=NO;
    //    [SingletonClass singleton].cartSelectedProduct=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommendBundleEditing class]] ) {
            recommendBundleEditing *tom = (recommendBundleEditing*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag=YES;
            break;
            }
        }

    if (flag==NO) {
        BOOL flag1=NO;
        [SingletonClass singleton].ShopSelectedProduct=[[SingletonClass singleton].ShopSelectedProduct mutableCopy];
        [SingletonClass singleton].cartSelectedProduct=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]]) {
                setRecommendReminder *recommend1=[[setRecommendReminder alloc]init];
                [self.navigationController pushViewController:recommend1 animated:YES];
                flag1=YES;
                break;
            }
        }
        if (flag1==NO){
            shopCheckoutController *recommend=[[shopCheckoutController alloc]init];
            [self.navigationController pushViewController:recommend animated:YES];
        }
    }
}

- (IBAction)search:(id)sender {
    shopSearchControllerViewController *search=[[shopSearchControllerViewController alloc]init];
    search.preClass=_preClass;
    [self.navigationController pushViewController:search animated:YES];
}


#pragma shop api*************************************************
-(void)callDataFormServer {
    
    NSString *urlString=@"http://www.wellbeingnetwork.com/api/categories?locale=en";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedLanguage"] isEqualToString:@"Polski"]) {
        urlString=@"http://www.wellbeingnetwork.com/api/categories?locale=pl";
    }
    NSDictionary *inputDic=[NSDictionary dictionary];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([json objectForKey:@"categories"] !=nil) {
                shopCate=[json objectForKey:@"categories"];
                [tblShop reloadData];
                NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
                if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend"] || [NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend1"]) {
                    [hudFirst hide:YES];
                }
//                [self trainerToken];
            }
            else{
                [Globals alert:@"error"];
                [hudFirst hide:YES];
               
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
        [Globals alert:@"somthing went wrong"];
        [hudFirst hide:YES];
        
    }];
    
    
}
-(void)getTrainerToken {
    
    NSString *urlString=KurlgenerateToken;
    NSDictionary *inputDic=[NSDictionary dictionary];
    [Globals GetApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"cart"]objectForKey:@"token"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"cart"] objectForKey:@"token"] forKey:@"shopToken"];
            [self PostCheckForServerCartToken];
        }
        else
        {
         //   [hudFirst hide:YES];
        }
        
    } failure:^(NSError *error) {
      //  [hudFirst hide:YES];
    }];
}

//-(void)checkInsertedToken:(NSString *)token{
//    NSString *uid;
//    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
//    
//        uid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
//    }
//    else {
//        uid=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
//    }
//    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:kurlShopTokenInsert apiKey:[Globals apiKey]];
//    NSMutableDictionary *SendingDic=[NSMutableDictionary dictionary];
//    [SendingDic setObject:token forKey:@"token_key"];
//    [SendingDic setObject:uid forKey:@"trainer_id"];
//    
//    [Globals PostApiURL:urlString data:SendingDic success:^(id responseObject) {
//        [hudFirst hide:YES];
//       
//   } failure:^(NSError *error) {
//       [hudFirst hide:YES];
//   }];
//}
//-(void)checkTokenExistsOnServer{
//    NSString *TrainderID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
//    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:kurlShopTokenGet apiKey:[Globals apiKey]];
//    NSMutableDictionary *SendingDic=[NSMutableDictionary dictionary];
//   //[SendingDic setObject:token forKey:@"token_key"];
//    [SendingDic setObject:TrainderID forKey:@"trainer_id"];
//    
//    [Globals PostApiURL:urlString data:SendingDic success:^(id responseObject) {
//        if ([[responseObject objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
//            [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"tokenKey"] forKey:@"shopToken"];
//            
//            //[hudFirst hide:YES];
//        }
//        else{
//            [self getTrainerToken];
//        }
//        
//    } failure:^(NSError *error) {
//        //[hudFirst hide:YES];
//    }];
//}

-(void)PostCheckForServerCartToken{
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] ) {
            //[hudFirst hide:YES];
            return;
        }
    }
    NSString *urlString=[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartlist&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"shopToken"]];
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        cartArray = [responseObject objectForKey:@"cart"];
        [self loadProductToProducts:cartArray];
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}

-(void)loadProductToProducts:(NSArray *)response {
  
    NSMutableArray *prductArray =[[NSMutableArray alloc]init];
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
        NSDictionary *currentDic=[response objectAtIndex:i];
        ProductRecommend *product=[ProductRecommend new];
        product.title=[currentDic valueForKey:@"title"];
        product.image=[currentDic valueForKey:@"image"];
        product.imageLarge=[currentDic valueForKey:@"image_normal"];
        product.price=[[currentDic valueForKey:@"price"] floatValue];
        product.uid=[[currentDic valueForKey:@"uid"] intValue];
        product.quantity=1;
        [imageArr addObject:product.image];
        [prductArray addObject:product];
    }
    [Globals saveUserImagesIntoCache:imageArr];
    [SingletonClass singleton].ShopSelectedProduct=prductArray;
    _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
}

@end
