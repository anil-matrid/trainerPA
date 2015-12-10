//
//  LibraryController.m
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "LibraryController.h"
#import "Constants.h"

@interface LibraryController ()
{
    NSMutableArray *Titles;
    NSMutableArray *Images;
    NSMutableArray *Discreptions;
    NSString *strt;
    NSMutableArray *selectedData;
    NSMutableArray *libraryDietTitle;
    NSMutableDictionary *dicInformation;
    NSMutableArray *json2;
    NSMutableArray *carrayOtherinfoArrray;
    BOOL search;
    BOOL LongPressFlag;
    BOOL isSent;
    int selectedUser;
    int selectedFlag;
}

@end

@implementation LibraryController

{
    NSArray *recipes;
    NSArray *searchResults;

}
@synthesize dietLibraryView,bluredView,navigationBar;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"LibraryController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"LibraryController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"LibraryController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Library Controller"];
    // Do any additional setup after loading the view from its nib.
        Titles=[[NSMutableArray alloc]init];
//    libraryDietTitle=[NSMutableArray arrayWithObjects:@"Fat Burn diet Plan",@"Muscle building Diet Plan", nil];
    Discreptions=[[NSMutableArray alloc]init];
    selectedData=[[NSMutableArray alloc]init];
    json2=[[NSMutableArray alloc]init];
    dietLibraryView.hidden=YES;
    bluredView.hidden=YES;
    carrayOtherinfoArrray=[[NSMutableArray alloc] init];
    search=NO;
    isSent=NO;
    [self CallDataFromServer];
    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    selectedFlag=0;
    selectedUser=0;
    _lblError.hidden=YES;
    _lblError.hidden=YES;
    _crossBtn.hidden=YES;
    LongPressFlag=NO;
    
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (selectedData.count==0) {
        CGPoint p = [gestureRecognizer locationInView:_libraryDietPlan];
        NSIndexPath *indexPath = [_libraryDietPlan indexPathForRowAtPoint:p];
        [selectedData addObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"diet_id"]];
        LongPressFlag=YES;
        [_libraryDietPlan reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [Titles count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simple=@"simpleTable";
    CustomTableDiet *cell=(CustomTableDiet *)[tableView dequeueReusableCellWithIdentifier:simple];
    if (cell==nil) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CustomTableDiet" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    if (LongPressFlag) {
        if ([selectedData containsObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"diet_id"]]) {
            cell.tick.image=[UIImage imageNamed:@"tick.png"];
            // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else
        {
            cell.tick.image=nil;
        }
    }
    cell.dietImage.image=[UIImage imageNamed:@"noimage.png"];
    cell.dietName.text=[Titles objectAtIndex:indexPath.row];
    //cell.dietDisc.text=[Discreptions objectAtIndex:indexPath.row];
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.75; //seconds
    lpgr.delegate = self;
    [cell addGestureRecognizer:lpgr];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (LongPressFlag==YES) {
        
        if ([selectedData containsObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"diet_id"]]) {
            NSUInteger value=[selectedData indexOfObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"diet_id"]];
            [selectedData removeObjectAtIndex:value];
            if(selectedData.count==0) {
                LongPressFlag=NO;
                [self.view setNeedsDisplay];
            }
        }
        else {
            [selectedData addObject:[[json2 objectAtIndex:indexPath.row] valueForKey:@"diet_id"]];
        }
        [_libraryDietPlan reloadData];
    }
    else {
        DietPlanCustonise *dietIndividual=[[DietPlanCustonise alloc]init];
        dietIndividual.diet_id = [Discreptions objectAtIndex:indexPath.row];
        [SingletonClass singleton].DietPlanSelected = [dicInformation mutableCopy];
        dietIndividual.preClass=@"dietPlanLibrary";
        [self.navigationController pushViewController:dietIndividual animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

int dietLibrary=0;
- (IBAction)send:(id)sender {
    if(selectedData.count==0){
        bluredView.hidden=NO;
        dietLibraryView.hidden=NO;
        _lblError.hidden=NO;
        _lblToHide.hidden=NO;
        _lblMessage.text=@"Please select atleast one diet plan.";
        dietLibrary++;
        return;
    }
    [self SendDeit];
   
}

- (IBAction)backView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)ok:(id)sender {
    dietLibraryView.hidden=YES;
    bluredView.hidden=YES;
    if (isSent==YES) {
        DietPlanController *dietControll=[[DietPlanController alloc]initWithNibName:@"DietPlanController" bundle:nil];
        [self.navigationController pushViewController:dietControll animated:YES];
    }    
    dietLibrary=0;
}

#pragma  get custom food api ********************************
-(void)CallDataFromServer
{

    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSDictionary *inputDic;
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:@"getdefaultplans/" apiKey:[Globals apiKey]];
    inputDic=[NSDictionary dictionary];
    if (search==YES) {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:_textSearch.text,@"name", nil];
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"])
            {
                [hudFirst hide:YES];
                json2=[json objectForKey:@"returnset"];
                Titles=[json2 valueForKey:@"name"];
                Discreptions=[json2 valueForKey:@"diet_id"];
                json2=[json objectForKey:@"returnset"];
                [_libraryDietPlan reloadData];
                search=NO;
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:@"No data found"];
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Something went wrong. Please try again later"];
    }];
}

- (IBAction)btnCrossPopUp:(UIButton *)sender {
    bluredView.hidden=YES;
    dietLibraryView.hidden=YES;
}

- (IBAction)search:(id)sender {
    search=YES;
    [self CallDataFromServer];
}

-(void)SendDeit {
    
    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSDictionary *inputDic;
    NSString *diet_id=[selectedData componentsJoinedByString:@","];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:@"multirecommendplan/" apiKey:[Globals apiKey]];
    inputDic=[NSDictionary dictionaryWithObjectsAndKeys:diet_id,@"diet_id",clientID,@"clientID", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if([[json objectForKey:@"status_code"] isEqualToString:@"Success"]) {
                [hudFirst hide:YES];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
                [hudFirst hide:YES];
                [Globals alert:@"No data found"];
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        [Globals alert:@"Sorry! Internal Server Error."];
    }];
}

@end
