//
//  MyStats.m
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "MyStats.h"
#import "PNChart.h"
#import "Constants.h"

@interface MyStats ()
{
    
    int previousStepperValue;
    int totalNumber;
    NSUserDefaults *myUserDefaults;
    // NSMutableArray *graphValue;
    NSArray *graphTitle;
    UISlider *slider;
    // NSMutableArray *graphNew;
    //  NSMutableArray *dates;
    NSMutableArray *basicdata;
    NSString *tableName;
    NSString *colname;
    NSArray *colNameArray;
    NSMutableArray *graphData;
    BOOL isSelected;
    PNLineChart * lineChart;
}

@end

@implementation MyStats
@synthesize navigationBar;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"MyStats_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"MyStats" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"MyStats_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"My Stats"];
    lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(-15, 96, 300, 235)];
    [self.view bringSubviewToFront:lineChart];
//   _DefaultSelectedCell= [NSIndexPath indexPathForRow:0 inSection:0];

    //ADDING VALUES TO ARRAY
    graphTitle=[NSArray arrayWithObjects:@"Weight",@"Waist Size",@"Body Fat %",@"Arm Size",@"Leg Size",@"Water %",@"Chest Size",@"Physical Rating",@"Bone Mass",@"BMR", @"Visceral Fat",@"Arm-r",@"Arm-l",@"Trunk",@"Leg-r",@"Leg-l",@"Pectoral",@"Abdominal",@"Thigh",@"Triceps",@"Subscapular",@"Suprailiac",@"Axila",@"Arm-r",@"Arm-l",@"Leg-r",@"Leg-l",nil];
    colNameArray=[NSArray arrayWithObjects:@"weight", @"waist",@"body_fat", @"arm",@"leg",@"water",@"chest",@"physical_rating",@"mass",@"bmr",@"visceral_fat",@"arm_r",@"arm_l",@"trunk",@"leg_r",@"leg_l",@"pectoral",@"abdominal",@"thigh",@"tricepts",@"subscapular",@"suprailiac",@"axilla",@"arm_r",@"arm_l",@"leg_r",@"leg_l", nil];
    basicdata=[[NSMutableArray alloc]init];
    graphData=[[NSMutableArray alloc]init];
    //dates=[NSMutableArray arrayWithObjects:@"11",@"12",@"13", nil];
    // int setValue=(int)graphValue.count;
    
    //ADDING SLIDER TO VIEW TO SCROLL GRAPH
    if (IS_IPHONE_4_OR_LESS) {
        slider= [[UISlider alloc] initWithFrame:CGRectMake(230, 340, 120, 10)];
    }
    else {
        slider= [[UISlider alloc] initWithFrame:CGRectMake(190, 380, 200, 20)];
    }
    
    slider.minimumValue = 0;
    slider.maximumValue = 100;
    slider.minimumTrackTintColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    slider.maximumTrackTintColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
    slider.thumbTintColor=[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
    [slider addTarget:self action:@selector(sliderValue:)
     forControlEvents:UIControlEventValueChanged];
    slider.transform= CGAffineTransformMakeRotation(M_PI * 0.5);
    [self.view addSubview:slider];
    
    
    //REMOVE ALL VALUES FROM SINGLTON THAT STORE TEXT FIELDS FILLED VALUES OF NEXTS SCREENS
    [[SingletonClass singleton].basicStats removeAllObjects];
    [[SingletonClass singleton].bmiStats removeAllObjects];
    [[SingletonClass singleton].bfStats removeAllObjects];
    [[SingletonClass singleton].smStats removeAllObjects];
    [[SingletonClass singleton].sfStats removeAllObjects];
    
    
    //CALLING GRAPH METHOD
    [self graphAddingValues];
    
    //IMPLEMENTING NAVIGATION BAR
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [basicdata removeAllObjects];
    [graphData removeAllObjects];
}



