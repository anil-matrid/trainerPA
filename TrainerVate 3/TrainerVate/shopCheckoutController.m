//
//  setRecommendReminder.m
//  TrainerVate
//
//  Created by Matrid on 31/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopCheckoutController.h"
#import "Constants.h"
#import "shopWebController.h"
@interface shopCheckoutController () {
    NSMutableArray *cartArray;
    int selectedUser;
    NSString *tempString;
    int selectedCell;
     NSString *jsonValue;
    NSMutableDictionary *updatedCartData;
    NSString *save;
    NSMutableDictionary *data1;
    NSMutableArray *data2;
 //   ProductRecommend *product;
    int selectedQuantity;
    int tokenId;
    NSString *uid;
   
}

@end

@implementation shopCheckoutController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"shopCheckoutController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"shopCheckoutController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"shopCheckoutController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _bluredView.hidden=YES;
    _productInfoView.hidden=YES;
    _ViewError.hidden=YES;
    selectedUser=-1;
    tempString=@"1";
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    updatedCartData=[[NSMutableDictionary alloc]init];
    data1=[[NSMutableDictionary alloc]init];
    data2=[[NSMutableArray alloc]init];
    cartArray=[[NSMutableArray alloc]init];
    //  cartArray=[SingletonClass singleton].ShopSelectedProduct;
    // [self calculateTotalValue];
    save=@"0";
    jsonValue = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    tokenId = [[[NSUserDefaults standardUserDefaults]objectForKey:@"shopToken"] intValue] ;
    [self PostCheckForServerCartToken];
}

-(void)PostCheckForServerCartToken {
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    NSString *urlString=[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartlist&token=%i",tokenId];
   // NSDictionary *dinputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerId,@"trainer_id", nil];
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        [self updateTheDicForUse:[responseObject objectForKey:@"cart"]];
        [self calculateTotalValue];
        [self.reminderProductTable reloadData];
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
    
}
-(void)updateTheDicForUse:(NSArray *)Array{
    for (int i=0; i<Array.count; i++) {
        NSDictionary *currentDic =[Array objectAtIndex:i];
        ProductRecommend *productNew=[[ProductRecommend alloc]init];
        productNew.descriptionPro = [currentDic objectForKey:@"desc"];
        productNew.image =[currentDic objectForKey:@"image"];
        productNew.price =[[currentDic objectForKey:@"price"] floatValue];
        productNew.quantity = [[currentDic objectForKey:@"quantity"] intValue];
        productNew.title =[currentDic objectForKey:@"title"];
        productNew.uid =[[currentDic objectForKey:@"uid"] intValue];
        [cartArray addObject:productNew];
    }
}
#pragma table view method*******************************************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (cartArray==nil || cartArray.count==0) {
        _lblError.hidden=NO;
    }
    else{
        _lblError.hidden=YES;
    }
    _lblCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)cartArray.count];
    return cartArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    CustomRecommendCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell==0) {
        NSArray *myArray=[[NSBundle mainBundle]loadNibNamed:@"CustomRecommendCellTableViewCell" owner:self options:nil];
        cell=[myArray objectAtIndex:0];
    }
    if (indexPath.row == 10) {
        
    }
    
    ProductRecommend *    product=[cartArray objectAtIndex:indexPath.row];
    //NSString *dd=[NSString stringWithFormat:@"%f.",product.price*product.quantity];
    cell.price.text=[NSString stringWithFormat:@"%.02f",product.price*product.quantity];
    //if (product.title != nil || product.title.length!=0) {
        cell.title.text=[NSString stringWithFormat:@"%@" ,[product.title isEqual:[NSNull class]] ?@"" :product.title];
    ;
    cell.imgProduct.image=[UIImage imageNamed:@"noimage.png"];

    cell.qty.text=[NSString stringWithFormat:@"%i" ,product.quantity];
    [cell.addRemove addTarget:self action:@selector(addOrRemove:) forControlEvents:UIControlEventTouchUpInside];
    [cell.remove addTarget:self action:@selector(ReomveCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    cell.imgProduct.image=[Globals getImagesFromCache:product.image];
    cell.addRemove.tag=indexPath.row;
    cell.remove.tag=indexPath.row;
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 77, 320, 5)];
    [header2 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    [cell addSubview:header2];
    
    return cell;
}

