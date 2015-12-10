//
//  recommendShopController.m
//  TrainerVate
//
//  Created by Matrid on 25/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "recommendShopController.h"
#import "Constants.h"
#import "shopProductInfo.h"
#import "CreateDietPlanLunch.h"
#import "CreateDietPlanDSnacks.h"
#import "CreateDietPlanDinner.h"

@interface recommendShopController () {
    
    NSMutableArray *prductArray;
    // NSMutableArray *[SingletonClass singleton].cartSelectedProduct;
    NSMutableArray *MainDataArray;
    NSArray *temp1;
    NSArray *jsonData;
    UITableView *tblSupplements;
}
@end

@implementation recommendShopController
@synthesize lablQty,preClass,uid,name;

- (void)viewDidLoad {
    productSelected =0;
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Recommend Shop Controller"];
    MainDataArray = [NSMutableArray array];
    jsonData = [[NSArray alloc]init];
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    // Do any additional setup after loading the view from its nib.
    // prductArray=[[NSMutableArray alloc]init];
    //[SingletonClass singleton].cartSelectedProduct=[NSMutableArray array];
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
    _headerTitle.text=name;
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]] ) {
            _cart.userInteractionEnabled=NO;
            _add.hidden=NO;
            lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].dietPlanBundelArray.count];
            flag=YES;
            break;
        }
    }
    
    if (flag==NO) {
        _add.hidden=YES;
        _cart.userInteractionEnabled=YES;
    }
    
    if (IS_IPHONE_5_OR_MORE) {
        if (_add.hidden==YES) {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 481)];
        }
        else {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 481-51)];
        }
    }
    else {
        if (_add.hidden==YES) {
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 393)];
        }
        else {
            CGRect frame=_add.frame;
            frame.origin.y=429;
            _add.frame=frame;
            tblSupplements=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 393-51)];
        }
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
    
    tblSupplements.rowHeight=81;
    [tblSupplements setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tblSupplements.delegate=self;
    tblSupplements.dataSource=self;
    [tblSupplements setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblSupplements];
    [self.view bringSubviewToFront:tblSupplements];

    if ([SingletonClass singleton].cartSelectedProduct.count != 0) {
        lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
        prductArray=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
    }
    prductArray=[[NSMutableArray alloc]init];
    [self callDataFormServer];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return prductArray.count;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"CreateDietPlan"]) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    else{
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *tableCell=@"myTableCell";
    supplementsCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
    
    if (cell==nil) {
        NSArray *myData=[[NSBundle mainBundle]loadNibNamed:@"supplementsCustomCell" owner:self options:nil];
        cell=[myData objectAtIndex:0];
    }
    ProductRecommend *currentProduct=[prductArray objectAtIndex:indexPath.row];
    for (int i=0; i<[SingletonClass singleton].dietPlanBundelArray.count; i++) {
        if ([[[[SingletonClass singleton].dietPlanBundelArray objectAtIndex:i ] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:indexPath.row] valueForKey:@"title"]]) {
            [cell.btnProduct setImage:[UIImage imageNamed:@"cart3@1x.png"]forState:UIControlStateNormal];
            productSelected++;
            
        }
    }
    for (int i=0; i<[SingletonClass singleton].cartSelectedProduct.count; i++) {
        if ([[[[SingletonClass singleton].cartSelectedProduct objectAtIndex:i ] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:indexPath.row] valueForKey:@"title"]]) {
            [cell.btnProduct setImage:[UIImage imageNamed:@"cart3@1x.png"]forState:UIControlStateNormal];
            productSelected++;
            
        }
    }
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]] ) {
            cell.btnProduct.hidden=YES;
            flag=YES;
            break;
        }
    }
    if (flag==NO) {
        cell.btnProduct.hidden=NO;
    }
    
    cell.lblPrice.text=[NSString stringWithFormat:@"%.2f",currentProduct.price];
    cell.lblProductName.text=currentProduct.title;
    cell.btnProduct.tag=indexPath.row;
    // NSString *imageName = currentProduct.image;
    cell.imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    cell.imgProduct.image=[Globals getImagesFromCache:currentProduct.image];
    
    
    [cell.btnProduct addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 77, 320, 5)];
    [header2 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    [cell addSubview:header2];
    
    NSString*te=[MainDataArray  valueForKey:@"title"];
    te=[[prductArray objectAtIndex:indexPath.row] valueForKey:@"title"];
    
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
        // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    else
    {
        cell.tick.image=nil;
    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    for (UIViewController* viewController in self.navigationController.viewControllers) {
//        if (![viewController isKindOfClass:[DietPlanController class]] ) {
//            return nil;
//        }
//    }
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL flag=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers) {

        if ([viewController isKindOfClass:[DietPlanController class]] ) {
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
            flag=YES;
            break;
        }
    }
    if (flag==NO) {
        shopProductInfo *tom = [[shopProductInfo alloc]init];
        NSMutableDictionary *dicSending =[[jsonData objectAtIndex:indexPath.row] mutableCopy];
        BOOL valueExists= NO;
        for (int i=0; i<[SingletonClass singleton].ShopSelectedProduct.count; i++) {
            ProductRecommend *product = [[SingletonClass singleton].ShopSelectedProduct objectAtIndex:i ];
            if (product.uid == [[dicSending objectForKey:@"uid"] intValue]) {
                valueExists = YES;
            }
            else{
                valueExists = NO;
            }
        }
        if (valueExists) {
        [dicSending setObject:@"Yes" forKey:@"cart"];
        }
        else {
            [dicSending setObject:@"No" forKey:@"cart"];
        }
        tom.productData=[dicSending mutableCopy];
        [self.navigationController pushViewController:tom animated:YES];
    }
}

int productSelected=0;
-(void)yourButtonClicked:(UIButton *)sender{
    NSArray *viewContrlls = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    ProductRecommend *currentProduct=[prductArray objectAtIndex:sender.tag];
    if ([NSStringFromClass([viewContrlls class]) isEqualToString: @"recommendBundleEditing"]) {
        if ([[[SingletonClass singleton].dietPlanBundelArray valueForKey:@"title"] containsObject:[currentProduct valueForKey:@"title"]]) {
            for (int i=0; i<[SingletonClass singleton].dietPlanBundelArray.count; i++) {
                NSArray *temp= [[SingletonClass singleton].dietPlanBundelArray objectAtIndex:i];
                if ([[temp valueForKey:@"title"]isEqualToString:[currentProduct valueForKey:@"title"]]) {
                    [[SingletonClass singleton].dietPlanBundelArray removeObjectAtIndex:i];
                }
            }
        }
        else {
            [[SingletonClass singleton].dietPlanBundelArray addObject: currentProduct];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    BOOL Found = NO;
    if ([SingletonClass singleton].cartSelectedProduct.count!=0) {
        for (int i=0; i<[SingletonClass singleton].cartSelectedProduct.count; i++) {
            if ([[[[SingletonClass singleton].cartSelectedProduct objectAtIndex:i] valueForKey:@"title"] isEqualToString:[[prductArray objectAtIndex:sender.tag] valueForKey:@"title"]]) {
                productSelected--;
                Found = YES;
                [[SingletonClass singleton].cartSelectedProduct removeObjectAtIndex:i];
                [sender setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
            }
            
        }
        if (!Found) {
            productSelected++;
            
            [[SingletonClass singleton].cartSelectedProduct addObject:[prductArray objectAtIndex:sender.tag]];
            [sender setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
            
        }
    }
    else{
        productSelected++;
        
        [[SingletonClass singleton].cartSelectedProduct addObject:[prductArray objectAtIndex:sender.tag]];
        [sender setImage:[UIImage imageNamed:@"cart3@1x.png"] forState:UIControlStateNormal];
        
        
    }
    lablQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
}

#pragma supplements api*************************************************
-(void)callDataFormServer
{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
                [self loadProductToProducts:[json objectForKey:@"items"]];
                jsonData=[json objectForKey:@"items"];
                // NSArray *tempData=[json objectForKey:@"items"];
                [tblSupplements reloadData];
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
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
        NSDictionary *currentDic=[response objectAtIndex:i];
        ProductRecommend *product=[ProductRecommend new];
        product.title=[currentDic valueForKey:@"title"];
        product.image=[currentDic valueForKey:@"image"];
        product.imageLarge=[currentDic valueForKey:@"image"];
        product.price=[[currentDic valueForKey:@"price"] floatValue];
        product.uid=[[currentDic valueForKey:@"uid"] intValue];
        product.descriptionPro=[currentDic valueForKey:@"desc"];
        product.quantity=1;
        [imageArr addObject:product.image];
        [prductArray addObject:product];
    }
    [Globals saveUserImagesIntoCache:imageArr];
}

-(void)updateTempData{
    
    
    if ([preClass isEqualToString:@"breakfast"]) {
        MainDataArray   = [[SingletonClass singleton].breakfastdietPlanBundelFood mutableCopy];
    }
    else if ([preClass isEqualToString:@"lunch"]){
        MainDataArray = [[SingletonClass singleton].lunchdietPlanBundelArray mutableCopy];
    }
    else if ([preClass isEqualToString:@"dinner"]){
        MainDataArray = [[SingletonClass singleton].dinnerdietPlanBundelArray mutableCopy];
    }
    else{
        MainDataArray = [[SingletonClass singleton].snaksdietPlanBundelArray mutableCopy];
    }
    
    for ( int i=0; i<prductArray.count; i++) {
        ProductRecommend * currentPro = [prductArray objectAtIndex:i];
        for (int j=0; j<MainDataArray.count; j++) {
            ProductRecommend *MainDic =[[MainDataArray objectAtIndex:j] mutableCopy];
            if ([MainDic isEqual:currentPro ]) {
                [prductArray replaceObjectAtIndex:i withObject:MainDic];
            }
        }
    }
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
        setRecommendReminder *recommend=[[setRecommendReminder alloc]init];
        [self.navigationController pushViewController:recommend animated:YES];
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)add:(id)sender {
    
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
            [self updateTheDietPlanMainSingletionUpdate];
            [self.navigationController popToViewController:viewController animated:YES];
        }
        
        
        
//        if ([viewController isKindOfClass:[CreateDietPlan class]] || [viewController isKindOfClass:[CreateDietPlanLunch class]] || [viewController isKindOfClass:[CreateDietPlanDSnacks class]] || [viewController isKindOfClass:[CreateDietPlanDinner class]]   ) {
//            [self.navigationController popToViewController:viewController animated:YES];
//            return;
//        }
    }

   
    [self. navigationController popViewControllerAnimated:YES];
}
-(void)updateTheDietPlanMainSingletionUpdate{
    NSMutableDictionary *dataDictionary=[[SingletonClass singleton].DietPlanSelected mutableCopy];
    NSMutableDictionary *currentDic;
    NSString *kayName=@"";
    NSString *dietPlanIndexPath=[[NSUserDefaults standardUserDefaults] objectForKey:@"indexPath"];
    NSMutableArray *currentArry;
    
    if ([dietPlanIndexPath isEqualToString:@"0"]) {
        currentDic=[[dataDictionary objectForKey:@"breakfast"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"breakfast";
    }
    else if ([dietPlanIndexPath isEqualToString:@"1"]){
        currentDic=[[dataDictionary objectForKey:@"lunch"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"lunch";
    }
    else if ([dietPlanIndexPath isEqualToString:@"2"]){
        currentDic=[[dataDictionary objectForKey:@"snack"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"snack";
    }
    else if ([dietPlanIndexPath isEqualToString:@"3"]){
        currentDic=[[dataDictionary objectForKey:@"dinner"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"dinner";
    }
    for (int i=0; i<MainDataArray.count; i++) {
        [MainDataArray replaceObjectAtIndex:i withObject:[self updateDietPlanSupplementDIc:[MainDataArray objectAtIndex:i]]];
    }
    for (int i =0; i<MainDataArray.count; i++) {
        NSDictionary *preDic=[MainDataArray objectAtIndex:i];
        if (![currentArry containsObject:preDic]) {
            [currentArry addObject:preDic];
        }
    }
    // currentArry = [[currentArry arrayByAddingObjectsFromArray:MainArrayData] mutableCopy];
    [currentDic setObject:currentArry forKey:@"supplement"];
    [dataDictionary setObject:currentDic forKey:kayName];
    [SingletonClass singleton].DietPlanSelected = [dataDictionary mutableCopy];
}
-(NSMutableDictionary *)updateDietPlanSupplementDIc:(ProductRecommend *)Product{
    
    NSMutableDictionary *currentDic=[NSMutableDictionary dictionary];
    [currentDic setObject:[NSString stringWithFormat:@"%i",Product.uid] forKey:@"item_id"];
    [currentDic setObject:Product.title forKey:@"name"];
    [currentDic setObject:@"0" forKey:@"kcal"];
    [currentDic setObject:@"1" forKey:@"quantity"];
    [currentDic setObject:@"1" forKey:@"supplement"];
    
    return currentDic;
}

@end
