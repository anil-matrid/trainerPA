//
//  dietPlanCustomDietPlan.m
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "dietPlanCustomDietPlan.h"
#import "Constants.h"
#import "dietPlanCustomCell.h"


@interface dietPlanCustomDietPlan () {
    
    NSMutableArray *MainDataArray;
    NSMutableArray *searchArray;
    BOOL isSearch;
}

@end

@implementation dietPlanCustomDietPlan
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"dietPlanCustomDietPlan_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"dietPlanCustomDietPlan" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"dietPlanCustomDietPlan_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Diet Olan Customize Plan"];
     MainDataArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    isSearch=NO;
    [self workoutExercise];
    
}

#pragma tablveView deligate methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch==NO) {
        return MainDataArray.count;
    }
    return searchArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCell=@"uitableViewCell";
    dietPlanCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
    if (cell==0) {
        NSArray *myArray=[[NSBundle mainBundle] loadNibNamed:@"dietPlanCustomCell" owner:self options:nil];
        cell=[myArray objectAtIndex:0];
    }
    if (isSearch==NO) {
        cell.dietName.text=[[MainDataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    }
    else {
        cell.dietName.text=[[searchArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DietPlanCustonise *diet=[[DietPlanCustonise alloc]init];
    diet.diet_id = [[MainDataArray objectAtIndex:indexPath.row] objectForKey:@"diet_id"];
    diet.preClass=@"customDiet";
    [self.navigationController pushViewController:diet animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)search:(id)sender {
    [self.view endEditing:YES];
    if ([_txtFeildSeacrh.text isEqualToString:@""]) {
        isSearch=NO;
        _tblCustomiseDietPlan.hidden=NO;
        [_tblCustomiseDietPlan reloadData];
        return;
    }
    searchArray=[[NSMutableArray alloc]init];
    for (int i=0; i<MainDataArray.count; i++) {
        NSString *currentTitle=[[MainDataArray objectAtIndex:i] valueForKey:@"name"];
        if ([currentTitle containsString:_txtFeildSeacrh.text]) {
            [searchArray addObject:[MainDataArray objectAtIndex:i]];
        }
    }
    if (searchArray.count==0 || searchArray==nil) {
        _tblCustomiseDietPlan.hidden=YES;
        return;
    }
    _tblCustomiseDietPlan.hidden=NO;
    isSearch=YES;
    [_tblCustomiseDietPlan reloadData];
    
}
- (IBAction)btnAdd:(id)sender {
    CreateNewDietPlanController *dietCustomise=[[CreateNewDietPlanController alloc]init];
    [self.navigationController pushViewController:dietCustomise animated:YES];
}

#pragma calling api for custom diet plan

- (void)workoutExercise {
    
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:Kurlgetdietplanall apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionary];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
              
                    if (MainDataArray == nil) {
                        MainDataArray = [[NSMutableArray alloc] init];
                    }
                
                MainDataArray=[[json objectForKey:@"returnset"] mutableCopy] ;
                _tblCustomiseDietPlan.hidden=NO;
                [_tblCustomiseDietPlan reloadData];
                [hudFirst hide:YES];
                
            }
            else{
                _tblCustomiseDietPlan.hidden=YES;
                [hudFirst hide:YES];
            }
        }
        else{
            _lblError.text=@"Something went wrong. Please try again later";
            [hudFirst hide:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         _lblError.text=@"Something went wrong. Please try again later";
        [hudFirst hide:YES];
    }];
    
}

@end
