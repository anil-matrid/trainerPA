//
//  shopProductController.m
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopProductController.h"
#import "Constants.h"
#import "shopProductInfo.h"

@interface shopProductController (){
    NSMutableArray *prductArray;
    NSMutableArray *MainDataArray;
    NSArray *temp1;
    BOOL LongPressFlag;
    int selectedUser;
    int token;
    int qtyStore;  // sotre the selected quantity
    NSString *pid;
    NSArray *jsonData;
    NSMutableArray *cartArry;
    UITableView *tblSupplements;
    UIButton *selectedButton ; // setting the attributes of the selected to this button
}

@end

@implementation shopProductController

@synthesize lablQty,uid,name;

- (void)viewDidLoad {
    cartSelected =0;
    [super viewDidLoad];
    [super viewDidLoad];
    if (IS_IPHONE_5_OR_MORE) {
        tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 481)];
    }
    else {
        tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 393)];
    }
    [[SingletonClass singleton].ShopSelectedProduct removeAllObjects];
    tblSupplements.delegate=self;
    tblSupplements.dataSource=self;
    tblSupplements.rowHeight=81;
    [tblSupplements setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblSupplements];
//    [self.view bringSubviewToFront:tblSupplements];
    MainDataArray = [NSMutableArray array];
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    [self PostCheckForServerCartToken];
    // Do any additional setup after loading the view from its nib.
    // prductArray=[[NSMutableArray alloc]init];
    //[SingletonClass singleton].ShopSelectedProduct=[NSMutableArray array];

    
}
- (void)viewWillAppear:(BOOL)animated {
    _headerName.text=name;
    _clearView.hidden=YES;
    [self callDataFormServer];
    token=[[[NSUserDefaults standardUserDefaults] objectForKey:@"shopToken"] intValue];
    lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    
}

