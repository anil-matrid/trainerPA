//
//  setRecommendReminder.m
//  TrainerVate
//
//  Created by Matrid on 31/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "setRecommendReminder.h"
#import "recommend1.h"
#import "Constants.h"

@interface setRecommendReminder () {
    NSMutableArray *cartArray;
    int selectedUser;
    NSString *tempString;
    int selectedCell;
     NSString *jsonValue;
    NSMutableDictionary *updatedCartData;
    NSString *save;
    NSMutableDictionary *data1;
    NSMutableArray *data2;
    ProductRecommend *product;
    int selectedQuantity;
    NSString *uidStr;
   
}

@end

@implementation setRecommendReminder
@synthesize cartArray;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(IS_IPHONE_5_OR_MORE) {
        self = [super initWithNibName:@"setRecommendReminder" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"setRecommendReminder_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Set Recommend Reminder"];
    // Do any additional setup after loading the view from its nib.
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
    _productInfoView.hidden=YES;
    _viewSucces.hidden=YES;
    _ViewError.hidden=YES;
    _btnFinish.layer.cornerRadius=10;
    _btnReminder.layer.cornerRadius=10;
    selectedUser=-1;
    tempString=@"1";
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    updatedCartData=[[NSMutableDictionary alloc]init];
    data1=[[NSMutableDictionary alloc]init];
    data2=[[NSMutableArray alloc]init];
    cartArray=[[NSMutableArray alloc]init];
    cartArray=[SingletonClass singleton].cartSelectedProduct;
   [self calculateTotalValue];
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
    }
- (void)viewWillAppear:(BOOL)animated {
//    [self callDataFormServer];
    BOOL flag=NO;
    NSArray *viewContrlls = self.navigationController.viewControllers;
    for (int i=0; i<viewContrlls.count; i++) {
        UIViewController * controller = [viewContrlls objectAtIndex:i];
        if ([controller isKindOfClass:[MyClientController class]]) {
            _lblHide.hidden=NO;
            _btnCheckBox.hidden=NO;
            flag=YES;
        }
    }
    if (flag==NO) {
        _lblHide.hidden=YES;
        _btnCheckBox.hidden=YES;
        CGRect frame = _viewPrice.frame;
        frame.origin.y = frame.origin.y+200;
        _viewPrice.frame=frame;
        frame=_reminderProductTable.frame;
        frame.size.height=frame.size.height+200;
        _reminderProductTable.frame=frame;
    }

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

#pragma table view method*******************************************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (cartArray==nil) {
        _lblError.hidden=NO;
    }
    else{
        _lblError.hidden=YES;
    }
    _lblCount.text=[NSString stringWithFormat:@"%lu",(unsigned long)cartArray.count];
    return cartArray.count;
}
int count=0;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    CustomRecommendCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell==0) {
        NSArray *myArray=[[NSBundle mainBundle]loadNibNamed:@"CustomRecommendCellTableViewCell" owner:self options:nil];
        cell=[myArray objectAtIndex:0];
    }
    product=[cartArray objectAtIndex:indexPath.row];
    
    cell.title.text=product.title;
    if ([[NSString stringWithFormat:@"%i",product.quantity] isEqualToString:@"0"]) {
        cell.qty.text=@"1";
        cell.price.text=[NSString stringWithFormat:@"%.2f",product.price*1];
    }
    else {
        cell.qty.text=[NSString stringWithFormat:@"%i",product.quantity];
         cell.price.text=[NSString stringWithFormat:@"%.2f",product.price*product.quantity];
    }
   
    [cell.addRemove addTarget:self action:@selector(addOrRemove:) forControlEvents:UIControlEventTouchUpInside];
    [cell.remove addTarget:self action:@selector(ReomveCell:) forControlEvents:UIControlEventTouchUpInside];
//  cell.imageView.image=[UIImage imageNamed:@"tick.png"];
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
    [cartArray removeObjectAtIndex:sender.tag];
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
    product=[cartArray objectAtIndex:sender.tag];
    _productName.text=product.title;
    _productImage.image=[Globals getImagesFromCache:product.image];
    selectedQuantity = product.quantity;
    _productQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
    selectedCell=(int)sender.tag;
    _done.layer.cornerRadius=_done.bounds.size.height/2;
  
}
-(void)addSuppliment
{
    NSLog(@"add suppliment");
}


