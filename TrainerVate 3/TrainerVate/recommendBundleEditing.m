//
//  recommendBundleEditing.m
//  TrainerVate
//
//  Created by Matrid on 04/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "recommendBundleEditing.h"
#import "Constants.h"


@interface recommendBundleEditing (){

    ProductRecommend *product;
    NSMutableDictionary *data1;
    NSMutableArray *data2;
    int selectedCell;
    int senderTag;
    NSMutableArray *pidValue;
    int qty;
    NSString *jsonData;
    int selectedQuantity;
}

@end

@implementation recommendBundleEditing
@synthesize isClient,bundelName,RecommendID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"recommendBundleEditing_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        self = [super initWithNibName:@"recommendBundleEditing" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"recommendBundleEditing_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Recommend Bundle Editing"];
    // Do any additional setup after loading the view from its nib.
    selectedQuantity = 0;
    data2=[[NSMutableArray alloc]init];
    _btnDone.layer.cornerRadius=10;
    _setREminder.layer.cornerRadius=_setREminder.frame.size.height/2;
    _finish.layer.cornerRadius=_finish.frame.size.height/2;
    _reminerView.hidden=YES;
    [self.view bringSubviewToFront:_viewInfoProduct];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewWillAppear:(BOOL)animated {
    //[self getproduct];

    _viewBlured.hidden=YES;
    _lblError.hidden=YES;
    _lblToHide.hidden=YES;
    _errorView.hidden=YES;
    _viewInfoProduct.hidden=YES;
    senderTag=0;
    NSArray *viewContrlls = self.navigationController.viewControllers;
    BOOL flag=NO;
    for (int i=0; i<viewContrlls.count; i++) {
        UIViewController * controller = [viewContrlls objectAtIndex:i];
        if ([controller isKindOfClass:[MyClientController class]]) {
            _saveSend.hidden=NO;
            _save.hidden=YES;
            _send.hidden=YES;
            flag=YES;
        }
    }
    if (!flag) {
        _saveSend.hidden=YES;
        _save.hidden=NO;
        _send.hidden=NO;
    }

    [self.tblRecommendeBundle reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView methods**********************************************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [SingletonClass singleton].cartSelectedProduct.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpletable = @"simpleTableCell";
    CustomRecommendCellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:simpletable];
    if (cell == nil) {
        NSArray *temp=[[NSBundle mainBundle]loadNibNamed:@"CustomRecommendCellTableViewCell" owner:self options:nil];
        cell = [temp objectAtIndex:0];
    }
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 77, 320, 3)];
    [header2 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
  
        product=[[SingletonClass singleton].cartSelectedProduct objectAtIndex:indexPath.row];
        NSString  *str = [NSString stringWithFormat:@"%d",product.quantity];;
        int number = [str intValue];
        cell.qty.text=str;
        cell.price.text=[NSString stringWithFormat:@"%.2f",product.price*number];
        cell.title.text=product.title;
        cell.imgProduct.contentMode = UIViewContentModeScaleAspectFit;
        cell.imgProduct.image=[Globals getImagesFromCache:product.image];
        cell.addRemove.tag=indexPath.row;
        cell.remove.tag=indexPath.row;
        [cell.addRemove addTarget:self action:@selector(addOrRemove:) forControlEvents:UIControlEventTouchUpInside];
        [cell.remove addTarget:self action:@selector(ReomveCell:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell addSubview:header2];
    
    return cell;
}

////////tableViews end........................


#pragma table & screens buttons actions*************************

- (void)ReomveCell:(UIButton *)sender{
    [[SingletonClass singleton].cartSelectedProduct removeObjectAtIndex:sender.tag];
    [_tblRecommendeBundle reloadData];
   
}
- (void)addOrRemove:(UIButton *)sender{
    _viewBlured.hidden=NO;
    _viewInfoProduct.hidden=NO;
    [Globals showBounceAnimatedView:self.viewInfoProduct completionBlock:nil];
    product=[[SingletonClass singleton].cartSelectedProduct objectAtIndex:sender.tag];
    selectedQuantity = product.quantity;
    _lblTitle.text=product.title;
    _imgProduct.image=[Globals getImagesFromCache:product.image];
    _lblQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
      selectedCell=(int)sender.tag;
}




- (IBAction)btnOk:(id)sender {
    _errorView.hidden=YES;
    _viewBlured.hidden=YES;
}

- (IBAction)btnBottom:(id)sender {
    if ([sender tag]==1) {
        senderTag=1;
        [self dataConverter];
        
    }
    else if([sender tag]==2) {
        senderTag=2;
        [self dataConverter];
    }
}

- (IBAction)btnIncrease:(id)sender {
   // product=[[SingletonClass singleton].cartSelectedProduct  objectAtIndex:selectedCell];
   // int productQt=product.quantity;
    if(selectedQuantity<10){
        selectedQuantity++;
       // selectedQuantity = product.quantity;
    }
    _lblQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
    //[[SingletonClass singleton].cartSelectedProduct replaceObjectAtIndex:selectedCell withObject:product];

}

- (IBAction)btnDecrease:(id)sender {
  //  product=[[SingletonClass singleton].cartSelectedProduct objectAtIndex:selectedCell];
  //  int productQt=product.quantity;
    if(selectedQuantity>1){
        selectedQuantity--;
    }
    _lblQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
   
}

- (IBAction)btnAll:(id)sender {
    if ([sender tag]==10) {
        [[SingletonClass singleton].cartSelectedProduct removeAllObjects];
        [[SingletonClass singleton].bundelSelectedProduct removeAllObjects];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([sender tag]==13) {
        shopController *shop=[[shopController alloc]init];
        [self.navigationController pushViewController:shop animated:YES];
    }
    else if ([sender tag]==3) {
        senderTag=3;
        [self dataConverter];
    }
    else if ([sender tag]==12) {
        _viewInfoProduct.hidden=YES;
        _viewBlured.hidden=YES;
        ProductRecommend *products = [[SingletonClass singleton].cartSelectedProduct objectAtIndex:selectedCell];
        products.quantity = selectedQuantity;
        [[SingletonClass singleton].cartSelectedProduct replaceObjectAtIndex:selectedCell withObject:product];
        [_tblRecommendeBundle reloadData];
        selectedQuantity = 1;
    }
   
}


#pragma api****************************************************************
 
-(void)callDataFormServer
{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSError *error;
    NSData *json = [NSJSONSerialization dataWithJSONObject:data1
                                                   options:0
                                                     error:&error];
     NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    // This will be the json string in the preferred format
    [data1 removeAllObjects];
    [data2 removeAllObjects];
    NSString *urlString;
  
    NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend1"] || senderTag==2) {
    urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:KurlgetBundleProductsEdits apiKey:[Globals apiKey]];
    }
    else if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend"]) {
        urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"getBundleProductsEdits2/" apiKey:[Globals apiKey]];
    }
    else{
        urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"CheckBundle/" apiKey:[Globals apiKey]];    }
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        
        if ([viewController isKindOfClass:[recommend class]] && [NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend1"]) {
            urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"CheckBundle/" apiKey:[Globals apiKey]];
            break;
        }
    }
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"data", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                jsonData=[json objectForKey:@"recommendation_id"];
                [hudFirst hide:YES];
                if (senderTag==2) {
                    SentToClientController *sent=[[SentToClientController alloc]init];
                    sent.bundleName=bundelName;
                    [self.navigationController pushViewController:sent animated:YES];
                }
                else if (senderTag==1) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [[SingletonClass singleton].bundelSelectedProduct removeAllObjects];
                    [[SingletonClass singleton].cartSelectedProduct removeAllObjects];
                    
                }
                else{
                    _viewBlured.hidden=NO;
                    _reminerView.hidden=NO;
                    [Globals showBounceAnimatedView:self.reminerView completionBlock:nil];
                }
            }
            else{
                if (senderTag==1) {
                    _viewBlured.hidden=NO;
                    _errorView.hidden=NO;
                    _lblError.hidden=NO;
                    _lblToHide.hidden=NO;
                    [Globals showBounceAnimatedView:self.errorView completionBlock:nil];

                    _lblMessage.text=@"This bundle already exists!";
                }
                [hudFirst hide:YES];
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _viewBlured.hidden=NO;
        _errorView.hidden=NO;
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        _lblMessage.text=@"Sorry! Internal Server Error.";
       
    }];
    
}



