//
//  shopProductController.m
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopSearchControllerViewController.h"
#import "Constants.h"
#import "recommend1.h"
#import "recommend2.h"
#import "shopProductInfo.h"

@interface shopSearchControllerViewController (){
    NSMutableArray *prductArray;
    NSMutableArray *MainDataArray;
    NSArray *temp1;
    BOOL LongPressFlag;
    int selectedUser;
    int token;
    int qtyStore;  // sotre the selected quantity
    NSString *pid;
    NSMutableArray *jsonData;
    NSMutableArray *cartArry;
    BOOL check;
    BOOL flagScreen;
    UITableView *tblSupplements;
    UIButton *selectedButton ; // setting the attributes of the selected to this button
    BOOL isdietPlan;
}

@end

@implementation shopSearchControllerViewController

@synthesize lablQty,uid,preClass;

- (void)viewDidLoad {
       isdietPlan=NO;
    
    //creating app suppliment button
    UIButton *addSuppliment=[[UIButton alloc]initWithFrame:CGRectMake(0, 517, 320, 51)];
    addSuppliment.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
    [addSuppliment setBackgroundImage:[UIImage imageNamed:@"footernewbg.png"] forState:normal];
    [addSuppliment setImage:[UIImage imageNamed:@"sign_plus.png"] forState:normal];
    [addSuppliment addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSuppliment];
    [self.view bringSubviewToFront:blockedView];
    [self.view bringSubviewToFront:pickerViewBg];
     addSuppliment.hidden=YES;
    
    //Creating tableView
    if (IS_IPHONE_5_OR_MORE) {
        if (addSuppliment.hidden==YES) {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 132, 320, 436)];
        }
        else {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 132, 320, 436-51)];
        }
    }
    else {
        if (addSuppliment.hidden==YES) {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 132, 320, 348)];
        }
        else {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 132, 320, 348-51)];
        }
    }
    tblSupplements.delegate=self;
    tblSupplements.dataSource=self;
    tblSupplements.rowHeight=81;
    [tblSupplements setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblSupplements];
    
    
    
    cartSelectedCount = 0;
    [super viewDidLoad];
    MainDataArray = [NSMutableArray array];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"shopTextField"];
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    [self PostCheckForServerCartToken];
    
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]] ) {
            _cart.userInteractionEnabled=NO;
            addSuppliment.hidden=NO;
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].dietPlanBundelArray.count];
            isdietPlan=YES;
            break;
        }
    }
    if ([preClass isEqualToString:@"breakfast"]) {
        MainDataArray = [[SingletonClass singleton].breakfastdietPlanBundelSuppliment mutableCopy];
    }
    else if ([preClass isEqualToString:@"lunch"]){
        MainDataArray = [[SingletonClass singleton].lunchdietPlanBundelSuppliment mutableCopy];
    }
    else if ([preClass isEqualToString:@"dinner"]){
        MainDataArray = [[SingletonClass singleton].dinnerdietPlanBundelSuppliment mutableCopy];
    }
    else if ([preClass isEqualToString:@"snaks"]){
        MainDataArray = [[SingletonClass singleton].snaksdietPlanBundelSuppliment mutableCopy];
    }
    if (MainDataArray==nil) {
        MainDataArray=[[NSMutableArray alloc]init];
    }
}
- (void)viewWillAppear:(BOOL)animated {
//    [SingletonClass singleton].ShopSelectedProduct = [SingletonClass singleton].shopSearchSelected;
    [_searchText becomeFirstResponder];
    tblSupplements.hidden=YES;
    _errorIcon.hidden=YES;
    blockedView.hidden=YES;
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[recommend2 class]]) {
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
            check=YES;
            break;
        }
    }
    
    if (check==NO) {
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
    }
    if ([preClass isEqualToString:@"breakfast"]) {
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].breakfastdietPlanBundelSuppliment.count];
    }
    else if ([preClass isEqualToString:@"lunch"]){
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].lunchdietPlanBundelSuppliment.count];
    }
    else if ([preClass isEqualToString:@"dinner"]){
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].dinnerdietPlanBundelSuppliment.count];
    }
    else if ([preClass isEqualToString:@"snaks"]){
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].snaksdietPlanBundelSuppliment.count];
    }
    
    _msgLabel.text=@"What are you looking for?";
    token=[[[NSUserDefaults standardUserDefaults] objectForKey:@"shopToken"] intValue];
    NSString *searchValue=[[NSUserDefaults standardUserDefaults] objectForKey:@"shopTextField"];
    if (searchValue.length!=0) {
        _searchText.text=searchValue;
        [self callDataFormServer];
    }
    
    flagScreen=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[DietPlanController class]]) {
            flagScreen=YES;
            break;
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    blockedView.hidden=YES;
    return YES;
}

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
    if (check==YES) {
        NSArray *temp=[SingletonClass singleton].cartSelectedProduct;
        for (int i=0; i<temp.count; i++) {
            if ([[[[SingletonClass singleton].cartSelectedProduct objectAtIndex:i ] valueForKey:@"title"] isEqualToString:currentProduct.title]) {
                [cell.btnProduct setImage:[UIImage imageNamed:@"cart3@1x.png"]forState:UIControlStateNormal];
                cartSelectedCount++;
                break;
            }
        }
    }
    else {
        for (int i=0; i<[SingletonClass singleton].ShopSelectedProduct.count; i++) {
            if ([[[[SingletonClass singleton].ShopSelectedProduct objectAtIndex:i ] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:indexPath.row] valueForKey:@"title"]]) {
                    [cell.btnProduct setImage:[UIImage imageNamed:@"cart3@1x.png"]forState:UIControlStateNormal];
                    cartSelectedCount++;
                    break;
                }
            }
        }
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"CreateDietPlan"]) {
        cell.btnProduct.hidden=YES;
        _viewLblBack.hidden=YES;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    else {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.lblPrice.text=[NSString stringWithFormat:@"%.2f",currentProduct.price];
    cell.lblProductName.text=currentProduct.title;
    cell.btnProduct.tag=indexPath.row;
    cell.imgProduct.image=[Globals getImagesFromCache:currentProduct.image];
    [cell.btnProduct addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 77, 320, 5)];
    [header2 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    [cell addSubview:header2];
    if (isdietPlan==YES) {
        cell.btnProduct.hidden=YES;
    }
    BOOL valueFlag = NO;
    for (int i = 0; i<MainDataArray.count; i++) {
        ProductRecommend *currentProduct = [prductArray objectAtIndex:indexPath.row];
        ProductRecommend *mainArrayProduct = [MainDataArray objectAtIndex: i];
        if (currentProduct.uid == mainArrayProduct.uid) {
            valueFlag = YES;
            break;
        }
    }
    if (valueFlag) {
        cell.tick.image=[UIImage imageNamed:@"tick.png"];
    }
    else{
        cell.tick.image=nil;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isdietPlan==YES) {
        BOOL  valueFlag=NO;
        int indexValue = 0;
        for (int i=0; i<MainDataArray.count; i++) {
            ProductRecommend *mainProduct=[MainDataArray objectAtIndex:i];
            ProductRecommend *currentCellProduct = [ prductArray objectAtIndex:indexPath.row];
            if (mainProduct.uid == currentCellProduct.uid) {
                valueFlag = YES;
                indexValue = i;
                break;
            }
        }
        if (valueFlag) {
            //  NSInteger indexValue =[MainDataArray indexOfObject:[prductArray objectAtIndex:indexPath.row]];
            [MainDataArray  removeObjectAtIndex:indexValue];
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)MainDataArray.count];
        }
        else {
            [MainDataArray  addObject:[prductArray objectAtIndex:indexPath.row]];
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)MainDataArray.count];
        }
        [tblSupplements reloadData];
    }
    else{
        shopProductInfo *productInfo=[[shopProductInfo alloc]init];
        productInfo.productData=[jsonData objectAtIndex:indexPath.row] ;
        // productInfo.uid=[NSString stringWithFormat:@"%d",currentProduct.uid ];
        [self.navigationController pushViewController:productInfo animated:YES];
    }
}
-(void)userSelclected:(UIButton *)senderBtn {
    selectedUser=(int)senderBtn.tag;
    [tblSupplements reloadData];
}