- (IBAction)btnBasketForAll:(id)sender {
    if ([sender tag]==1 || [sender tag]==3) {
        [SingletonClass singleton].cartSelectedProduct=[cartArray mutableCopy];
    
        [self.navigationController popViewControllerAnimated:YES];
    }
  
    else if ([sender tag]==2){
        //basket icon button
    }
    else if ([sender tag]==20){
        [SingletonClass singleton].cartSelectedProduct=[cartArray mutableCopy];
        recommendReminderController *remind=[[recommendReminderController alloc]init];
        remind.uidStr=uidStr;
        remind.bundelName=[[NSString alloc]init];
        remind.bundelName=_txtBundleName.text;
        [self.navigationController pushViewController:remind animated:YES];
    }
    else if ([sender tag]==4){
        
        if (cartArray==nil || cartArray.count==0) {
            [self.view endEditing:YES];
            _ViewError.hidden=NO;
            _bluredView.hidden=NO;
            [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
            _lblMessages.text=@"Please select at-least one product";
            return;
        }
                   for (int j=0;j<cartArray.count;j++) {
                NSMutableDictionary *data;
                data=[[NSMutableDictionary alloc]init];

                product=[cartArray objectAtIndex:j];
                [data setObject:[NSString stringWithFormat:@"%.2d",product.uid] forKey:@"product_id"];
                [data setObject:[NSString stringWithFormat:@"%i",product.quantity]forKey:@"Qty"];
                [data2 addObject:data];
                data=nil;
                
            }
        [data1 setObject:_txtBundleName.text forKey:@"bundle_name"];
        [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"trainer_id"];
        NSArray *viewContrlls = self.navigationController.viewControllers;
        BOOL flag=NO;
        for (int i=0; i<viewContrlls.count; i++) {
            UIViewController * controller = [viewContrlls objectAtIndex:i];
            if ([controller isKindOfClass:[MyClientController class]]) {
                [data1 setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"] forKey:@"uid"];
                [data1 setObject:save forKey:@"save_recommendation"];
                flag=YES;
        }
        }
        if (!flag) {
            [data1 setObject:@"1" forKey:@"save_recommendation"];
            [data1 setObject:@"1" forKey:@"flag"];
        }
                [data1 setObject:[data2 mutableCopy] forKey:@"Product_Name"];
        NSError* error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data1
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        jsonValue = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [data1 removeAllObjects];
        [data2 removeAllObjects];
        NSString* result = [_txtBundleName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([result isEqualToString:@""] || _txtBundleName == nil) {
            _bluredView.hidden=NO;
            _ViewError.hidden=NO;
            _lblMessages.text=@"Bundle Name must not be empty!";
            [self.view endEditing:YES];
            [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
            [_bluredView bringSubviewToFront:_productInfoView];
            return;
        }
        else {
            [self callDataFormServer];
        }
    }
    else if ([sender tag]==5){
        _productInfoView.hidden=YES;
        _bluredView.hidden=YES;
        ProductRecommend *productNew = [cartArray objectAtIndex:selectedCell];
        productNew.quantity = selectedQuantity;
        [cartArray replaceObjectAtIndex:selectedCell withObject:productNew];
        [_reminderProductTable reloadData];
        [self calculateTotalValue];
      

    }
    else if ([sender tag]==8) {
        UIImage *selectedImg=[UIImage imageNamed:@"tick.png"];
        UIImage *currentImage = [_btnCheckBox imageForState:UIControlStateNormal];
        NSData *img1 = UIImagePNGRepresentation(selectedImg);
        NSData *img2 = UIImagePNGRepresentation(currentImage);
            if (![img1 isEqual:img2]) {
                [_btnCheckBox setBackgroundColor:[UIColor clearColor]];
                [_btnCheckBox setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
                save=@"1";
                
            }
            else {
                [_btnCheckBox setBackgroundColor:[UIColor clearColor]];
                [_btnCheckBox setImage:[UIImage imageNamed:@"tick2.png"] forState:normal];
                save=@"0";
                
            }

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
-(void)calculateTotalValue {
    // calculating the total price
    float totalValue=0;
    for (int i=0; i<cartArray.count; i++) {
        ProductRecommend *prod=[cartArray objectAtIndex:i];
        if (prod.quantity==0) {
            totalValue =totalValue + (1*prod.price);
        }
        else {
            totalValue =totalValue + (prod.quantity*prod.price);
        }
        
    }
    _totalPrice.text=[NSString stringWithFormat:@"%.2f",totalValue];
}
int incre=0;
- (IBAction)btnIncrease:(id)sender {
   // product=[cartArray objectAtIndex:selectedCell];
   // int productQt=product.quantity;
    if(selectedQuantity<10){
        selectedQuantity++;
    }
    _productQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
    
}
- (IBAction)btnDecrease:(id)sender {
    product=[cartArray objectAtIndex:selectedCell];
    //int productQt=product.quantity;
    if(selectedQuantity>1){
        selectedQuantity--;
    }
    _productQty.text=[NSString stringWithFormat:@"%i",selectedQuantity];
   // [cartArray replaceObjectAtIndex:selectedCell withObject:product];
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
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:KurlRecommendation apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:jsonValue,@"data", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                    [hudFirst hide:YES];
                    [self.view endEditing:YES];
                    BOOL flag=NO;
                    for (UIViewController* viewController in self.navigationController.viewControllers) {
                        if ([viewController isKindOfClass:[recommend class]] ) {
                            _viewSucces.hidden=NO;
                            _bluredView.hidden=NO;
                            uidStr=[json valueForKey:@"recommendation_id"];
                            flag=YES;
                        }
                    }
                    if (flag==NO) {
                        SentToClientController *client=[[SentToClientController alloc] init];
                        client.recommendId=[json valueForKey:@"bundle_id"];
                        client.preClass=@"recomend1";
                        [self.navigationController pushViewController:client animated:YES];
                    }
                }
            else if([[json objectForKey:@"status_code"] isEqual:@"E_DUPLICATE"]) {
                _bluredView.hidden=NO;
                _ViewError.hidden=NO;
                [self.view endEditing:YES];
                [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
                _lblMessages.text=@"This Bundle name already exists in your account!";
                [hudFirst hide:YES];
            }
            else if([[json objectForKey:@"status_code"] isEqual:@"E_PRE_DUPLICATE"]) {
                _bluredView.hidden=NO;
                _ViewError.hidden=NO;
                [self.view endEditing:YES];
                [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
                _lblMessages.text=@"This bundle name already exists in pre-made bundles!";
                [hudFirst hide:YES];
            }
            [hudFirst hide:YES];
        }
        else {
            [self.view endEditing:YES];
            _bluredView.hidden=NO;
            _ViewError.hidden=NO;
            [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
            _lblMessages.text=@"Sorry! Internal Server Error.";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [self.view endEditing:YES];
        _bluredView.hidden=NO;
        _ViewError.hidden=NO;
        [Globals showBounceAnimatedView:self.ViewError completionBlock:nil];
        _lblMessages.text=@"Sorry! Internal Server Error.";
        
    }];
    
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
    [_btnCheckBox setBackgroundColor:[UIColor clearColor]];
    [_btnCheckBox setImage:[UIImage imageNamed:@"tick.png"] forState:normal];
    save=@"1";
    _scrollViews.scrollEnabled = YES;
    
}


- (void)keyboardDidHide: (NSNotification *) notif {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    _scrollViews.scrollEnabled = NO;
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}



- (IBAction)ok:(id)sender {
    if (cartArray==nil || cartArray.count==0) {
        _errorView.hidden=YES;
        _bluredView.hidden=YES;
        return;
    }
    _bluredView.hidden=YES;
    _errorView.hidden=YES;
    
    NSArray *viewContrlls = self.navigationController.viewControllers;
    BOOL flag=NO;
    for (int i=0; i<viewContrlls.count; i++) {
        UIViewController * controller = [viewContrlls objectAtIndex:i];
        if ([controller isKindOfClass:[MyClientController class]]) {
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
        flag=YES;
        }
    }
    if (!flag) {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            //This if condition checks whether the viewController's class is MyGroupViewController
            // if true that means its the MyGroupViewController (which has been pushed at some point)
            if ([viewController isKindOfClass:[recommend1 class]] ) {
                
                // Here viewController is a reference of UIViewController base class of MyGroupViewController
                // but viewController holds MyGroupViewController  object so we can type cast it here
                recommend1 *groupViewController = (recommend1*)viewController;
                [self.navigationController popToViewController:groupViewController animated:YES];
            }
        }
    }
}
- (IBAction)cross:(id)sender {
    _bluredView.hidden=YES;
    _productInfoView.hidden=YES;
}
@end