//-(void)PostCheckForServerCartToken{
//    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hudFirst.delegate = self;
//    hudFirst.labelText=@"Please wait";
//    hudFirst.center=self.view.center;
//    hudFirst.dimBackground=YES;
//    [hudFirst show:YES];
//    
//    NSString *urlString=[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartlist&token=%i",token];
//    // NSDictionary *dinputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerId,@"trainer_id", nil];
//    [Globals PostApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
//        [self updateTheDicForUse:[responseObject objectForKey:@"cart"]];
//        //        cartArray =[responseObject objectForKey:@"cart"];
//    
//        [self.tblSupplements reloadData];
//        [hudFirst hide:YES];
//    } failure:^(NSError *error) {
//        [hudFirst hide:YES];
//    }];
//    
//}
//-(void)updateTheDicForUse:(NSArray *)Array{
//    for (int i=0; i<Array.count; i++) {
//        NSDictionary *currentDic =[Array objectAtIndex:i];
//        ProductRecommend *productNew=[[ProductRecommend alloc]init];
//        productNew.descriptionPro = [currentDic objectForKey:@"desc"];
//        productNew.image =[currentDic objectForKey:@"image"];
//        productNew.price =[[currentDic objectForKey:@"price"] intValue];
//        productNew.quantity = [[currentDic objectForKey:@"quantity"] intValue];
//        productNew.title =[currentDic objectForKey:@"title"];
//        productNew.uid =[[currentDic objectForKey:@"uid"] intValue];
//        [cartArry addObject:productNew];
//    }
//    
//    
//}
//
//





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return prductArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *tableCell=@"myTableCell";
    supplementsCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    if (cell==nil) {
        NSArray *myData=[[NSBundle mainBundle]loadNibNamed:@"supplementsCustomCell" owner:self options:nil];
        cell=[myData objectAtIndex:0];
    }
    ProductRecommend *currentProduct=[prductArray objectAtIndex:indexPath.row];
    
    NSDictionary *temps=[jsonData objectAtIndex:indexPath.row];
    for (int i=0; i<[SingletonClass singleton].ShopSelectedProduct.count; i++) {
       ProductRecommend *temp=[[SingletonClass singleton].ShopSelectedProduct objectAtIndex:i];
        if ([temp.title isEqualToString:[temps objectForKey:@"title"]]) {
            [cell.btnProduct setImage:[UIImage imageNamed:@"cart3@1x.png"]forState:UIControlStateNormal];
            cartSelected++;
        }
    }
    
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"CreateDietPlan"]) {
        cell.btnProduct.hidden=YES;
        _viewLblBack.hidden=YES;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    else
    {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.lblPrice.text=[NSString stringWithFormat:@"%.2f",currentProduct.price];
    cell.lblProductName.text=currentProduct.title;
    cell.btnProduct.tag=indexPath.row;
    cell.lblCurrency.text=currentProduct.currency;
    cell.imgProduct.image=[Globals getImagesFromCache:currentProduct.image];
    [cell.btnProduct addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 77, 320, 5)];
    [header2 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    [cell addSubview:header2];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    shopProductInfo *productInfo=[[shopProductInfo alloc]init];
    NSMutableDictionary *dicSending =[[jsonData objectAtIndex:indexPath.row] mutableCopy];
    BOOL valueExists= NO;
    for (int i=0; i<[SingletonClass singleton].ShopSelectedProduct.count; i++) {
        ProductRecommend *product = [[SingletonClass singleton].ShopSelectedProduct objectAtIndex:i ];
        if (product.uid == [[dicSending objectForKey:@"uid"] intValue]) {
            valueExists = YES;
            break;
        }
        else{
            valueExists = NO;
        }
    }
    
    if (valueExists) {
        [dicSending setObject:@"Yes" forKey:@"cart"];
    }
    else{
        [dicSending setObject:@"No" forKey:@"cart"];
    }
    productInfo.productData=[dicSending mutableCopy];
   // productInfo.uid=[NSString stringWithFormat:@"%d",currentProduct.uid ];
    [self.navigationController pushViewController:productInfo animated:YES];
}
-(void)userSelclected:(UIButton *)senderBtn
{
    selectedUser=(int)senderBtn.tag;
    [tblSupplements reloadData];
    
}



int cartSelected=0;
-(void)yourButtonClicked:(UIButton *)sender{
   
    selectedButton = sender;
    pid=[[prductArray objectAtIndex:selectedButton.tag]valueForKey:@"uid"];
    ProductRecommend *productNew =[prductArray objectAtIndex:selectedButton.tag];
    productNew.quantity = qtyStore;
    [prductArray replaceObjectAtIndex:selectedButton.tag withObject:productNew];
    // [self addToCart];
    BOOL Found = NO;
        for (int i=0; i<[SingletonClass singleton].ShopSelectedProduct.count; i++) {
        if ([[[[SingletonClass singleton].ShopSelectedProduct objectAtIndex:i] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:selectedButton.tag] valueForKey:@"title"]]) {
            cartSelected--;
            Found = YES;
            //Deleting from sever
            [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:YES];
            [[SingletonClass singleton].ShopSelectedProduct removeObjectAtIndex:i];
            [selectedButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
            [tblSupplements reloadData];
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
        }
    }
    if (!Found) {
        [self.view bringSubviewToFront:_clearView];
        [self.view bringSubviewToFront:pickerViewBg];
        _clearView.hidden=NO;
        [UIView animateWithDuration:0.5 animations:^{
            if (IS_IPHONE_4_OR_LESS) {
                pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y-pickerViewBg.frame.size.height-70, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
            }
            else {
                pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y-pickerViewBg.frame.size.height, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
            }
            
        }];
    }
}
- (IBAction)doneBtn:(UIButton *)sender{

    [pickerViewQty selectRow:0 inComponent:0 animated:YES];
    _clearView.hidden=YES;
    cartSelected++;
    [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:NO];
    [[SingletonClass singleton].ShopSelectedProduct addObject:[prductArray objectAtIndex:selectedButton.tag]];
    [selectedButton setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
    lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
    [tblSupplements reloadData];
    [UIView animateWithDuration:0.5 animations:^{
        if (IS_IPHONE_4_OR_LESS) {
            pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y+pickerViewBg.frame.size.height+70, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
        }
        else {
            pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y+pickerViewBg.frame.size.height, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
        }
        
    }];
    
    

}
#pragma supplements api*************************************************

//-(void)addToCart
//{
//    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hudFirst.delegate = self;
//    hudFirst.labelText=@"Please wait";
//    hudFirst.center=self.view.center;
//    hudFirst.dimBackground=YES;
//    hudFirst.removeFromSuperViewOnHide = YES;
//    [hudFirst show:YES];
//    
//    NSString *urlString=[NSString stringWithFormat:@"%@%@%@%@", @"http://dev.wellbeingnetwork.com/api?call=cart&method=cartadd&pid=", pid, @"&quantity=2&token=",@"1443257610"];
//    NSDictionary *inputDic=[NSDictionary dictionary];
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSError* error;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
//                                                             options:kNilOptions error:&error];
//        if (json !=nil && json.allKeys.count!=0) {
//            if ([json objectForKey:@"items"] !=nil) {
//               
//                // NSArray *tempData=[json objectForKey:@"items"];
//                
//                [hudFirst hide:YES];
//            }
//            else{
//                [Globals alert:@"error"];
//                [hudFirst hide:YES];
//            }
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [hudFirst hide:YES];
//        [Globals alert:@"somthing went wrong"];
//        
//    }];
//    
//}

-(void)callDataFormServer
{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.view bringSubviewToFront:tblSupplements];
    [self.view bringSubviewToFront:hudFirst];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *urlString=[NSString stringWithFormat:@"%@%@%@", @"https://www.wellbeingnetwork.com/api/products?category_id=", uid, @"&s=0&e=19&locale=en"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedLanguage"] isEqualToString:@"Polski"]) {
        urlString=[NSString stringWithFormat:@"%@%@%@", @"https://www.wellbeingnetwork.com/api/products?category_id=", uid, @"&s=0&e=19&locale=pl"];
    }
    NSDictionary *inputDic=[NSDictionary dictionary];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([json objectForKey:@"items"] !=nil) {
                jsonData=[json objectForKey:@"items"];
                [self loadProductToProducts:[json objectForKey:@"items"]];
                // NSArray *tempData=[json objectForKey:@"items"];
                
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
-(void)loadProductToProducts:(NSArray *)response {
    
    prductArray =[[NSMutableArray alloc]init];
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
        NSDictionary *currentDic=[response objectAtIndex:i];
        ProductRecommend *product=[ProductRecommend new];
        product.title=[currentDic valueForKey:@"title"];
        product.image=[currentDic valueForKey:@"image"];
        product.imageLarge=[currentDic valueForKey:@"image_normal"];
        product.price=[[currentDic valueForKey:@"price"] floatValue];
        product.uid=[[currentDic valueForKey:@"uid"] intValue];
        product.currency=[currentDic valueForKey:@"currency"];
        product.quantity=1;
        [imageArr addObject:product.image];
        [prductArray addObject:product];
    }
    [Globals saveUserImagesIntoCache:imageArr];
    [tblSupplements reloadData];
}

- (IBAction)btnCart:(id)sender {
    [SingletonClass singleton].ShopSelectedProduct=[[SingletonClass singleton].ShopSelectedProduct mutableCopy];
    shopCheckoutController *recommend=[[shopCheckoutController alloc]init];
    [self.navigationController pushViewController:recommend animated:YES];
}

- (IBAction)back:(id)sender {
//    [SingletonClass singleton].ShopSelectedProduct = [SingletonClass singleton].shopSearchSelected;

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)PostCheckForServerCartToken{
    
    NSString *trainerId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    NSString *urlString=@"http://dev.wellbeingnetwork.com/api?call=cart&method=inser_token";
    NSDictionary *dinputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerId,@"trainer_id", nil];
    [Globals GetApiURL:urlString data:dinputDic success:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
    
}

-(void)PostToUpdateTheProductToWeb:(ProductRecommend *)product Delete:(BOOL)flag{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];

    NSString *urlString;
    if (flag) {
        urlString = [NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartdelete&pid=%i&token=%i",product.uid,token];
    }
    else{
         urlString =[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api?call=cart&method=cartadd&pid=%i&quantity=%i&token=%i",product.uid,qtyStore,token];
    }
    
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        if ([responseObject objectForKey:@"cart"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"cart"] objectForKey:@"token"] forKey:@"tokenIdShop"];
            [hudFirst hide:YES];
        }
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}
#pragma mark- picker view****************************************************************
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    //lablQty.text=[NSString stringWithFormat:@"%lu",row];
    qtyStore = (int)row+1;
    
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
    
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"%i",row+1];
}

@end
