//
//  DietPlanCustomiseController1.m
//  TrainerVate
//
//  Created by Matrid on 09/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DietPlanCustomiseController1.h"
#import "Constants.h"
#import "SingletonClass.h"

@interface DietPlanCustomiseController1 () {
     NSMutableArray *dietTitles;
     NSMutableArray *dietImages;
     NSMutableArray *dietDiscreptions;
     NSString *dietstrt;
     NSMutableDictionary *dicInformation;
     NSMutableArray *tempData;
    NSArray *pid;
    NSMutableArray * MainArrayData;
    NSMutableArray *userImage;
}


@end

@implementation DietPlanCustomiseController1
@synthesize preClass;
@synthesize dietPlanTable,viewDietCustomise,navigationBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"DietPlanCustomiseController1_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"DietPlanCustomiseController1" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"DietPlanCustomiseController1_4" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Diet Plan Customise Controller 1"];
    // Do any additional setup after loading the view from its nib.
    viewDietCustomise.hidden=YES;
    dietTitles=[[NSMutableArray alloc]init];
    userImage=[[NSMutableArray alloc]init];
    dietDiscreptions=[[NSMutableArray alloc]init];
    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    MainArrayData = [[NSMutableArray alloc] init];
    if ([preClass isEqualToString:@"breakfast"]) {
        MainArrayData = [[SingletonClass singleton].breakfastdietPlanBundelFood mutableCopy];
    }
    else if ([preClass isEqualToString:@"lunch"]){
            MainArrayData = [[SingletonClass singleton].lunchdietPlanBundelArray mutableCopy];
    }
    else if ([preClass isEqualToString:@"dinner"]){
            MainArrayData = [[SingletonClass singleton].dinnerdietPlanBundelArray mutableCopy];
    }
    else if ([preClass isEqualToString:@"customDiet"]){
        
    }
    else{
        MainArrayData = [[SingletonClass singleton].snaksdietPlanBundelArray mutableCopy];
    }
}
int senderTag=0;

