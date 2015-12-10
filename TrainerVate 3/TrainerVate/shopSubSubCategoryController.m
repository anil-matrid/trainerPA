//
//  shopSubSubCategoryController.m
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopSubSubCategoryController.h"
#import "recommend1.h"
#import "recommend2.h"
#import "Constants.h"
#import "shopSearchControllerViewController.h"

@interface shopSubSubCategoryController (){
    NSMutableArray *shopCate;
    BOOL flagScreen;
    UITableView *tblShop;
}
@end

@implementation shopSubSubCategoryController
@synthesize subCategoryHolder,name;
- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
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
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[DietPlanController class]] ) {
            _btnCart.userInteractionEnabled=NO;
            _lblQty.text=[NSString stringWithFormat:@"%lu",(unsigned long)[SingletonClass singleton].dietPlanBundelArray.count];
            break;
        }
    }
    _headerName.text=name;
    [_headerName sizeToFit];
    shopCate=[subCategoryHolder mutableCopy];
    _viewLblBack.layer.cornerRadius=_viewLblBack.bounds.size.width/2;
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
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shopTextField"];
    
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
    return shopCate.count ;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *temp=[[shopCate objectAtIndex:indexPath.row] valueForKey:@"subcategories"];
    if (temp.count==0) {
        if (flagScreen==YES ) {
            recommendShopController *shop=[[recommendShopController alloc]init];
            shop.name=[[shopCate  objectAtIndex:indexPath.row] valueForKey:@"name"];
            shop.uid=[[shopCate objectAtIndex:indexPath.row] valueForKey:@"uid"];
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
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,0,320,2)];
    [view setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    return view;
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

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)search:(id)sender {
    shopSearchControllerViewController *search=[[shopSearchControllerViewController alloc]init];
    search.preClass=_preClass;
    [self.navigationController pushViewController:search animated:YES];
}
@end
