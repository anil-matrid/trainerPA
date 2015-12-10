//
//  DietPlanController.m
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DietPlanController.h"
#import "Constants.h"
#import "clientDietPlan.h"
#import "updateDietPlanController.h"
#import "CreateNewDietPlanController.h"
@interface DietPlanController ()
{
    BOOL LongPressFlag;   // hold that longpress selection is avilable or not
    NSMutableArray *selectedUserArray;
    NSMutableArray *myClient;
    int selectedUser;
    NSString *strt;
    NSMutableArray *titlesCustom;
    NSString *userID;
    AFHTTPRequestOperationManager *manager1;
    NSMutableDictionary *dicInformation;
    NSMutableArray *jsonArray;
    NSMutableArray *dataArray ; // Main data array who stroe all the values
    UITableView *dietPlan;
    NSMutableArray *carrayOtherinfoArrray;
    NSString *dietID;
    NSInteger index;
}

@end

@implementation DietPlanController

@synthesize titles,discriptions,images,addDietPlanView,workout,Library,navigationBar;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"DietPlanController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"DietPlanController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"DietPlanController_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Diet Plan Controller"];
    if (IS_IPHONE_5_OR_MORE) {
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
            dietPlan=[[UITableView alloc]initWithFrame:CGRectMake(0, 84, 320, 484)];
            _addBtn.hidden=YES;

        }
        else{
            dietPlan=[[UITableView alloc]initWithFrame:CGRectMake(0, 84, 320, 430)];
        }
        
    }
    else {
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
            dietPlan=[[UITableView alloc]initWithFrame:CGRectMake(0, 84, 320, 396)];
            _addBtn.hidden=YES;

        }
        else {
            dietPlan=[[UITableView alloc]initWithFrame:CGRectMake(0, 84, 320, 342)];
        }
    }
    dietPlan.delegate=self;
    dietPlan.dataSource=self;
    [dietPlan setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:dietPlan];
    [self.view sendSubviewToBack:dietPlan];
    dietPlan.separatorColor=[UIColor clearColor];
    
    
    _yes.layer.cornerRadius=_yes.frame.size.height/2;
    _no.layer.cornerRadius=_no.frame.size.height/2;
    //Implimenting Rightmenu
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

    
    selectedUser=0;
    LongPressFlag=NO;
    // Do any additional setup after loading the view from its nib.
    //adding data in array
    selectedUserArray=[[NSMutableArray alloc]init];
  //  titles=[NSMutableArray arrayWithObjects:@"Breakfast", @"Lunch", @"Dinner",nil];
    titlesCustom=[NSMutableArray arrayWithObjects:@"Breakfast", @"Lunch", @"Dinner",nil];
  
    images=[[NSMutableArray alloc]init];
    discriptions=[[NSMutableArray alloc]init];
    addDietPlanView.hidden = YES;
    _bluredView.hidden = YES;
    _confirmationView.hidden=YES;
    //to make button rounded corner
    Library.layer.cornerRadius = 11;
    workout.layer.cornerRadius = 11;
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (selectedUserArray.count==0) {
        CGPoint p = [gestureRecognizer locationInView:dietPlan];
        NSIndexPath *indexPath = [dietPlan indexPathForRowAtPoint:p];
        [selectedUserArray addObject:indexPath];
        LongPressFlag=YES;
        [dietPlan reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    carrayOtherinfoArrray=[[NSMutableArray alloc] init];
    discriptions=[[NSMutableArray alloc]init];
    [self CallDataFromServer];
    _errorVIewDIetPlan.hidden=YES;
    userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    [[SingletonClass singleton].DietPlanSelected removeAllObjects];
    [[SingletonClass singleton].dietArray removeAllObjects];
    
    [[SingletonClass singleton].breakfastdietPlanBundelFood removeAllObjects];
    [[SingletonClass singleton].breakfastdietPlanBundelSuppliment removeAllObjects];
    [[SingletonClass singleton].lunchdietPlanBundelArray removeAllObjects];
    [[SingletonClass singleton].lunchdietPlanBundelSuppliment removeAllObjects];
    [[SingletonClass singleton].snaksdietPlanBundelArray removeAllObjects];
    [[SingletonClass singleton].snaksdietPlanBundelSuppliment removeAllObjects];
    [[SingletonClass singleton].dinnerdietPlanBundelArray removeAllObjects];
    [[SingletonClass singleton].dinnerdietPlanBundelSuppliment removeAllObjects];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [manager1.operationQueue cancelAllOperations];
    [super viewWillDisappear:YES];
}
-(void)CallDataFromServer
{
    
    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    
    NSString *urlString = [Globals urlCombileHash:kApiDomin ClassUrl:KUrlGetDietMeals apiKey:[Globals apiKey]];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"uid", nil];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        inputDic=[NSDictionary dictionary];
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        inputDic=[NSDictionary dictionary];
    }
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        
        if (json !=nil && json.allKeys.count!=0) {
            
            if([[json objectForKey:@"message"] isEqualToString:@"Data Returned Successfully"]) {
                [self GetDataFromService:json];
                jsonArray=[[json objectForKey:@"returnset"] mutableCopy];
                NSString *nullStr = @"";
                [jsonArray  removeObject:nullStr];
                for (int i=0;i<jsonArray.count; i++) {
                    NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                    
                    
                    NSMutableDictionary *breakFastDic =[[[jsonArray objectAtIndex:i] objectForKey:@"breakfast"] mutableCopy];
                    NSMutableDictionary *lunchDic =[[[jsonArray objectAtIndex:i] objectForKey:@"lunch"] mutableCopy];
                    NSMutableDictionary *snackDic =[[[jsonArray objectAtIndex:i] objectForKey:@"snacks"] mutableCopy];
                    NSMutableDictionary *dinnerDic =[[[jsonArray objectAtIndex:i] objectForKey:@"dinner"] mutableCopy];
                    NSMutableDictionary *main =[[jsonArray objectAtIndex:i]  mutableCopy];
                    
                    breakFastDic = [[self seperateTheSupplimentAndDiet:breakFastDic] mutableCopy];
                    lunchDic = [[self seperateTheSupplimentAndDiet:lunchDic] mutableCopy];
                    snackDic = [[self seperateTheSupplimentAndDiet:snackDic] mutableCopy];
                    dinnerDic = [[self seperateTheSupplimentAndDiet:dinnerDic] mutableCopy];
                    
                    [main removeObjectForKey:@"breakfast"];
                    [main removeObjectForKey:@"lunch"];
                    [main removeObjectForKey:@"snacks"];
                    [main removeObjectForKey:@"dinner"];
                    [carrayOtherinfoArrray addObject:main];

                    if(breakFastDic.allKeys.count!=0) {
                        [temp setObject:breakFastDic forKey:@"breakfast"];
                    }
                    if(lunchDic.allKeys.count!=0) {
                        [temp setObject:lunchDic forKey:@"lunch"];
                    }
                    if(snackDic.allKeys.count!=0) {
                        [temp setObject:snackDic forKey:@"snacks"];
                    }
                    if(dinnerDic.allKeys.count!=0) {
                        [temp setObject:dinnerDic forKey:@"dinner"];
                    }
                        NSMutableDictionary* mutableDict = [temp mutableCopy];
                        for (id key in temp) {
                        id value = [temp objectForKey: key];
                        if ([@"" isEqual: value]) {
                            [mutableDict removeObjectForKey:key];
                        }
                    }
                    temp = [mutableDict copy];
                        [discriptions addObject:temp];
                }
                dietPlan.hidden=NO;
                self.errorVIewDIetPlan.hidden=YES;
                [dietPlan reloadData];
            }
            else{
                [hudFirst hide:YES];
                dietPlan.hidden=YES;
                self.errorVIewDIetPlan.hidden=NO;
                [self.view bringSubviewToFront:self.errorVIewDIetPlan];
               // [Globals alert:@"No data found"];
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        dietPlan.hidden=YES;
        self.errorVIewDIetPlan.hidden=NO;
        [self.view bringSubviewToFront:self.errorVIewDIetPlan];
        [Globals alert:@"Something went wrong. Please try again later"];
    }];
}