-(void)ReomveCell:(UIButton *)sender{
    [self.view endEditing:YES];
    ProductRecommend *prdtRec=[cartArray objectAtIndex:sender.tag];
    [self PostToUpdateTheProductToWeb:prdtRec Delete:YES];
  //  [cartArray removeObjectAtIndex:sender.tag];
    [_reminderProductTable reloadData];
    [self calculateTotalValue];
}
///////////tableView end................................


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addOrRemove:(UIButton *)sender{
    
  [self.view endEditing:YES];
    _productInfoView.hidden=NO;
    _bluredView.hidden=NO;
    [Globals showBounceAnimatedView:self.productInfoView completionBlock:nil];
    ProductRecommend *  product=[cartArray objectAtIndex:sender.tag];
    _productImage.image=[Globals getImagesFromCache:product.image];
    selectedQuantity = product.quantity;
    uid=[NSString stringWithFormat:@"%d",product.uid];
    _productQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
    selectedCell=(int)sender.tag;
}
-(void)addSuppliment
{
    NSLog(@"add suppliment");
}


- (IBAction)btnBasketForAll:(id)sender {
    if ([sender tag]==1 || [sender tag]==3) {
        [SingletonClass singleton].ShopSelectedProduct=[cartArray mutableCopy];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([sender tag]==4){
        
        if (cartArray==nil || cartArray.count==0) {
            [self.view endEditing:YES];
            _ViewError.hidden=NO;
            _bluredView.hidden=NO;
            [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
            _lblMessages.text=@"Please select at-least one product";
            _lblError.hidden=NO;
            return;
        }
        
        
        shopWebController *shopWeb=[[shopWebController alloc]init];
        [self.navigationController pushViewController:shopWeb animated:YES];
        //basket icon button
    }
  
    else if ([sender tag]==2){
        //basket icon button
    }
    else if ([sender tag]==20){
        recommendReminderController *remind=[[recommendReminderController alloc]init];
        [self.navigationController pushViewController:remind animated:YES];
    }
//    else if ([sender tag]==4){
//        
//                   for (int j=0;j<cartArray.count;j++) {
//                NSMutableDictionary *data;
//                data=[[NSMutableDictionary alloc]init];
//
//             ProductRecommend *   product=[cartArray objectAtIndex:j];
//                [data setObject:[NSString stringWithFormat:@"%.2d",product.uid] forKey:@"product_id"];
//                [data setObject:[NSString stringWithFormat:@"%i",product.quantity]forKey:@"Qty"];
//                [data2 addObject:data];
//                data=nil;
//                
//            }
//        [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"trainer_id"];
//        NSArray *viewContrlls = self.navigationController.viewControllers;
//        BOOL flag=NO;
//        for (int i=0; i<viewContrlls.count; i++) {
//            UIViewController * controller = [viewContrlls objectAtIndex:i];
//            if ([controller isKindOfClass:[MyClientController class]]) {
//                [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] forKey:@"uid"];
//                [data1 setObject:save forKey:@"save_recommendation"];
//                flag=YES;
//        }
//        }
//        if (!flag) {
//            [data1 setObject:@"1" forKey:@"save_recommendation"];
//            [data1 setObject:@"1" forKey:@"flag"];
//        }
//                [data1 setObject:[data2 mutableCopy] forKey:@"Product_Name"];
//        NSError* error = nil;
//        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data1
//                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                             error:&error];
//        jsonValue = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        [data1 removeAllObjects];
//        [data2 removeAllObjects];
//        [self callDataFormServer];
//        
//    }
    else if ([sender tag]==5){
        _productInfoView.hidden=YES;
        _bluredView.hidden=YES;
        ProductRecommend *productNew = [cartArray objectAtIndex:selectedCell];
        productNew.quantity = selectedQuantity;
        [cartArray replaceObjectAtIndex:selectedCell withObject:productNew];
        [self PostToUpdateTheProductToWeb:productNew Delete:NO];
//        [cartArray replaceObjectAtIndex:selectedCell withObject:productNew];
        [_reminderProductTable reloadData];
        [self calculateTotalValue];
//         NSString *urlString=[NSString stringWithFormat:@"%@%@%@%@%@", @"http://www.wellbeingnetwork.com/api/?call=cart&method=cartupdate&pid=",uid, @"&quantity=",[NSString stringWithFormat:@"%d",selectedQuantity],@"&token=",[NSString stringWithFormat:@"%d",tokenId]];
//        
//        // NSDictionary *dinputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerId,@"trainer_id", nil];
//        [Globals PostApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
//            [self updateTheDicForUse:[responseObject objectForKey:@"cart"]];
//            //        cartArray =[responseObject objectForKey:@"cart"];
//            [self calculateTotalValue];
//            [self.reminderProductTable reloadData];
//        } failure:^(NSError *error) {
//            
//        }];
//
    }
    else if ([sender tag]==21) {
        //This for loop iterates through all the view controllers in navigation stack.
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            //This if condition checks whether the viewController's class is MyGroupViewController
            // if true that means its the MyGroupViewController (which has been pushed at some point)
            if ([viewController isKindOfClass:[recommend class]] ) {
                
                // Here viewController is a reference of UIViewController base class of MyGroupViewController
                // but viewController holds MyGroupViewController  object so we can type cast it here
                recommend *groupViewController = (recommend*)viewController;
                [self.navigationController popToViewController:groupViewController animated:YES];
            }
        }

    }
    else if ([sender tag]==22) {
        _ViewError.hidden=YES;
        _bluredView.hidden=YES;
    }
    
}
-(void)calculateTotalValue
{
    // calculating the total price
    float totalValue=0;
    for (int i=0; i<cartArray.count; i++) {
        ProductRecommend *prod=[cartArray objectAtIndex:i];
        totalValue =totalValue + (prod.quantity*prod.price);
    }
    _totalPrice.text=[NSString stringWithFormat:@"%.2f",totalValue];
}

- (IBAction)btnIncrease:(id)sender {
   // product=[cartArray objectAtIndex:selectedCell];
   // int productQt=product.quantity;
    if(selectedQuantity<10){
        selectedQuantity++;
    }
    _productQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
    
}
- (IBAction)btnDecrease:(id)sender {
    if(selectedQuantity>1){
        selectedQuantity--;
    }
    _productQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
   // [cartArray replaceObjectAtIndex:selectedCell withObject:product];
}

#pragma supplements api*************************************************
-(void)callDataFormServer
{
    
}
#pragma keyboard methods**************************************************

- (void)setScrollviewOffset {
    
    if (IS_IPHONE_4_OR_LESS) {
        _scrollViews.contentSize = CGSizeMake(_scrollViews.frame.size.width,370);
    }
    else
    {
        _scrollViews.contentSize = CGSizeMake(_scrollViews.frame.size.width, 471);
    }
    
    
    
}
- (void)keyboardDidShow: (NSNotification *) notif {
    [self setScrollviewOffset];
    
    _scrollViews.scrollEnabled = YES;
    
}


- (void)keyboardDidHide: (NSNotification *) notif {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    _scrollViews.scrollEnabled = NO;
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}

- (IBAction)cross:(id)sender {
    _bluredView.hidden=YES;
    _productInfoView.hidden=YES;

}

-(void)PostToUpdateTheProductToWeb:(ProductRecommend *)products Delete:(BOOL)flag{
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    //products.uid = 2446;
    NSString *urlString;
    NSInteger indexValue=0;
    if (flag) {
        urlString =[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartdelete&pid=%i&token=%i",products.uid,tokenId];
      //  NSString *pid=[NSString stringWithFormat:@"%d",products.uid];
        for (int i=0; i<cartArray.count; i++) {
            ProductRecommend *product=[cartArray objectAtIndex:i];
            if (product.uid == products.uid) {
                indexValue=i;
            }
        }
        //indexValue =[[SingletonClass singleton].ShopSelectedProduct indexOfObject:pid];
        [cartArray removeObjectAtIndex:indexValue];
    }
    else{
        
        urlString = [NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartupdate&pid=%i&quantity=%i&token=%i",products.uid,products.quantity,tokenId];
        
    }
    
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}

@end