int cartSelectedCount=0;
-(void)yourButtonClicked:(UIButton *)sender {
    [self.view endEditing:YES];
    blockedView.hidden=NO;
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[recommend2 class]] || [viewController isKindOfClass:[DietPlanController class]]) {
            temp=[SingletonClass singleton].cartSelectedProduct;
            flag=YES;
            break;
        }
    }
    if (flag==NO) {
        temp=[SingletonClass singleton].ShopSelectedProduct;
    }
    selectedButton = sender;
    selectedButton = sender;
    pid=[[prductArray objectAtIndex:selectedButton.tag]valueForKey:@"uid"];
    ProductRecommend *productNew =[prductArray objectAtIndex:selectedButton.tag];
    productNew.quantity = qtyStore;
    [prductArray replaceObjectAtIndex:selectedButton.tag withObject:productNew];
    // [self addToCart];
    BOOL Found = NO;
    for (int i=0; i<temp.count; i++) {
        if ([[[temp objectAtIndex:i] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:selectedButton.tag] valueForKey:@"title"]]) {
            Found = YES;
            //Deleting from sever
            
            [temp removeObjectAtIndex:i];
            [tblSupplements reloadData];
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)temp.count];
            if (flag==NO) {
                [SingletonClass singleton].ShopSelectedProduct=temp;
                [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:YES];
            }
            break;
        }
        
    }
    if(flag==YES && Found==NO) {
        [[SingletonClass singleton].cartSelectedProduct addObject:[prductArray objectAtIndex:selectedButton.tag]];
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
        [tblSupplements reloadData];
    }
    
    else if (!Found) {
        blockedView.hidden=NO;
        [UIView animateWithDuration:0.5 animations:^{
            pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y-pickerViewBg.frame.size.height, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
        }];
    }
}
- (IBAction)doneBtn:(UIButton *)sender {
    blockedView.hidden=YES;
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[recommend2 class]]) {
            flag=YES;
        }
    }
    if (flag==NO){
        pid=[[prductArray objectAtIndex:selectedButton.tag]valueForKey:@"uid"];
        ProductRecommend *productNew =[prductArray objectAtIndex:selectedButton.tag];
        productNew.quantity = qtyStore;
        if (qtyStore==0) {
            productNew.quantity=1;
        }
        [prductArray replaceObjectAtIndex:selectedButton.tag withObject:productNew];
        // [self addToCart];
        BOOL Found = NO;
    if ([SingletonClass singleton].ShopSelectedProduct.count!=0) {
        for (int i=0; i<[SingletonClass singleton].ShopSelectedProduct.count; i++) {
            if ([[[[SingletonClass singleton].ShopSelectedProduct objectAtIndex:i] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:selectedButton.tag] valueForKey:@"title"]]) {
                cartSelectedCount--;
                Found = YES;
                //Deleting from sever
                [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:YES];
                [[SingletonClass singleton].ShopSelectedProduct removeObjectAtIndex:i];
                [selectedButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
            }
        }
        if (!Found) {
            cartSelectedCount++;
            //Deleting from sever
            [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:NO];
            [[SingletonClass singleton].ShopSelectedProduct addObject:[prductArray objectAtIndex:selectedButton.tag]];
            [selectedButton setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
        }
    }
    else{			
        cartSelectedCount++;
        [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:NO];
        [[SingletonClass singleton].ShopSelectedProduct addObject:[prductArray objectAtIndex:selectedButton.tag]];
        [selectedButton setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
        
        
    }
    
    
    lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
    
    [UIView animateWithDuration:0.5 animations:^{
        pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y+pickerViewBg.frame.size.height, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
    }];
        [tblSupplements reloadData];
    }
    else{
        pid=[[prductArray objectAtIndex:selectedButton.tag]valueForKey:@"uid"];
        ProductRecommend *productNew =[prductArray objectAtIndex:selectedButton.tag];
        productNew.quantity = qtyStore;
        if (qtyStore==0) {
            productNew.quantity=1;
        }
        [prductArray replaceObjectAtIndex:selectedButton.tag withObject:productNew];
        // [self addToCart];
        BOOL Found = NO;
        
        if ([SingletonClass singleton].cartSelectedProduct.count!=0) {
            for (int i=0; i<[SingletonClass singleton].cartSelectedProduct.count; i++) {
                if ([[[[SingletonClass singleton].cartSelectedProduct objectAtIndex:i] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:selectedButton.tag] valueForKey:@"title"]]) {
                    cartSelectedCount--;
                    Found = YES;
                    //Deleting from sever
                    [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:YES];
                    [[SingletonClass singleton].cartSelectedProduct removeObjectAtIndex:i];
                    [selectedButton setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
                }
                
            }
            if (!Found) {
                cartSelectedCount++;
                //Deleting from sever
                [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:NO];
                
                [[SingletonClass singleton].cartSelectedProduct addObject:[prductArray objectAtIndex:selectedButton.tag]];
                [selectedButton setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
                
            }
        }
        else{
            cartSelectedCount++;
            [self PostToUpdateTheProductToWeb:[prductArray objectAtIndex:selectedButton.tag] Delete:NO];
            [[SingletonClass singleton].cartSelectedProduct addObject:[prductArray objectAtIndex:selectedButton.tag]];
            [selectedButton setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
            
            
        }
        
        
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
        
        [UIView animateWithDuration:0.5 animations:^{
            pickerViewBg.frame = CGRectMake(0, pickerViewBg.frame.origin.y+pickerViewBg.frame.size.height, pickerViewBg.frame.size.width, pickerViewBg.frame.size.height);
        }];

    }
}
#pragma supplements api*************************************************


-(void)callDataFormServer
{
    if ([_searchText.text isEqualToString:@""]) {
        _msgLabel.text=@"No Result found!";
        _errorIcon.hidden=NO;
        [self.view endEditing:YES];
        tblSupplements.hidden=YES;
        return;
    }
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *urlString=[NSString stringWithFormat:@"https://www.wellbeingnetwork.com/api?call=search&type=product&mobile=true&term=%@",
                         [[_searchText.text stringByReplacingOccurrencesOfString:@" " withString:@"%"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSDictionary *inputDic=[NSDictionary dictionary];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        [[NSUserDefaults standardUserDefaults]setObject:_searchText.text forKey:@"shopTextField"];
        if (json !=nil && json.allKeys.count!=0) {
            if ([json objectForKey:@"items"] !=nil) {
                
                 [hudFirst hide:YES];
                if ([[json objectForKey:@"items"] isEqual:[NSNull null]] || [[json objectForKey:@"items"] count]==0) {
                    _msgLabel.text=@"No Result found!";
                    _errorIcon.hidden=NO;
                    [self.view endEditing:YES];
                    tblSupplements.hidden=YES;
                }
                
                else {
                    jsonData=[[json objectForKey:@"items"]mutableCopy];
                    tblSupplements.hidden=NO;
                     [self.view endEditing:YES];
                    [self loadProductToProducts:[json objectForKey:@"items"]];
                }
                // NSArray *tempData=[json objectForKey:@"items"];
                
               
                
            }
            else{
                [Globals alert:@"error"];
                 [self.view endEditing:YES];
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
         [self.view endEditing:YES];
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
        product.quantity=1;
        [imageArr addObject:product.image];
        [prductArray addObject:product];
    }
    [Globals saveUserImagesIntoCache:imageArr];
    [tblSupplements reloadData];
}

- (IBAction)btnCart:(id)sender {
    BOOL flag3=NO;
    //    [SingletonClass singleton].cartSelectedProduct=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommendBundleEditing class]] ) {
            recommendBundleEditing *tom = (recommendBundleEditing*)viewController;
            [self.navigationController popToViewController:tom animated:YES];
            flag3=YES;
            break;
        }
    }
    
    if (flag3==NO) {
    [SingletonClass singleton].ShopSelectedProduct=[[SingletonClass singleton].ShopSelectedProduct mutableCopy];
    [SingletonClass singleton].cartSelectedProduct=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
    if (flagScreen==NO){
    shopCheckoutController *recommend=[[shopCheckoutController alloc]init];
    [self.navigationController pushViewController:recommend animated:YES];
    }
    else{
       
        setRecommendReminder *recommend1=[[setRecommendReminder alloc]init];
        [self.navigationController pushViewController:recommend1 animated:YES];
    }
    }
}

- (IBAction)back:(id)sender {
   // [SingletonClass singleton].cartSelectedProduct=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
[SingletonClass singleton].ShopSelectedProduct=[[SingletonClass singleton].ShopSelectedProduct mutableCopy];
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
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
        urlString =[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api?call=cart&method=cartadd&pid=%i&quantity=%i&token=%i",product.uid,product.quantity,token];
    }
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        if ([responseObject objectForKey:@"cart"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"cart"] objectForKey:@"token"] forKey:@"tokenIdShop"];
        }
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];    }];
}
#pragma mark- picker view****************************************************************
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    //lablQty.text=[NSString stringWithFormat:@"%lu",row];
    qtyStore = (int)row+1;
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 9;
    
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%li",row+1];
}