-(void)GetDataFromService:(NSDictionary *)json{
    dataArray =[NSMutableArray array];
    NSArray *MainArray = [json objectForKey:@"returnset"];
    for (int i = 0 ; i<MainArray.count; i++) {
        NSDictionary *mainDic = [MainArray objectAtIndex:i];
        NSMutableArray *dietArray = [NSMutableArray array];
        NSMutableDictionary *breakFastDic =[[mainDic objectForKey:@"breakfast"] mutableCopy];
        NSMutableDictionary *lunchDic =[[mainDic objectForKey:@"lunch"] mutableCopy];
        NSMutableDictionary *snackDic =[[mainDic objectForKey:@"snacks"] mutableCopy];
        NSMutableDictionary *dinnerDic =[[mainDic objectForKey:@"dinner"] mutableCopy];
        
                breakFastDic = [[self seperateTheSupplimentAndDiet:breakFastDic] mutableCopy];
                lunchDic = [[self seperateTheSupplimentAndDiet:lunchDic] mutableCopy];
                snackDic = [[self seperateTheSupplimentAndDiet:snackDic] mutableCopy];
                dinnerDic = [[self seperateTheSupplimentAndDiet:dinnerDic] mutableCopy];
       
        
        if ([[breakFastDic objectForKey:@"supplement"]count]!=0 || [[breakFastDic objectForKey:@"dietFood"] count]!=0) {
            [dietArray addObject:breakFastDic];
        }
        
        if ([[lunchDic objectForKey:@"supplement"]count]!=0 || [[lunchDic objectForKey:@"dietFood"] count]!=0) {
            [dietArray addObject:lunchDic];
        }
        if ([[snackDic objectForKey:@"supplement"]count]!=0 || [[snackDic objectForKey:@"dietFood"] count]!=0) {
            [dietArray addObject:snackDic];
        }
        if ([[dinnerDic objectForKey:@"supplement"]count]!=0 || [[dinnerDic objectForKey:@"dietFood"] count]!=0) {
            [dietArray addObject:dinnerDic];
        }
        [dataArray addObject:dietArray];
    }
    
    [SingletonClass singleton].dietArray = [dataArray mutableCopy];
    
}
-(NSMutableDictionary*)seperateTheSupplimentAndDiet:(NSMutableDictionary *)Dictionary{

    NSArray *itemArray=[Dictionary objectForKey:@"items"];
    NSMutableArray *dietPlanFoodArray=[NSMutableArray array];
    NSMutableArray *SupplementFoodArray=[NSMutableArray array];
    for (int i=0; i<itemArray.count; i++) {
        NSDictionary *CurrentDic=[itemArray objectAtIndex:i];
        if ([CurrentDic objectForKey:@"supplement"] && [[CurrentDic objectForKey:@"supplement"]isEqualToString:@"0"]) {
            [dietPlanFoodArray addObject:CurrentDic];
        }
        else{
                        [SupplementFoodArray addObject:CurrentDic];
        }
    }
    [Dictionary removeObjectForKey:@"items"];
    [Dictionary setObject:dietPlanFoodArray forKey:@"dietFood"];
    [Dictionary setObject:SupplementFoodArray forKey:@"supplement"];
    return Dictionary;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableView method**************************


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    NSArray *diet=[dataArray objectAtIndex:section];
       return diet.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellforRowAtIndex: %ld",(long)indexPath.row);
    static NSString *simple=@"simpleTable";
    CustomTableDiet *cell=(CustomTableDiet*)[tableView dequeueReusableCellWithIdentifier:simple];
    
    if (cell==nil) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CustomTableDiet" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    
    cell.tick.backgroundColor=[UIColor clearColor];
    
    if (LongPressFlag) {
        if ([selectedUserArray containsObject:indexPath]) {
            cell.tick.image=[UIImage imageNamed:@"tick.png"];
           // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else
        {
            cell.tick.image=nil;
        }
    }

    NSArray *diet=[dataArray objectAtIndex:indexPath.section];
    NSDictionary *cuurentDic = [diet objectAtIndex:indexPath.row];
//    if ([discriptions valueForKey:@"breakfast"]!=nil) {
//       
//    }
//    else if ([discriptions valueForKey:@"lunch"]!=nil) {
//        
//    }
     cell.dietName.text=[cuurentDic valueForKey:@"type"];
    cell.dietDisc.text=[cuurentDic valueForKey:@"details"];
    if ([[cuurentDic valueForKey:@"type"] isEqualToString:@"breakfast"]) {
        cell.dietImage.image=[UIImage imageNamed:@"Diet_plan1.png"];
    }
    else if ([[cuurentDic valueForKey:@"type"] isEqualToString:@"dinner"] || [[cuurentDic valueForKey:@"type"] isEqualToString:@"lunch"]) {
        cell.dietImage.image=[UIImage imageNamed:@"Diet_plan4.png"];
    }
    else if ([[cuurentDic valueForKey:@"type"] isEqualToString:@"snacks"] || [[cuurentDic valueForKey:@"type"] isEqualToString:@"snack"]) {
        cell.dietImage.image=[UIImage imageNamed:@"Diet_plan2.png"];
    }
   cell.dietImage.contentMode = UIViewContentModeScaleAspectFit;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self action:@selector(SelectedSectonView:) forControlEvents:UIControlEventTouchUpInside];
        button.tag= indexPath.section;
        [button setBackgroundColor:[UIColor clearColor]];
        button.frame =cell.frame;
        [cell addSubview:button];
    }