-(void)viewWillAppear:(BOOL)animated {
    [self CallDataFromServer];
    if ([preClass isEqualToString:@"customDiet"]) {
        NSMutableDictionary *dataDictionary=[[SingletonClass singleton].DietPlanSelected mutableCopy];
        NSMutableDictionary *currentDic;
        NSString *kayName=@"";
        NSLog(@"%d",self.dietPlanIndexPath);
        NSMutableArray *currentArry;
        if (self.dietPlanIndexPath==0) {
            currentDic=[[dataDictionary objectForKey:@"breakfast"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"breakfast";
            
            
        }
        else if (self.dietPlanIndexPath==1){
            currentDic=[[dataDictionary objectForKey:@"lunch"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            
            kayName=@"lunch";
        }
        else if (self.dietPlanIndexPath==2){
            currentDic=[[dataDictionary objectForKey:@"snacks"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"snacks";
        }
        else if (self.dietPlanIndexPath==3){
            currentDic=[[dataDictionary objectForKey:@"dinner"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"dinner";
        }
        
        
        MainArrayData = [currentArry mutableCopy];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
   
}

#pragma tableView method**********************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dietTitles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simple=@"simpleTable";
    CustomTableDiet *cell=(CustomTableDiet *)[tableView dequeueReusableCellWithIdentifier:simple];
    if (cell==nil) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CustomTableDiet" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    
    NSString *foodImage;
    if ([userImage objectAtIndex:indexPath.row]==nil || [[userImage objectAtIndex:indexPath.row] isEqual:[NSNull null] ] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@"NULL"] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@""] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@"null"]) {
        cell.dietImage.image=[UIImage imageNamed:@"noimage.png"];
    }
    else {
        foodImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[userImage objectAtIndex:indexPath.row]];
        cell.dietImage.image=[Globals getImagesFromCache:[userImage objectAtIndex:indexPath.row]];
    }
    cell.dietName.text=[dietTitles objectAtIndex:indexPath.row];
    cell.dietDisc.text=[dietDiscreptions objectAtIndex:indexPath.row];
   
     if ([preClass isEqualToString:@"customDiet"]) {
         if ([[MainArrayData valueForKey:@"name"]containsObject:[dietTitles objectAtIndex:indexPath.row]]) {
             cell.tick.image=[UIImage imageNamed:@"tick.png"];
             // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
         }
         else if ([[MainArrayData valueForKey:@"Long_Desc"]containsObject:[dietTitles objectAtIndex:indexPath.row]]){
         cell.tick.image=[UIImage imageNamed:@"tick.png"];
         }
         else
         {
             cell.tick.image=nil;
         }

     }
     else{
         if ([[MainArrayData valueForKey:@"Long_Desc"]containsObject:[dietTitles objectAtIndex:indexPath.row]]) {
             cell.tick.image=[UIImage imageNamed:@"tick.png"];
             // [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
         }
         else
         {
             cell.tick.image=nil;
         }

     }
    
    cell.tick.backgroundColor=[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MainArrayData==nil) {
        MainArrayData = [[NSMutableArray alloc] init];
    }
    if ([[MainArrayData valueForKey:@"Long_Desc"]containsObject:[dietTitles objectAtIndex:indexPath.row]] || [[MainArrayData valueForKey:@"name"]containsObject:[dietTitles objectAtIndex:indexPath.row]]) {
        
        NSInteger indexValue=0;
        for (int i =0;i<MainArrayData.count; i++) {
            NSDictionary *CurrentDic = [MainArrayData objectAtIndex:i];
            if ([[CurrentDic objectForKey:@"name"] isEqualToString:[dietTitles objectAtIndex:indexPath.row]]) {
                indexValue = i;
                break;
            }
            else if ([[CurrentDic objectForKey:@"Long_Desc"]isEqualToString:[dietTitles objectAtIndex:indexPath.row] ]){
                indexValue=i;
                break;
            }
           
        }
    
        [MainArrayData removeObjectAtIndex:indexValue];
    }
    else
    {
        [MainArrayData  addObject:[tempData objectAtIndex:indexPath.row]];
    }
    [dietPlanTable reloadData];
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttons actions**************
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addDiet:(id)sender {
    if ([preClass isEqualToString:@"breakfast"]) {
        [SingletonClass singleton].breakfastdietPlanBundelFood=MainArrayData;
    }
    else if ([preClass isEqualToString:@"lunch"]){
        [SingletonClass singleton].lunchdietPlanBundelArray=MainArrayData;
    }
    else if ([preClass isEqualToString:@"dinner"]){
        [SingletonClass singleton].dinnerdietPlanBundelArray=MainArrayData;
    }
    else if ([preClass isEqualToString:@"customDiet"]){
         [self updateTheDietPlanMainSingletionUpdate];
    }
    else{
        [SingletonClass singleton].snaksdietPlanBundelArray=MainArrayData;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSearch:(id)sender {
    senderTag=(int)[sender tag];
    dietTitles=nil;
    dietDiscreptions=nil;
    [self CallDataFromServer];
}

- (IBAction)add:(id)sender {
    
    SentToClientController *sentToClient=[[SentToClientController alloc]initWithNibName:@"SentToClientController" bundle:nil];
    [self.navigationController pushViewController:sentToClient animated:YES];
}
//DietPlanCustonise
#pragma  get custom food api ********************************
-(void)CallDataFromServer
{
    [self.view endEditing:YES];
    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSDictionary *inputDic;
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlgetDietFood apiKey:[Globals apiKey]];
   // if (senderTag==10) {
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:_txtSearch.text,@"Long_Desc", nil];
//    }
//    else{
//    inputDic=[NSDictionary dictionary];
//    // cartResponse
//    }
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"])
            {
                [hudFirst hide:YES];
                tempData=[[json objectForKey:@"returnset"] mutableCopy];
                userImage=[tempData valueForKey:@"thumbnail"];
                dietTitles=[tempData valueForKey:@"Long_Desc"];
                dietDiscreptions=[tempData valueForKey:@"kcal"];
                pid=[tempData valueForKey:@"NDB_No"];
                for (int i=0; i<userImage.count; i++) {
                    NSString *foodImage;
                    if (![[userImage objectAtIndex:i] isEqualToString:@""]) {
                        foodImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[userImage objectAtIndex:i]];
                        [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:[userImage objectAtIndex:i]]];
                    }
                }

                [dietPlanTable reloadData];
                _errorView.hidden=YES;
                [self updateTempData];
            }
            else{
                [hudFirst hide:YES];
                _errorView.hidden=NO;
                _lblMessage.text=@"No result found!";
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
         _errorView.hidden=NO;
        _lblMessage.text=@"Something went wrong! Please try again later.";
    }];
}

-(void)updateTempData{
     if ([preClass isEqualToString:@"customDiet"]) {
         return;
     }
    
    
    if ([preClass isEqualToString:@"breakfast"]) {
        MainArrayData = [[SingletonClass singleton].breakfastdietPlanBundelFood mutableCopy];
    }
    else if ([preClass isEqualToString:@"lunch"]){
        MainArrayData = [[SingletonClass singleton].lunchdietPlanBundelArray mutableCopy];
    }
    else if ([preClass isEqualToString:@"dinner"]){
        MainArrayData = [[SingletonClass singleton].dinnerdietPlanBundelArray mutableCopy];
    }
    else{
        MainArrayData = [[SingletonClass singleton].snaksdietPlanBundelArray mutableCopy];
    }
    
    for ( int i=0; i<tempData.count; i++) {
        NSMutableDictionary * currentDic = [[tempData objectAtIndex:i] mutableCopy];
        for (int j=0; j<MainArrayData.count; j++) {
            NSDictionary *MainDic =[[MainArrayData objectAtIndex:j] mutableCopy];
            if ([[MainDic objectForKey:@"NDB_No"]isEqual:[currentDic objectForKey:@"NDB_No"]]) {
                [tempData replaceObjectAtIndex:i withObject:MainDic];
            }
        }
    }
}
-(void)updateTheDietPlanMainSingletionUpdate{
    
    if ([preClass isEqualToString:@"customDiet"]) {
        NSMutableDictionary *dataDictionary=[[SingletonClass singleton].DietPlanSelected mutableCopy];
        NSMutableDictionary *currentDic;
        NSString *kayName=@"";
        NSMutableArray *currentArry;
        if (self.dietPlanIndexPath==0) {
            currentDic=[[dataDictionary objectForKey:@"breakfast"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"breakfast";
        }
        else if (self.dietPlanIndexPath==1){
            currentDic=[[dataDictionary objectForKey:@"lunch"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"lunch";
        }
        else if (self.dietPlanIndexPath==2){
            currentDic=[[dataDictionary objectForKey:@"snacks"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"snacks";
        }
        else if (self.dietPlanIndexPath==3){
            currentDic=[[dataDictionary objectForKey:@"dinner"] mutableCopy];
            currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
            kayName=@"dinner";
        }
        
//        for (int i =0; i<MainArrayData.count; i++) {
//            NSDictionary *preDic=[MainArrayData objectAtIndex:i];
//            if (![currentArry containsObject:preDic]) {
//                [currentArry addObject:preDic];
//            }
//        }
        
        
        
       // currentArry = [[currentArry arrayByAddingObjectsFromArray:MainArrayData] mutableCopy];
        [currentDic setObject:MainArrayData forKey:@"dietFood"];
        [dataDictionary setObject:currentDic forKey:kayName];
        [SingletonClass singleton].DietPlanSelected = [dataDictionary mutableCopy];
    }
}
@end