-(void)viewWillAppear:(BOOL)animated{
//    [self.tableGraph selectRowAtIndexPath:_DefaultSelectedCell animated:NO scrollPosition:UITableViewScrollPositionNone];

    //CALLING API THAT PROVIDE LATEST VALUES OF EACH UNITS OF MEASUREMENTS
    [self callDataFormServer];
    
    //REMOVE ALL VALUES FROM SINGLTON THAT STORE TEXT FIELDS FILLED VALUES OF NEXTS SCREENS
    [[SingletonClass singleton].basicStats removeAllObjects];
    [[SingletonClass singleton].bmiStats removeAllObjects];
    [[SingletonClass singleton].bfStats removeAllObjects];
    [[SingletonClass singleton].smStats removeAllObjects];
    [[SingletonClass singleton].sfStats removeAllObjects];
}
#pragma graph implimentation*******************************************************************
int ijkl=0;
-(void)graphAddingValues{
    [self.view setNeedsDisplay];
    
    //ADDING LINE GRAPH TO THE VIEW
    
    
    
    // Line Chart No.1
    
    
    if (graphData.count==0) {
        graphData=[NSMutableArray arrayWithObjects:@"0", nil];
    }
    
    graphData = [[[graphData reverseObjectEnumerator] allObjects]mutableCopy];
    
    //    [lineChart setXLabels:@[@"",@"",@"",@"",@""]];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor grayColor];
    data01.itemCount = graphData.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [graphData[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    //    // Line Chart No.2
    //    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    //    PNLineChartData *data02 = [PNLineChartData new];
    //    data02.color = PNTwitterColor;
    //    data02.itemCount = lineChart.xLabels.count;
    //    data02.getData = ^(NSUInteger index) {
    //        CGFloat yValue = [data02Array[index] floatValue];
    //        return [PNLineChartDataItem dataItemWithY:yValue];
    //    };
    
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    [self.view addSubview:lineChart];
    [self.view sendSubviewToBack:lineChart];
}


//GRAPH SLIDER SETTING FOR SLIDING THE TABLE VIEW AND USING SCROLL VIEW
int currentValue;
-(void)sliderValue:(id)sender{
    
    float value=0;
    CGPoint offset = CGPointMake(0, _tableGraph.contentSize.height-_tableGraph.frame.size.height);
    value=slider.value;
    value=offset.y*value/100;
    [_tableGraph setContentOffset:CGPointMake(0, value)];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    float value=0;
    float offsetCurrent=_tableGraph.contentOffset.y;
    CGPoint offset = CGPointMake(0, _tableGraph.contentSize.height-_tableGraph.frame.size.height);
    value=offsetCurrent/offset.y*100;
    slider.value=value;
    
}

#pragma table view********************

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (basicdata.count!=0) {
        return 27;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tableCell1=@"simpleTableCell1";
    MyStatFooterCell *cell1=[tableView dequeueReusableCellWithIdentifier:tableCell1];
    if (cell1==0) {
        NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"MyStatFooterCell" owner:self options:nil];
        cell1=[data objectAtIndex:0];
    }
    static NSString *tableCell=@"simpleTableCell";
    MyStatsCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
    
    if (cell==0) {
        NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"MyStatsCustomCell" owner:self options:nil];
        cell=[data objectAtIndex:0];
        
    }
    [cell.selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:133/255.0 green:152/255.0 blue:160/255.0 alpha:1.0]];
    cell.value.text=[basicdata objectAtIndex:indexPath.row];
    cell.type.text=[graphTitle objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor lightGrayColor];
    [cell setSelectedBackgroundView:bgColorView];

    [cell addSubview:cell1];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row==0) {
//        [cell setBackgroundColor:[UIColor lightGrayColor]];
//        [cell setAccessibilityTraits:0];
//    }
    
    // enter your own code here
//    if (isSelected==YES)
//    {
//        [cell setBackgroundColor:[UIColor colorWithRed:133/255.0 green:152/255.0 blue:160/255.0 alpha:1.0]];
//        [cell setAccessibilityTraits:UIAccessibilityTraitSelected];
//    }
//    else
//    {
//        [cell setBackgroundColor:[UIColor lightGrayColor]];
//        [cell setAccessibilityTraits:0];
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
//    [self.tableGraph selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionBottom];
//    _DefaultSelectedCell =[NSIndexPath indexPathForRow:indexPath.row inSection:0];
    //YOU CAN SEE SELECTED ROW NUMBER IN YOUR CONSOLE
    slider.value=currentValue;
    colname=[colNameArray objectAtIndex:indexPath.row];
    if ([[basicdata objectAtIndex:indexPath.row] isEqualToString:@"--"]) {
        return;
    }
    
    //SELECTING THE BODY MEASUREMENT TYPE BY CLICKING ANY ROW
    if (indexPath.row<=6) {
        tableName=@"client_body_basic";
        
    }
    else if (indexPath.row>=7 && indexPath.row<=10) {
        tableName=@"client_body_bmi";
        
    }
    else if (indexPath.row>=11 && indexPath.row<=15) {
        tableName=@"client_body_sm";
        
    }
    else if (indexPath.row>=16 && indexPath.row<=22) {
        tableName=@"client_body_skinfold";
        
    }
    else if (indexPath.row>=23 && indexPath.row<=26) {
        tableName=@"client_body_bf";
        
    }
    [NSThread detachNewThreadSelector:@selector(myStatsGraphData) toTarget:self withObject:nil];
}
//TABLE VIEW DELIGATE METHOD ENDS
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//        [cell setSelected:YES animated:NO];
//}