//    cell.dietName.text=[[[discriptions valueForKey:@"dinner"]objectAtIndex:indexPath.row ] valueForKey:@"type"];
//    cell.dietDisc.text=[[discriptions objectAtIndex:indexPath.row ] valueForKey:@"prepare"];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
        UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]]; //your background color...
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10,6,tableView.frame.size.width, 25)];
        [label setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
        [label setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [label setBackgroundColor:[UIColor clearColor]];
        
        UIButton *btnCross=[[UIButton alloc]initWithFrame:CGRectMake(260, 0, 50, 40)];
        btnCross.tag=section;
        [btnCross setImage:[UIImage imageNamed:@"cross.png"] forState:normal];
        [btnCross addTarget:self action:@selector(deleteBundle:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *UpImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 2)];
        UpImage.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        
        UIImageView *DownImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, views.frame.size.height-2, self.view.frame.size.width, 2)];
        DownImage.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
        NSString *string = [[jsonArray objectAtIndex:section] valueForKey:@"name"];
        /* Section header is in 0th index...  x=11 y=13 */
        [label setText:string];
        [views addSubview:label];
        [views addSubview:UpImage];
        [views addSubview:DownImage];
    
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button addTarget:self action:@selector(SelectedSectonView:) forControlEvents:UIControlEventTouchUpInside];
            button.tag= section;
            [button setBackgroundColor:[UIColor clearColor]];
            button.frame = views.frame;
            [views addSubview:button];
        }
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
        [views addSubview:btnCross];
    }
    
    return views;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        clientDietPlan *dietPlans=[[clientDietPlan alloc]init];
        dietPlans.dicty=[[[dataArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row ]mutableCopy];
        [self.navigationController pushViewController:dietPlans animated:YES];
    }
}

