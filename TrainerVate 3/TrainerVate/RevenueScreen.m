//
//  ViewController.m
//  SupplementsList
//
//  Created by Matrid on 17/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "RevenueScreen.h"
#import "RevenueScreenCell.h"
#import "Constants.h"


@interface RevenueScreen ()
{
    NSMutableArray *revenue;
    
}


@end

@implementation RevenueScreen
@synthesize revenueButton,historyButton,historyView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Revenue Screen"];
    if(IS_IPHONE_4_OR_LESS) {
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 500);
    }
    _lblError.hidden=YES;
    _table.hidden=YES;
    historyView.hidden=YES;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    [self callData];
        // Do any additional setup after loading the view from its nib.
    revenue = [[NSMutableArray alloc]init];
    [historyButton setTitleColor:[UIColor colorWithRed:75/255.0 green:100/255.0 blue:110/255.0 alpha:1.0] forState:normal];
    [historyButton setBackgroundColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]] ;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return revenue.count-1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    RevenueScreenCell *cell = (RevenueScreenCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==NULL) {
        NSArray *data= [[NSBundle mainBundle]loadNibNamed:@"RevenueScreenCell" owner:self options:nil];
        cell = [data objectAtIndex:0];
    }
    float revenues=[[[revenue objectAtIndex:indexPath.row] valueForKey:@"Comission"] floatValue];
    cell.headerRevenue.text = [NSString stringWithFormat:@"%.02f",revenues];
    cell.headerProduct.text = [[revenue objectAtIndex:indexPath.row] valueForKey:@"getOrderId"];
    cell.headerName.text = [[revenue objectAtIndex:indexPath.row] valueForKey:@"UserName"];
    
    NSString *str = [[revenue objectAtIndex:indexPath.row] valueForKey:@"Time"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString: str];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM"];
    NSString *convertedString = [dateFormatter stringFromDate:date];
    cell.headerDate.text = convertedString;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0,144,320,60)];
    [views setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 29, 67, 21)];
    [label setFont: [UIFont systemFontOfSize:15]];
    NSString *string = @"Revenue";
    [label setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [label setText:string];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(87, 29, 61, 21)];
    [label2 setFont:[UIFont systemFontOfSize :15]];
    NSString *string2 = @"Product";
    [label2 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [label2 setText:string2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(156, 29, 108, 21)];
    [label3 setFont:[UIFont systemFontOfSize:15]];
    NSString *string3 = @"Client's Name";
    [label3 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [label3 setText:string3];
    UILabel *label4= [[UILabel alloc]initWithFrame:CGRectMake(264, 29, 36, 21)];
    [label4 setFont:[UIFont systemFontOfSize:15]];
    NSString *string4 =@"Date";
    [label4 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [label4 setText:string4];
    [views addSubview:label];
    [views addSubview:label2];
    [views addSubview:label4];
    [views addSubview:label3];
    return views;
     
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)historyButton:(id)sender {
    [revenueButton setTitleColor:[UIColor colorWithRed:75/255.0 green:100/255.0 blue:110/255.0 alpha:1.0] forState:normal];
    [revenueButton setBackgroundColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]] ;
    [historyButton setTitleColor:[UIColor blackColor] forState:normal];
    [historyButton setBackgroundColor:[UIColor clearColor]];
    historyView.hidden = YES;
    _table.hidden = NO;
    
}

- (IBAction)revenueButton:(id)sender {
    [historyButton setTitleColor:[UIColor colorWithRed:75/255.0 green:100/255.0 blue:110/255.0 alpha:1.0] forState:normal];
    [revenueButton setTitleColor:[UIColor blackColor] forState:normal];
    [revenueButton setBackgroundColor:[UIColor whiteColor]] ;
    [historyButton setBackgroundColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]] ;
    historyView.hidden = NO;
    _table.hidden= YES;
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)callData{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"getRevenue/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"trainer_id", nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                revenue=[json objectForKey:@"Revenue"];
                [self revenueScreenData];
                _table.hidden=NO;
                historyView.hidden=NO;
                [_table reloadData];
                _lblError.hidden=YES;
                if (revenue.count==0) {
                    _lblError.hidden=NO;
                }
                
            }
            else{
                _lblError.hidden=NO;
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
    }];
}

- (void) revenueScreenData {
    if (revenue.count==0 || revenue==nil) {
        return;
    }
    totalRevenue.text=[NSString stringWithFormat:@"%@%@",@"£",[[revenue objectAtIndex:revenue.count-1] valueForKey:@"Total_Comission"]];
    clientName.text=[[revenue objectAtIndex:0] valueForKey:@"UserName"];
    lastRevenue.text=[[revenue objectAtIndex:0] valueForKey:@"Comission"];
}

@end
