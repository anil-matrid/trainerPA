//
//  shopProductInfo.m
//  TrainerVate
//
//  Created by Matrid on 27/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopProductInfo.h"
#import "productFooterInfoCell.h"
#import "productInfoViewHeader.h"
#import "productGoodForCell.h"
#import "Constants.h"
#import "recommend1.h"
#import "recommend2.h"
@interface shopProductInfo () {
   
    NSArray *GoodForArray;
    CGRect newFrame;
    CGSize size;
    NSMutableArray *tre;
    BOOL flag1;
    BOOL isRecommend;
    UITableView *table;
    NSString *isRemove;
    
}

@end

@implementation shopProductInfo
@synthesize uid,productInfo,productGoodFor,productGoodFor1,productGoodFor2,productImage,productNAme,productPrice,productData;
- (void)viewDidLoad {
    [super viewDidLoad];
    GoodForArray=[[NSArray alloc]init];
    tre=[[NSMutableArray alloc]init];
    
    if (IS_IPHONE_5_OR_MORE) {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 79, 320, 490)];
    }
    else {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 79, 320, 402)];
    }
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=81;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    [self.view bringSubviewToFront:table];
    
}

-(void)viewWillAppear:(BOOL)animated {
    isRecommend=NO;
    flag1=NO;
    [table reloadData];
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        if ([viewController isKindOfClass:[recommend class]] || [viewController isKindOfClass:[recommend1 class]] || [viewController isKindOfClass:[recommend2 class]]) {
            _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
            isRecommend=YES;
            break;
        }
    }
    if (isRecommend==NO) {
        _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].ShopSelectedProduct.count];
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shopTextField"];
    }
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addTo:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma tableView deligate methods.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    GoodForArray =[productData valueForKey:@"goodfor"];
    int count = 1;
    if (GoodForArray.count==0 || GoodForArray==nil) {
        count=0;
    }
    return 2+count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row  == 0) {
        return 135;
    }
    
    else if (indexPath.row == 1) {
        int value = 0;
        for (int i=0;i<GoodForArray.count; i++) {
//            CGSize temp = [[GoodForArray objectAtIndex:i] sizeWithAttributes:
//                           @{NSFontAttributeName:
//                                 [UIFont fontWithName:@"Lato-Regular" size:13]}];
            
            UILabel *myUILabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 55, 277,5)];
            myUILabel.numberOfLines = 0;
            [myUILabel setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            myUILabel.lineBreakMode = NSLineBreakByWordWrapping;
            myUILabel.text = [GoodForArray objectAtIndex:i];
            [myUILabel sizeToFit];
            value=value+myUILabel.frame.size.height;
        }
        return value+45;
    }
    else {
        UILabel *myUILabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 55, 304,5)];
        myUILabel.numberOfLines = 0;
        [myUILabel setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        myUILabel.lineBreakMode = NSLineBreakByWordWrapping;
        myUILabel.text = [productData valueForKey:@"desc"];
        [myUILabel sizeToFit];
        return myUILabel.frame.size.height+115;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCell=@"simpleTableCell";
    static NSString *tableCell1=@"simpleTableCell1";
    static NSString *tableCell2=@"simpleTableCell2";
    productInfoViewHeader *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (indexPath.row==0) {
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"productInfoViewHeader" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.productName.text=[productData valueForKey:@"title"];
        cell.productPrice.text=[NSString stringWithFormat:@"%@",[productData valueForKey:@"price"]];
        cell.productImage.image=[Globals getImagesFromCache:[productData valueForKey:@"image"]];
        cell.productImage.contentMode = UIViewContentModeScaleAspectFit;
        cell.productCurrency.text=[productData valueForKey:@"currency"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row==1 && GoodForArray.count!=0) {
        productGoodForCell *cell1=[tableView dequeueReusableCellWithIdentifier:tableCell1];
        if (cell1==nil) {
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"productGoodForCell" owner:self options:nil];
            cell1=[array objectAtIndex:0];
        }
        int yAxis=10;
        CGSize sizes;
        for (int i=0;i<GoodForArray.count; i++) {
            
            UILabel *fromLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, yAxis, 277, sizes.height)];
            fromLabel.text = [GoodForArray objectAtIndex:i];
           // fromLabel.font = customFont;
            fromLabel.numberOfLines = 3;
            fromLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
            [fromLabel setFont:[UIFont fontWithName:@"Lato-Regular" size:13]];
            [fromLabel setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            fromLabel.clipsToBounds = YES;
            fromLabel.backgroundColor = [UIColor clearColor];
            fromLabel.textAlignment = NSTextAlignmentLeft;
            [fromLabel sizeToFit];
            
            //image tick
            UIImageView *tick=[[UIImageView alloc]initWithFrame:CGRectMake(13,yAxis, 15, 15)];
            [tick setImage:[UIImage imageNamed:@"tick.png"]];
            [cell1 addSubview:tick];
            [cell1 addSubview:fromLabel];
            
            CGRect frame=fromLabel.frame;
            frame.origin.y=yAxis;
            fromLabel.frame=frame;
            yAxis=yAxis+fromLabel.frame.size.height+10;
           // cell1.goodFor.text=;
            [cell1 addSubview:fromLabel];
            
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }
    
    else {
        NSArray *tempar=[NSArray array];
        if (isRecommend==YES) {
            tempar=[SingletonClass singleton].cartSelectedProduct;
        }
        else {
            tempar=[SingletonClass singleton].ShopSelectedProduct;
        }
        productFooterInfoCell *cell2=[tableView dequeueReusableCellWithIdentifier:tableCell2];
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"productFooterInfoCell" owner:self options:nil];
        cell2=[array objectAtIndex:0];
        cell2.productAdd.layer.cornerRadius=cell2.productAdd.bounds.size.height/2;
//        cell2.productInfo.text=[;
       
        UILabel *disc=[[UILabel alloc]initWithFrame:CGRectMake(5, 96, 304,5)];
        disc.lineBreakMode = NSLineBreakByWordWrapping;
        disc.numberOfLines = 0;
        [disc setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [disc setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [disc setText:[NSString stringWithFormat:@"%@",[productData valueForKey:@"desc"]]];
        [disc sizeToFit];
        [cell2 addSubview:disc];
        for (int i=0; i<tempar.count; i++) {
          //  ProductRecommend *temp=[tempar objectAtIndex:i];
            if ([[[tempar objectAtIndex:i] valueForKey:@"title"] isEqualToString:[productData valueForKey:@"title"]]) {
                [cell2.productAdd setTitle: @"Remove from cart" forState:normal];
                isRemove=@"Remove from cart";
                flag1=YES;
                break;
            }
        }
        if (flag1==NO) {
            [cell2.productAdd setTitle: @"Add to cart" forState:normal];
            isRemove=@"Add from cart";
        }
        [cell2.productAdd addTarget:self action:@selector(yourButton:) forControlEvents:UIControlEventTouchUpInside];
//       cell2.productAdd.titleLabel.text = [productData]
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }
    
}
-(IBAction)yourButton:(UIButton *)sender{
    
    BOOL check=NO;
    if (isRecommend==YES) {
        [self loadProduct];
        if ([isRemove isEqualToString:@"Remove from cart"]) {
            isRemove=@"Add from cart";
            for (int i=0; i<[SingletonClass singleton].cartSelectedProduct.count; i++) {
                //ProductRecommend *temp=[[SingletonClass singleton].cartSelectedProduct objectAtIndex:i];
                if ([[[[SingletonClass singleton].cartSelectedProduct objectAtIndex:i] valueForKey:@"title"] isEqualToString:[productData valueForKey:@"title"]]) {
                    [[SingletonClass singleton].cartSelectedProduct  removeObjectAtIndex:i];
                    _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
                    break;
                }
            }
        }
        else {
            isRemove=@"Remove from cart";
            [[SingletonClass singleton].cartSelectedProduct addObject:[tre objectAtIndex:0]];
            _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].cartSelectedProduct.count];
        }
        [table reloadData];
        check=YES;
    }
    if (check==NO) {
        [self PostToUpdateTheProductToWeb:flag1];
    }
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
    NSArray *viewContrlls = self.navigationController.viewControllers ;
    if ([NSStringFromClass([[viewContrlls objectAtIndex:2] class]) isEqualToString:@"shopController"]){
        
        shopCheckoutController *recommend=[[shopCheckoutController alloc]init];
        [self.navigationController pushViewController:recommend animated:YES];
    }
    else{
        
        setRecommendReminder *recommend1=[[setRecommendReminder alloc]init];
        [self.navigationController pushViewController:recommend1 animated:YES];
    }
    }
}
-(void)PostToUpdateTheProductToWeb:(BOOL)flags{
   
    BOOL counts=NO;
    tre=[SingletonClass singleton].ShopSelectedProduct;
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    //products.uid = 2446;
    int tokenId = [[[NSUserDefaults standardUserDefaults]objectForKey:@"shopToken"] intValue] ;
    NSString *urlString;
    if (flags) {
        urlString =[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartdelete&pid=%@&token=%i",[productData valueForKey:@"uid"],tokenId];
        for (int i=0; i<tre.count; i++) {
            ProductRecommend *temp=[tre objectAtIndex:i];
            if ([temp.title isEqualToString:[productData valueForKey:@"title"]]) {
               // NSInteger indexValue =[[SingletonClass singleton].ShopSelectedProduct indexOfObject:[productData valueForKey:@"title"]];
                [tre  removeObjectAtIndex:i];
                _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)tre.count];
                counts=YES;
                break;
            }
        }
        
    }
    if (counts==NO) {
        urlString = [NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api/?call=cart&method=cartupdate&pid=%@&quantity=%@&token=%i",[productData valueForKey:@"uid"],@"1",tokenId];
        [self loadProduct];
    }
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        [hudFirst hide:YES];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
   
    [SingletonClass singleton].ShopSelectedProduct = tre;

    [table reloadData];
}

-(void)loadProduct {
    ProductRecommend *product=[ProductRecommend new];
    product.title=[productData valueForKey:@"title"];
    product.image=[productData valueForKey:@"image"];
    product.imageLarge=[productData valueForKey:@"image_normal"];
    product.price=[[productData valueForKey:@"price"] floatValue];
    product.uid=[[productData valueForKey:@"uid"] intValue];
    product.quantity=1;
    [tre  addObject:product];
    _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)tre.count];
}

@end