//CONVERTING ARRAY TO JSON STRING
- (void)dataConverter {
   
    for (int j=0;j<[SingletonClass singleton].cartSelectedProduct .count;j++) {
        NSMutableDictionary *data;
        data=[[NSMutableDictionary alloc]init];
        product=[[SingletonClass singleton].cartSelectedProduct  objectAtIndex:j];
        NSString *quantity=[NSString stringWithFormat:@"%i",product.quantity];
        NSString *uid=[NSString stringWithFormat:@"%i",product.uid];
        [data setObject:uid forKey:@"product_id"];
        [data setObject:quantity forKey:@"Qty"];
        [data2 addObject:data];
        data=nil;
        
    }
    data1=[[NSMutableDictionary alloc]init];
    // [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct objectForKey:@"bundelId"] forKey:@"bundle_id"];
    NSArray *viewContrllss = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    if ([NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend"]) {
        [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"trainer_id"];
        [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"name"] forKey:@"recommendation_id"];
    }
    else if ((senderTag==2 || senderTag==1) && ![NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend2"]) {
        [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"TrainerId"];
        [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"name"] forKey:@"BundleID"];
    }
    else{
        [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"trainer_id"];
        [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"name"] forKey:@"bundle_id"];
        [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"bName"] forKey:@"bundle_name"];
        [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] forKey:@"client_id"];
    }
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        
        if ([viewController isKindOfClass:[recommend class]] && [NSStringFromClass([viewContrllss class]) isEqualToString: @"recommend1"]) {
            [data1 removeAllObjects];
            [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"trainer_id"];
            [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"name"] forKey:@"bundle_id"];
            [data1 setObject:[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"bName"] forKey:@"bundle_name"];
            [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] forKey:@"client_id"];
            break;

        }
    }

    [data1 setObject:[data2 mutableCopy] forKey:@"Product_Name"];
    if ([data1 valueForKey:@"Product_Name"]==nil || [[data1 valueForKey:@"Product_Name"] count] == 0 ) {
        _errorView.hidden=NO;
        _lblError.hidden=NO;
        _lblToHide.hidden=NO;
        _viewBlured.hidden=NO;
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        _lblMessage.text=@"Please select at-least one product";
    }
        else {
         [self callDataFormServer];
    }
}

- (IBAction)cross:(id)sender {
    _viewBlured.hidden=YES;
    _viewInfoProduct.hidden=YES;
}


- (IBAction)setREminder:(id)sender {
    recommendReminderController *groupViewController = [[recommendReminderController alloc]init];
    groupViewController.uidStr=jsonData;
    [self.navigationController pushViewController:groupViewController animated:YES];

}

- (IBAction)finish:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