- (IBAction)search:(id)sender {
    [self callDataFormServer];
    [self.view endEditing:YES];
    jsonData = [SingletonClass singleton].shopSearchSelected;
    blockedView.hidden=YES;
    [jsonData removeAllObjects];
}
     
- (void)add:(UIButton *)sender {
    for (UIViewController* viewController in [self.navigationController.viewControllers reverseObjectEnumerator]) {
        
        NSString *className = NSStringFromClass([viewController class]);
        if ([className isEqualToString: @"CreateDietPlanDinner"]) {
            [[SingletonClass singleton].dinnerdietPlanBundelSuppliment removeAllObjects];
            if ([SingletonClass singleton].dinnerdietPlanBundelSuppliment.count ==0) {
                [SingletonClass singleton].dinnerdietPlanBundelSuppliment = [MainDataArray mutableCopy];
            }
            else{
                [SingletonClass singleton].dinnerdietPlanBundelSuppliment =  [[[SingletonClass singleton].dinnerdietPlanBundelSuppliment arrayByAddingObjectsFromArray:MainDataArray] mutableCopy];
            }
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
        if ([className isEqualToString: @"CreateDietPlanDSnacks"]) {
            [[SingletonClass singleton].snaksdietPlanBundelSuppliment removeAllObjects];
            if ([SingletonClass singleton].snaksdietPlanBundelSuppliment.count ==0) {
                [SingletonClass singleton].snaksdietPlanBundelSuppliment = [MainDataArray mutableCopy];
            }
            else{
                [SingletonClass singleton].snaksdietPlanBundelSuppliment = [[[SingletonClass singleton].snaksdietPlanBundelSuppliment arrayByAddingObjectsFromArray:MainDataArray] mutableCopy];
            }
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
        if ([className isEqualToString: @"CreateDietPlanLunch"]) {
            [[SingletonClass singleton].lunchdietPlanBundelSuppliment removeAllObjects];
            if ([SingletonClass singleton].lunchdietPlanBundelSuppliment.count ==0) {
                [SingletonClass singleton].lunchdietPlanBundelSuppliment = [MainDataArray mutableCopy];
            }
            else{
                [SingletonClass singleton].lunchdietPlanBundelSuppliment =  [[[SingletonClass singleton].lunchdietPlanBundelSuppliment arrayByAddingObjectsFromArray:MainDataArray] mutableCopy];
            }
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
        if ([className isEqualToString: @"CreateDietPlan"]) {
            [[SingletonClass singleton].breakfastdietPlanBundelSuppliment removeAllObjects];
            if ([SingletonClass singleton].breakfastdietPlanBundelSuppliment.count ==0) {
                [SingletonClass singleton].breakfastdietPlanBundelSuppliment = [MainDataArray mutableCopy];
            }
            else{
                [SingletonClass singleton].breakfastdietPlanBundelSuppliment =  [[[SingletonClass singleton].breakfastdietPlanBundelSuppliment arrayByAddingObjectsFromArray:MainDataArray] mutableCopy];
            }
                //            NSMutableArray *singleton=[[SingletonClass singleton].breakfastdietPlanBundelSuppliment mutableCopy];
                //            singleton =[[[SingletonClass singleton].breakfastdietPlanBundelSuppliment arrayByAddingObjectsFromArray:MainDataArray] mutableCopy];
            [self.navigationController popToViewController:viewController animated:YES];
            return;
        }
             if ([className isEqualToString: @"DietPlanCustonise"]) {
                 [self.navigationController popToViewController:viewController animated:YES];
             }
            //        if ([viewController isKindOfClass:[CreateDietPlan class]] || [viewController isKindOfClass:[CreateDietPlanLunch class]] || [viewController isKindOfClass:[CreateDietPlanDSnacks class]] || [viewController isKindOfClass:[CreateDietPlanDinner class]]   ) {
             //            [self.navigationController popToViewController:viewController animated:YES];
             //            return;
             //        }
         }
         
         
         [self. navigationController popViewControllerAnimated:YES];
     }
@end
