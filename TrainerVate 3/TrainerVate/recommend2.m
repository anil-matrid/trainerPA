//
//  recommend.m
//  TrainerVate
//
//  Created by Matrid on 29/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "recommend2.h"
#import "Constants.h"
#import "recommendCustomCell.h"
@interface recommend2 () {

  

    NSMutableArray *productInfo;
    NSArray *temp;
    MBProgressHUD *  hudFirst;
    int count;
    NSMutableArray *mybundle;
    NSMutableArray *arrayRespose;
    NSMutableArray *cellToBeBlocked;
    int senderTag;
}


@end

@implementation recommend2
@synthesize bundelID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"recommend2_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"recommend2" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"recommend2_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Recommend 2"];
    // Do any additional setup after loading the view from its nib.
     count=0;
    mybundle=[[NSMutableArray alloc]init];
    cellToBeBlocked=[[NSMutableArray alloc]init];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [SingletonClass singleton].cartSelectedProduct=[[NSMutableArray alloc]init];
    [self callDataFormServer];
    _errorLabel.hidden=YES;
}


-(void)addSuppliment
{
    NSLog(@"add suppliment");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableView method**************************************************************
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array=[productInfo objectAtIndex:section];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return productInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 32;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTable=@"simpleTableCell";
    recommendCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
    
    if (cell==nil) {
        NSArray *temps=[[NSBundle mainBundle]loadNibNamed:@"recommendCustomCell" owner:self options:nil];
        cell=[temps objectAtIndex:0];
    }
    if ([cellToBeBlocked containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
        UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,cell.frame.size.height)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
        [cell addSubview:views];
        
    }
    NSString  *str = [NSString stringWithFormat:@"%@",[[[productInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"quantity"]];
    cell.lblProductQty.text=str;
    float number = [str floatValue];
    cell.lblProductName.text = [[[productInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"title"];
    float price = [[[[productInfo objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"price"] floatValue];
    number = number * price;
                
    cell.lblProductPrice.text = [NSString stringWithFormat:@"%.2f",number];
    if ([bundelID containsObject:[[arrayRespose objectAtIndex:indexPath.section]valueForKey:@"BundleID"]]) {
        UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,cell.frame.size.height)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
        [cell addSubview:views];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *array=[productInfo objectAtIndex:section];
    
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    
    UILabel *header1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 3)];
    [header1 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    UILabel *header2=[[UILabel alloc]initWithFrame:CGRectMake(0, 29, 320, 3)];
    [header2 setBackgroundColor:[UIColor colorWithRed:228.0/255.0f green:228.0/255.0f blue:228.0/255.0f alpha:1.0]];
    UILabel *headerName=[[UILabel alloc]initWithFrame:CGRectMake(11, 5, 184, 21)];
    [headerName setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [headerName setText:[[arrayRespose objectAtIndex:section]valueForKey:@"Name"]];
    [headerName setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
    UILabel *headerProductQty=[[UILabel alloc]initWithFrame:CGRectMake(215, 6, 28, 21)];
    [headerProductQty setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [headerProductQty setText:[NSString stringWithFormat:@"%d",(int)[array count]]];
    [headerProductQty setFont:[UIFont fontWithName:@"Lato-Regular" size:12]];
    UILabel *headerProduct=[[UILabel alloc]initWithFrame:CGRectMake(247, 5, 65, 21)];
    [headerProduct setText:@"products"];
    [headerProduct setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [headerProduct setFont:[UIFont fontWithName:@"Lato-Regular" size:12]];
    headerProductQty.textAlignment = NSTextAlignmentRight;
    BOOL selection=NO;
    //Theis method disable the selection of section
    if ([bundelID containsObject:[[arrayRespose objectAtIndex:section]valueForKey:@"ID"]]) {                UIView *views=[[UIView alloc]initWithFrame:CGRectMake(0, 0,320,headerView.frame.size.height)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.f green:233/255.f blue:233/255.f alpha:0.50f]];
        [headerView addSubview:views];
        [_tblRecommend bringSubviewToFront:headerView];
        [cellToBeBlocked addObject:[NSNumber numberWithInteger:section]];
        selection=YES;
    }
    if (selection==NO) {
        UIButton *btnHeader=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
        btnHeader.tag=section;
        [btnHeader addTarget:self action:@selector(editBundle:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:btnHeader];
        
    }
    
    [headerView addSubview:header1];
    [headerView addSubview:header2];
    [headerView addSubview:headerName];
    [headerView addSubview:headerProductQty];
    [headerView addSubview:headerProduct];
    
    if (section==[[mybundle valueForKey:@"Name"] count]-1) {
        section=0;
    }
    
    return headerView;
}

- (void) editBundle:(UIButton *)senderBtn {
    
    NSArray *array=[productInfo objectAtIndex:senderBtn.tag];
    NSArray *productConvertedArray =[self loadProductToProductsWhenSending:array];
    [SingletonClass singleton].cartSelectedProduct = [productConvertedArray mutableCopy];
    [[SingletonClass singleton].bundelSelectedProduct setValue:[[arrayRespose objectAtIndex:senderBtn.tag]valueForKey:@"ID"] forKey:@"name"];
    [[SingletonClass singleton].bundelSelectedProduct setValue:[[arrayRespose objectAtIndex:senderBtn.tag]valueForKey:@"Name"] forKey:@"bName"];
    recommendBundleEditing *editing=[[recommendBundleEditing alloc]init];
    [self.navigationController pushViewController:editing animated:YES];
}

#pragma api***************************************************************************

-(void)callDataFormServer
{
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:KurlgetBundleProducts apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"premade",@"1",@"bundles_only" ,nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [self loadProductToProducts: [json objectForKey:@"Recommendations"]];
        //    [self loadProductToProducts:[json objectForKey:@"Recommendations"]];
                [hudFirst hide:YES];
            }
            else{
                _errorLabel.hidden=NO;
                [hudFirst hide:YES];
            }
        }
        else {
            [hudFirst hide:YES];
            _errorLabel.hidden=NO;
            _errorLabel.text=@"Sorry! Internal Server Error.";
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _errorLabel.hidden=NO;
        _errorLabel.text=@"Sorry! Internal Server Error.";
        
    }];
    
}

#pragma getProduct api****************************************************************
-(void)loadProductToProducts:(NSArray *)response {
    int tempCount=0;
    productInfo = [[NSMutableArray alloc]init];
               NSMutableArray *imageArr=[NSMutableArray array];
    
    arrayRespose=[response mutableCopy];
    
        for (int i=0; i<[[response valueForKey:@"mybundle"] count];i++ ) {
            tempCount=0;
            mybundle=[[NSMutableArray alloc]init];
            NSArray *currentDic=[[response objectAtIndex:i]valueForKey:@"mybundle"];
            for (int j=0; j<[currentDic count]; j++) {
                 NSMutableDictionary *tempArray=[[NSMutableDictionary alloc]init];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"title"] forKey:@"title"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"price"] forKey:@"price"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"Qty"] forKey:@"quantity"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"image"] forKey:@"image"];
                [tempArray setObject:[[currentDic  objectAtIndex:j]valueForKey:@"product_id"] forKey:@"product_id"];
                
                //[imageArr addObject:product.image];
                [mybundle addObject:tempArray];
            }
            [productInfo addObject:mybundle];
    }
        count=(int)productInfo.count;
    
    [Globals saveUserImagesIntoCache:imageArr];
    [_tblRecommend reloadData];
}

- (NSArray *)loadProductToProductsWhenSending:(NSArray *)response {
     NSMutableArray *prductArray=[NSMutableArray array];
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
            NSDictionary *currentDic=[response objectAtIndex:i];
            ProductRecommend   * product=[ProductRecommend new];
            product.title=[currentDic valueForKey:@"title"];
            product.image=[currentDic valueForKey:@"image"];
            product.imageLarge=[currentDic valueForKey:@"image_normal"];
            product.price=[[currentDic  valueForKey:@"price"] floatValue];
            product.quantity=[[currentDic valueForKey:@"quantity"] intValue];
            product.uid=[[currentDic valueForKey:@"product_id"] intValue];
            [imageArr addObject:product.image];
            [prductArray addObject:product];
        }
    [Globals saveUserImagesIntoCache:imageArr];
    return prductArray;
}

#pragma buttons actions***************************************************************

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