-(IBAction)SelectedSectonView:(UIButton *)sender{
    
    dicInformation=[discriptions objectAtIndex:sender.tag];
    DietPlanCustonise *dietIndividual=[[DietPlanCustonise alloc]init];
    dietIndividual.diet_id = [[carrayOtherinfoArrray objectAtIndex:sender.tag] objectForKey:@"diet_id"];
//    [SingletonClass singleton].DietPlanSelected = [dicInformation mutableCopy];
//    dietIndividual.preClass=@"dietPlan";
    
    [self.navigationController pushViewController:dietIndividual animated:YES];
}

-(void)deleteBundle:(UIButton *)senderBtn {
    index=senderBtn.tag;
    dietID = [[dataArray objectAtIndex:senderBtn.tag] valueForKey:@"diet_id"];
    _confirmationView.hidden=NO;
    _bluredView.hidden=NO;
}
-(void)userSelclected:(UIButton *)senderBtn
{
    selectedUser=(int)senderBtn.tag;
    [dietPlan reloadData];
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)Library:(id)sender {
    LibraryController *lib=[[LibraryController alloc]init];
    [self.navigationController pushViewController:lib animated:YES];
    addDietPlanView.hidden = YES;
    _bluredView.hidden=YES;
}

- (IBAction)workout:(id)sender {
    dietPlanCustomDietPlan *dietCustomise=[[dietPlanCustomDietPlan alloc]init];
    [self.navigationController pushViewController:dietCustomise animated:YES];
    addDietPlanView.hidden = YES;
    _bluredView.hidden=YES;
}
- (IBAction)addNewDietPlan:(id)sender {
    self.errorVIewDIetPlan.hidden=YES;
    addDietPlanView.hidden = NO;
    _bluredView.hidden=NO;
    [self.view bringSubviewToFront:addDietPlanView];
}