//BUTTONS ACTION
- (IBAction)addBodyStats:(id)sender {
    BasicController *addStats=[[BasicController alloc]init];
    [self.navigationController pushViewController:addStats animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//BUTTONS ACTION ENDS



//SETTING GRAPH DATA VALUE INCASE API RETURN NULL OR 0 VALUE
-(void)graphDataTableDefaultValue{
    for (int graphCount=1;graphCount<30; graphCount++) {
        [basicdata addObject:@"--"];
    }
}


#pragma api.........................................................................

-(void)callDataFormServer
{
    MBProgressHUD *hudFirst;
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    
    [hudFirst show:YES];
    NSString *uid=[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    // NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:Kurlgetrecord apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid", nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            NSMutableDictionary *graphs=[json objectForKey:@"client_body_basic"];
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                
                [hudFirst hide:YES];
                
                
                NSString *item;
                NSString *str;
                NSString *item2=@"0";
                
                item=[graphs valueForKey:@"weight"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"weight"]];
                }
                
                item=[graphs valueForKey:@"waist"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"waist"]];
                }
                
                item=[graphs valueForKey:@"body_fat"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"body_fat"]];
                }
                
                
                item=[graphs valueForKey:@"arm"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"arm"]];
                }
                
                item=[graphs valueForKey:@"leg"];
                
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"leg"]];
                }
                
                item=[graphs valueForKey:@"water"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"water"]];
                }
                
                item=[graphs valueForKey:@"chest"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"chest"]];
                }
                
                graphs=[json objectForKey:@"client_body_bmi"];
                item=[graphs valueForKey:@"physical_rating"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"physical_rating"]];
                }
                item=[graphs valueForKey:@"mass"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"mass"]];
                }
                item=[graphs valueForKey:@"bmr"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"bmr"]];
                }
                item=[graphs valueForKey:@"visceral_fat"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"visceral_fat"]];
                }
                
                
                graphs=[json objectForKey:@"client_body_sm"];
                item=[graphs valueForKey:@"arm_r"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"arm_r"]];
                }
                
                item=[graphs valueForKey:@"arm_l"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"arm_l"]];
                }
                
                item=[graphs valueForKey:@"trunk"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"trunk"]];
                }
                item=[graphs valueForKey:@"leg_r"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"leg_r"]];
                }
                item=[graphs valueForKey:@"leg_l"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"leg_l"]];
                }
                
                
                graphs=[json objectForKey:@"client_body_skinfold"];
                item=[graphs valueForKey:@"pectoral"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"pectoral"]];
                }
                item=[graphs valueForKey:@"abdominal"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"abdominal"]];
                }
                item=[graphs valueForKey:@"thigh"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"thigh"]];
                }
                item=[graphs valueForKey:@"tricepts"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"tricepts"]];
                }
                item=[graphs valueForKey:@"subscapular"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"subscapular"]];
                }
                item=[graphs valueForKey:@"suprailiac"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"suprailiac"]];
                }
                item=[graphs valueForKey:@"axilla"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"axilla"]];
                }
                
                
                
                graphs=[json objectForKey:@"client_body_bf"];
                item=[graphs valueForKey:@"arm_r"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"arm_r"]];
                }
                item=[graphs valueForKey:@"arm_l"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"arm_l"]];
                }
                item=[graphs valueForKey:@"leg_r"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"leg_r"]];
                }
                item=[graphs valueForKey:@"leg_l"];
                str=[NSString stringWithFormat:@"%@",item];
                if ([str isEqualToString:item2] || item == nil) {
                    [basicdata addObject:@"--"];
                }
                else{
                    [basicdata addObject:[graphs valueForKey:@"leg_l"]];
                }
                
                [basicdata mutableCopy];
                [_tableGraph reloadData];
                
                NSIndexPath *sendIndex=[NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableGraph selectRowAtIndexPath:sendIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
                [self tableView:self.tableGraph didSelectRowAtIndexPath:sendIndex];
                
                
            }
            else{
                [hudFirst hide:YES];
                [self.view endEditing:YES];
                [self graphDataTableDefaultValue];
                [_tableGraph reloadData];
                [Globals alert:[json objectForKey:@"message"]];
            }
        }
        else{
            [hudFirst hide:YES];
            [self.view endEditing:YES];
            [self graphDataTableDefaultValue];
            [_tableGraph reloadData];
            [Globals alert:[json objectForKey:@"message"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [self.view endEditing:YES];
        [self graphDataTableDefaultValue];
        [_tableGraph reloadData];
        [Globals alert:@"Sorry! Internal Server Error." ];
    }];
    
}

-(void)myStatsGraphData
{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    NSString *urlString=@"http://dev.wellbeingnetwork.com/trainervate2/api/getstatisticsrecord/737d377946ce837e25a323bd33777e29/995d192dd84864125fe58521f9829dc1";
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:userID,@"uid",tableName,@"table_name",colname,@"col", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                
                [hudFirst hide:YES];
                graphData=[[json objectForKey:@"values"] mutableCopy];
                [self graphAddingValues];
                
                
            }
            else{
                
                
                [hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [hudFirst hide:YES];
        [Globals alert:@"Sorry! Internal Server Error."];
        
    }];
    
}


@end
