//
//  checkOutBundle.m
//  TrainerVate
//
//  Created by Matrid on 26/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "checkOutBundle.h"
#import "checkOutCustomCell.h"
#import "Constants.h"
#import "shopWebController.h"
#import "clientSideRecommendation.h"

@interface checkOutBundle () {
    int count;
    NSString *tokienID;
    BOOL flag;
}

@end

@implementation checkOutBundle
@synthesize bundleName,bundleProduct;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(IS_IPHONE_5_OR_MORE) {
        self = [super initWithNibName:@"checkOutBundle" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"checkOutBundle_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    headerLbl.text=bundleName;
    
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    flag=YES;
    for (UIViewController *viewCon in self.navigationController.viewControllers) {
        if ([viewCon isKindOfClass:[clientSideRecommendation class]]) {
            flag=NO;
            break;
        }
    }
    [self loadProductToProducts:bundleProduct];

}
-(void)viewWillAppear:(BOOL)animated {
        count=0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return bundleProduct.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 106;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    checkOutCustomCell *cell = (checkOutCustomCell *)[table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==NULL) {
        NSArray *data= [[NSBundle mainBundle]loadNibNamed:@"checkOutCustomCell" owner:self options:nil];
        cell = [data objectAtIndex:0];
    }
    ProductRecommend *currentProduct=[bundleProduct objectAtIndex:indexPath.row];
    cell.productName.text=currentProduct.title;
    cell.productPrice.text=[NSString stringWithFormat:@"%@%.02f",@"£",currentProduct.price];
    cell.productQty.text=[NSString stringWithFormat:@"%@%d",@"Qty:",currentProduct.quantity];
    cell.productImage.image=[Globals getImagesFromCache:currentProduct.image];
    return cell;
}

-(void)loadProductToProducts:(NSArray *)response {
    
    NSMutableArray *productArray=[[NSMutableArray alloc]init];
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
        NSDictionary *currentDic=[response objectAtIndex:i];
        ProductRecommend *product=[ProductRecommend new];
        product.title=[currentDic valueForKey:@"title"];
        product.image=[currentDic valueForKey:@"image"];
        product.imageLarge=[currentDic valueForKey:@"image_normal"];
        product.price=[[currentDic valueForKey:@"price"] floatValue];
        if (flag==YES) {
            product.uid=[[currentDic valueForKey:@"item_id"] intValue];
            product.quantity=[[currentDic valueForKey:@"quantity"] intValue];
        }
        else {
            product.uid=[[currentDic valueForKey:@"product_id"] intValue];
            product.quantity=[[currentDic valueForKey:@"Qty"] intValue];
        }
        
        if (![product.image isEqual:[NSNull null]]) {
            if (![product.image isEqualToString:@""] && product.image!=nil) {
                [imageArr addObject:product.image];
            }
        }
        [productArray addObject:product];
    }
    bundleProduct=productArray;
    [Globals saveUserImagesIntoCache:imageArr];
    [table reloadData];
}

-(void)getTrainerToken {
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=KurlgenerateToken;
    NSDictionary *inputDic=[NSDictionary dictionary];
    [Globals GetApiURL:urlString data:inputDic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"cart"]objectForKey:@"token"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"cart"] objectForKey:@"token"] forKey:@"shopToken"];
            tokienID=[[NSUserDefaults standardUserDefaults] objectForKey:@"shopToken"];
            [self Checkout];
            [hudFirst hide:YES];
        }else{
            [hudFirst hide:YES];
        }
        
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}

-(void)Checkout{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    if (count==0) {
        hudFirst.delegate = self;
        hudFirst.labelText=@"Please wait";
        hudFirst.center=self.view.center;
        hudFirst.dimBackground=YES;
        hudFirst.removeFromSuperViewOnHide = YES;
        [hudFirst show:YES];
    }
    NSString *productID;
    NSString *productQty;
    productID=[[bundleProduct objectAtIndex:count] valueForKey:@"uid"];
    productQty=[[bundleProduct objectAtIndex:count] valueForKey:@"quantity"];
    
    NSString *urlString =[NSString stringWithFormat:@"http://www.wellbeingnetwork.com/api?call=cart&method=cartadd&pid=%@&quantity=%@&token=%@",productID,productQty,tokienID];
    [Globals GetApiURL:urlString data:[NSDictionary dictionary] success:^(id responseObject) {
        if ([responseObject objectForKey:@"cart"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"cart"] objectForKey:@"token"] forKey:@"tokenIdShop"];
            count+=1;
            [hudFirst hide:YES];
            if (count<bundleProduct.count) {
                [self Checkout];
            }
            else {
                shopWebController *webController=[[shopWebController alloc]init];
                [self.navigationController pushViewController:webController animated:YES];
            }
        }
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    [self getTrainerToken];
}
@end