#pragma mark -Cache Methods
-(void) saveUserImagesIntoCache:(NSMutableArray*)ResponseArray
{
    //Save images in chache
    for (int i=0; i<[ResponseArray count]; i++) {
        
        
        
        NSString *str=[[ResponseArray objectAtIndex:i]valueForKey:@"image"];
        
        NSMutableDictionary *dicAttachmentDetails = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"SenderImg",@"",@"folder", nil];
        if ([str isEqual:[NSNull null]]) {
        }
        else{
            [dicAttachmentDetails setObject:[NSURL URLWithString:str] forKey:@"imageUrl"];
            
        }
        [dicAttachmentDetails setObject:kCachedImagesFolder forKey:@"folder"];
        
        [NSThread detachNewThreadSelector:@selector(callMethodToCacheImage:) toTarget:self withObject:dicAttachmentDetails];
        
    }
}


-(void)callMethodToCacheImage:(NSMutableDictionary *)dict
{
    [tVateApi createImageCache:dict :@""];
}

+(UIImage*)getImagesFromCache :(NSString*)imageUrl
{
    UIImage *ReturnImage;
    
    NSString *ImageUrL = imageUrl;
    
    if ([ImageUrL isEqual:[NSNull null]])
    {
        ReturnImage=[UIImage imageNamed:@"imageCellgreen-ipad.png"];
        return ReturnImage;
        
    }
    else
    {
        UIImage *image = [tVateApi checkForImagesFromCaching:[NSURL URLWithString:ImageUrL] andFolder:kCachedImagesFolder];
        
        if (image == nil)
        {
            ReturnImage=[UIImage imageNamed:@"imageCellgreen-ipad.png"];
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            
            [manager downloadWithURL:[NSURL URLWithString:ImageUrL]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize)
             {
                 
             }
                           completed:^(UIImage *imageCached, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 if (imageCached)
                 {
                     UIImage *ReturnImage;
                     ReturnImage=imageCached;
                 }
                 
             }];
            
        }
        else
        {
            ReturnImage=image;
            return ReturnImage;
        }
        return ReturnImage;
    }
}
- (IBAction)BtnCrossPopView:(UIButton *)sender {
    addDietPlanView.hidden=YES;
    self.bluredView.hidden=YES;
}

-(void)deleteDietPaln
{
    
    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString = [Globals urlCombileHash:kApiDomin ClassUrl:@"deletedietplanentry/" apiKey:[Globals apiKey]];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:clientID,@"uid",dietID,@"diet_id", nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        [hudFirst hide:YES];
        if ([[responseObject objectForKey:@"status_code" ] isEqualToString:@"SUCCESS"]) {
            [dataArray removeObjectAtIndex:index];
            [jsonArray removeObjectAtIndex:index];
            [dietPlan reloadData];
        }
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
}

- (IBAction)yes:(id)sender {
    _bluredView.hidden=YES;
    _confirmationView.hidden=YES;
    [self deleteDietPaln];
}

- (IBAction)no:(id)sender {
    _bluredView.hidden=YES;
    _confirmationView.hidden=YES;
}
@end
