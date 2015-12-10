//
//  DietPlanCustonise.m
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DietPlanCustonise.h"
#import "Constants.h"
@interface DietPlanCustonise () {
    NSArray *dietDay;
    NSArray *dietName;
    NSArray *dietKcls;
    NSArray *dietImage;
    NSString *currentSection;
}

@end

@implementation DietPlanCustonise
@synthesize view3,navigationBar,diet_id,dataDictionary,preClass;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"DietPlanCustonise_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"DietPlanCustonise" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"DietPlanCustonise_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Diet Plan Customise"];
    NSLog(@"%@",diet_id);
    // Do any additional setup after loading the view from its nib.
    dietDay=[NSArray arrayWithObjects:@"Breakfast",@"Lunch",@"snacks",@"Dinner", nil];
    dietName=[NSArray arrayWithObjects:@"Quinoa Salad",@"Garlic Bread",@"Quinoa Salad", nil];
    dietKcls=[NSArray arrayWithObjects:@"130 kcal",@"120 kcal",@"130 kcal", nil];
    dietImage=[NSArray arrayWithObjects:@"tea.png",@"spoon.png",@"newicon2.png",@"flow.png", nil];
    dataDictionary=[[NSMutableDictionary alloc]init];
    //  dataDictionary = [[SingletonClass singleton].DietPlanSelected mutableCopy];
    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    [self callDataFromServer];
}
-(void)viewWillAppear:(BOOL)animated {
    
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
    dataDictionary = [[SingletonClass singleton].DietPlanSelected mutableCopy];
    [self.CustomDietTable reloadData];
    [super viewWillAppear:YES];
    // [self callDataFromServer];
    
    //    if ([SingletonClass singleton].DietPlanSelectedProduct !=nil) {
    //        NSMutableArray *curDic = [[SingletonClass singleton].DietPlanSelectedProduct mutableCopy];
    //    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
[SingletonClass singleton].DietPlanSelected = [dataDictionary mutableCopy];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (dataDictionary.allKeys.count==0) {
        return 0;
    }
    return 4;
}

- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dataDictionary.allKeys.count==0) {
        return 0;
    }
    NSDictionary *currentDic;
    NSArray *currentArry;
    NSArray *supplementArray;
    if (indexPath.section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    
    else if (indexPath.section==1){
        currentDic=[dataDictionary objectForKey:@"lunch"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    
    else if (indexPath.section==2){
        currentDic=[dataDictionary objectForKey:@"snacks"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    
    else if (indexPath.section==3){
        currentDic=[dataDictionary objectForKey:@"dinner"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    
    if (currentArry.count==indexPath.row) {
        return 105;
    }
    return 37;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 74;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSDictionary *currentDic;
    NSArray *currentArry;
    NSArray *supplementArray;
    if (section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
        //supplement
    }
    else if (section==1){
        currentDic=[dataDictionary objectForKey:@"lunch"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==2){
        currentDic=[dataDictionary objectForKey:@"snacks"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==3){
        currentDic=[dataDictionary objectForKey:@"dinner"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    if (currentArry.count == 0 && supplementArray.count == 0) {
        return 0.1;
    }
    return 49;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataDictionary.allKeys.count==0) {
        return 0;
    }
    NSDictionary *currentDic;
    NSArray *currentArry;
    NSArray *supplementArray;
    if (section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
        //supplement
    }
    else if (section==1){
        currentDic=[dataDictionary objectForKey:@"lunch"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==2){
        currentDic=[dataDictionary objectForKey:@"snacks"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==3){
        currentDic=[dataDictionary objectForKey:@"dinner"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    return currentArry.count+1+supplementArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataDictionary.allKeys.count==0) {
        return nil;
    }
    NSDictionary *currentDic;
    NSArray *currentArry;
    NSArray *supplementArray;
    if (indexPath.section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
        //supplement
    }
    else if (indexPath.section==1){
        currentDic=[dataDictionary objectForKey:@"lunch"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (indexPath.section==2){
        currentDic=[dataDictionary objectForKey:@"snacks"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (indexPath.section==3){
        currentDic=[dataDictionary objectForKey:@"dinner"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    
    if (currentArry.count==indexPath.row) {
        static NSString *defaultCell=@"default";
        dietFooterCell *cell=(dietFooterCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
        if (cell==NULL) {
            NSArray *dietCustom=[[NSBundle mainBundle]loadNibNamed:@"dietFooterCell" owner:self options:nil];
            cell=[dietCustom objectAtIndex:0];
        }
        [cell.productBtn addTarget:self action:@selector(addProduct:) forControlEvents:UIControlEventTouchUpInside];
        cell.supplymentBtn.tag=indexPath.section;
        [cell.supplymentBtn addTarget:self action:@selector(addSuppliment:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    static NSString *defaultCell=@"default";
    CustomCellDietPlanCustom *cell=(CustomCellDietPlanCustom *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *dietCustom=[[NSBundle mainBundle]loadNibNamed:@"CustomCellDietPlanCustom" owner:self options:nil];
        cell=[dietCustom objectAtIndex:0];
    }
    if (currentArry.count+supplementArray.count==0 ) {
        return cell;
    }
    NSDictionary *cellDic;
    if (currentArry.count>indexPath.row) {
        cellDic=[currentArry objectAtIndex:indexPath.row];
    }
    else{
        cellDic=[supplementArray objectAtIndex:indexPath.row-currentArry.count-1];
    }
//    if ([cellDic objectForKey:@"diet_id"]) {
//        diet_id = [cellDic objectForKey:@"diet_id"];
//    }
    NSString *cellName=@"";
    
    if ([cellDic objectForKey:@"name"]) {
        cellName= [NSString stringWithFormat:@"%@" ,[[cellDic objectForKey:@"name"] isEqual:[NSNull null]] ?@"N.A" :[cellDic objectForKey:@"name"]];
        cell.txtKcal.text=[NSString stringWithFormat:@"%@" ,[[cellDic objectForKey:@"quantity"] isEqual:[NSNull null]] ?@"1" :[cellDic objectForKey:@"quantity"]];
    }
    else if([cellDic objectForKey:@"Long_Desc"]){
        cellName= [NSString stringWithFormat:@"%@" ,[[cellDic objectForKey:@"Long_Desc"] isEqual:[NSNull null]] ?@"N.A" :[cellDic objectForKey:@"Long_Desc"]];
        cell.txtKcal.text=@"1";
    }
    
    cell.dietName.text=cellName;
    cell.txtKcal.delegate=self;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *customizeDiet=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,75)];
    [customizeDiet setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]]; //your background color...
    
    UIImageView *SeperatorUp=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, customizeDiet.frame.size.width, 5)];
    SeperatorUp.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    [customizeDiet addSubview:SeperatorUp];
    // add seperator
    
    UIImageView *Seperator=[[UIImageView alloc]initWithFrame:CGRectMake(0, customizeDiet.frame.size.height-3, customizeDiet.frame.size.width, 3)];
    Seperator.backgroundColor=[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    [customizeDiet addSubview:Seperator];
    
    
    NSDictionary *currentDic;
    NSArray *currentArry;
    NSArray *supplementArray;
    if (section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
        //supplement
    }
    else if (section==1){
        currentDic=[dataDictionary objectForKey:@"lunch"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==2){
        currentDic=[dataDictionary objectForKey:@"snacks"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==3){
        currentDic=[dataDictionary objectForKey:@"dinner"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    
    int totalCal=0;
    for(int i=0;i<currentArry.count;i++){
        NSDictionary *currentProductArray = [currentArry objectAtIndex:i];
        if (![[currentProductArray objectForKey:@"kcal"] isKindOfClass:[NSNull class]]) {
            totalCal = totalCal + [[currentProductArray objectForKey:@"kcal"] intValue];
        }
    }
    
    for(int i=0;i<supplementArray.count;i++){
        NSDictionary *currentProductArray = [supplementArray objectAtIndex:i];
        if (![[currentProductArray objectForKey:@"kcal"] isKindOfClass:[NSNull class]]) {
            totalCal = totalCal + [[currentProductArray objectForKey:@"kcal"] intValue];
        }
    }
    
    UIImageView *dietImages=[[UIImageView alloc]initWithFrame:CGRectMake(25,20,32, 33)];
    dietImages.image=[UIImage imageNamed:[dietImage objectAtIndex:section]];
    
    UILabel *dietTitle=[[UILabel alloc]initWithFrame:CGRectMake(85,20, 96, 33)];
    dietTitle.font=[UIFont fontWithName:@"Lato-Regular" size:20];
    dietTitle.text=[dietDay objectAtIndex:section];
    dietTitle.textColor=[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
    
    UILabel *dietKcal=[[UILabel alloc]initWithFrame:CGRectMake(200,20, 90, 33)];
    dietKcal.font=[UIFont fontWithName:@"Lato-Regular" size:18];
    dietKcal.text=[NSString stringWithFormat:@"%i Kcal",totalCal];
    dietKcal.textColor=[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
    
    [customizeDiet addSubview:dietTitle];
    [customizeDiet addSubview:dietImages];
    [customizeDiet addSubview:dietKcal];
    //return customizeDiet1;
    return customizeDiet;
}

-(void)addProduct:(UIButton *)button {
    
    DietPlanCustomiseController1 *dietCustomise=[[DietPlanCustomiseController1 alloc]init];
    dietCustomise.preClass=@"customDiet";
    NSIndexPath *indexPathCell =[self ButtonIndexPath:button];
    dietCustomise.dietPlanIndexPath =indexPathCell.section;
    
    NSLog(@"%d",dietCustomise.dietPlanIndexPath);
    NSLog(@"%@",[self ButtonIndexPath:button]);
    NSDictionary *currentDic;
    currentDic=[dataDictionary objectForKey:@"breakfast"];
    [currentDic objectForKey:@"supplement"];
    if (indexPathCell.section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        dietCustomise.dietCustomiseData=[currentDic objectForKey:@"dietFood"];
    }
    else if (indexPathCell.section==1) {
        currentDic=[dataDictionary objectForKey:@"lunch"];
        dietCustomise.dietCustomiseData=[currentDic objectForKey:@"dietFood"];
    }
    else if (indexPathCell.section==2) {
         currentDic=[dataDictionary objectForKey:@"snacks"];
        dietCustomise.dietCustomiseData=[currentDic objectForKey:@"dietFood"];
    }
    else if (indexPathCell.section==3) {
        currentDic=[dataDictionary objectForKey:@"dinner"];
        dietCustomise.dietCustomiseData=[currentDic objectForKey:@"dietFood"];
    }
    [self.navigationController pushViewController:dietCustomise animated:YES];
}
-(void)addSuppliment:(UIButton *)button {
    shopController *dietCustomise=[[shopController alloc]init];
    NSString *index=[NSString stringWithFormat:@"%ld",(long)button.tag];
    [[NSUserDefaults standardUserDefaults] setObject:index forKey:@"indexPath"];
    [self.navigationController pushViewController:dietCustomise animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NSMutableDictionary *currentDic;
    NSArray *currentArry;
    NSArray *supplementArray;
    if (section==0) {
        currentDic=[dataDictionary objectForKey:@"breakfast"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
        //supplement
    }
    else if (section==1){
        currentDic=[dataDictionary objectForKey:@"lunch"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==2){
        currentDic=[dataDictionary objectForKey:@"snacks"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    else if (section==3){
        currentDic=[dataDictionary objectForKey:@"dinner"];
        currentArry=[currentDic objectForKey:@"dietFood"];
        supplementArray=[currentDic objectForKey:@"supplement"];
    }
    if (currentArry.count == 0 && supplementArray.count == 0) {
        return nil;
    }
    NSArray *DaysArray=[Globals getDaysIntoInteger:currentDic];
    if ([[currentDic objectForKey:@"weekly"] isEqualToString:@"0"]) {
        DaysArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:0],[NSNumber numberWithInt:1],[NSNumber numberWithInt:2],[NSNumber numberWithInt:3],[NSNumber numberWithInt:4],[NSNumber numberWithInt:5],[NSNumber numberWithInt:6], nil];
        currentDic = [Globals DictionayFormDictionary:DaysArray currentDic:currentDic];
        
        if (section==0) {
            currentDic=[dataDictionary objectForKey:@"breakfast"];
            [dataDictionary setValue:currentDic forKey:@"breakfast"];
        }
        else if (section==1){
            currentDic=[dataDictionary objectForKey:@"lunch"];
            [dataDictionary setValue:currentDic forKey:@"lunch"];
        }
        else if (section==2){
            currentDic=[dataDictionary objectForKey:@"snacks"];
            [dataDictionary setValue:currentDic forKey:@"snacks"];
        }
        else if (section==3){
            currentDic=[dataDictionary objectForKey:@"dinner"];
            [dataDictionary setValue:currentDic forKey:@"dinner"];
        }
    }
    
    NSArray *days=[NSArray arrayWithObjects:@"M",@"T",@"W",@"T",@"F",@"S",@"S", nil];
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,320, 40)];
    footerView.tag=section;
    [footerView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 4)];
    //image.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    int xAxis=23;
    for (int i=0; i<7; i++) {
        UIButton *daysBtn=[[UIButton alloc]initWithFrame:CGRectMake(xAxis, 9, 32, 32)];
        [daysBtn setTitle:[days objectAtIndex:i] forState:UIControlStateNormal];
        daysBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [daysBtn.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:14]];
        daysBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [daysBtn setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        daysBtn.tag=i;
        currentSection=[NSString stringWithFormat:@"%ld",(long)section];
        daysBtn.layer.cornerRadius=daysBtn.frame.size.width/2.0;
        daysBtn.layer.cornerRadius=daysBtn.frame.size.height/2.0;
        daysBtn.clipsToBounds=YES;
        [daysBtn addTarget:self action:@selector(daysSelectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [daysBtn setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
        for (int j=0; j<DaysArray.count; j++) {
            if ([[DaysArray objectAtIndex:j] intValue]==i) {
                [daysBtn setTitleColor:[UIColor whiteColor  ] forState:UIControlStateNormal];
                [daysBtn setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            }
        }
        [footerView addSubview:daysBtn];
        [footerView addSubview:image];
        xAxis=xAxis+40;
    }
    return footerView;
}

- (void)daysSelectedButton:(UIButton *)senderBtn {
    
    NSMutableDictionary *currentDic;
    NSArray *dietArray=[NSArray arrayWithObjects:@"breakfast",@"lunch",@"snacks",@"dinner", nil];
    NSArray *dayWeekArray=[NSArray arrayWithObjects:@"monday",@"tuesday",@"wednesday",@"thursday",@"friday",@"saturday",@"sunday", nil];
    currentDic=[[dataDictionary objectForKey:[dietArray objectAtIndex:senderBtn.superview.tag]] mutableCopy];
    NSArray *DaysArray=[Globals getDaysIntoInteger:currentDic];
    NSLog(@"Seciton %li",(long)senderBtn.superview.tag);
    if ([DaysArray containsObject:[NSNumber numberWithInteger:senderBtn.tag]]) {
        [currentDic setObject:@"0" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
        [senderBtn setTitleColor:[  UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
        [senderBtn setBackgroundColor:[UIColor whiteColor]];
    }
    else{
        [currentDic setObject:@"1" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
        [senderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [senderBtn setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    }
    DaysArray=[Globals getDaysIntoInteger:currentDic];
    if (DaysArray.count==0 ) {
        [currentDic setValue:@"0" forKey:@"weekly"];
    }
    else{
        [currentDic setValue:@"1" forKey:@"weekly"];
    }
    [dataDictionary setObject:currentDic forKey:[dietArray objectAtIndex:senderBtn.superview.tag]];
}

-(void)callDataFromServer{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:Kurlgetdietcontents apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:diet_id,@"diet_id", nil];
    [Globals PostApiURL:urlString data:inputDic success:^(id responseObject) {
        NSDictionary* json = responseObject;
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                NSMutableDictionary *temp=[[NSMutableDictionary alloc]init];
                json = [[json objectForKey:@"returnset"] objectAtIndex:0];
                NSMutableDictionary *breakFastDic =[[json objectForKey:@"breakfast"] mutableCopy];
                NSMutableDictionary *lunchDic =[[json objectForKey:@"lunch"] mutableCopy];
                NSMutableDictionary *snacksDic =[[json objectForKey:@"snacks"] mutableCopy];
                NSMutableDictionary *dinnerDic =[[json objectForKey:@"dinner"] mutableCopy];
                // NSMutableDictionary *main =[[jsonArray objectAtIndex:i]  mutableCopy];
                breakFastDic = [[self seperateTheSupplimentAndDiet:breakFastDic] mutableCopy];
                lunchDic = [[self seperateTheSupplimentAndDiet:lunchDic] mutableCopy];
                snacksDic = [[self seperateTheSupplimentAndDiet:snacksDic] mutableCopy];
                dinnerDic = [[self seperateTheSupplimentAndDiet:dinnerDic] mutableCopy];
                
                [dataDictionary setObject:breakFastDic forKey:@"breakfast"];
                [dataDictionary setObject:lunchDic forKey:@"lunch"];
                [dataDictionary setObject:snacksDic forKey:@"snacks"];
                [dataDictionary setObject:dinnerDic forKey:@"dinner"];
                NSMutableDictionary* mutableDict = [temp mutableCopy];
                for (id key in temp) {
                    id value = [temp objectForKey: key];
                    if ([@"" isEqual: value]) {
                        [mutableDict removeObjectForKey:key];
                    }
                }
            }
            [self.CustomDietTable reloadData];
                [hudFirst hide:YES];
            }
            else{
                [hudFirst hide:YES];
            }
     } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
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

- (IBAction)backDietPlan:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)send:(id)sender {
    // getting all dic
    
    NSMutableDictionary *breakFastdic;
    NSMutableDictionary *lunchDic;
    NSMutableDictionary *snacksDic;
    NSMutableDictionary *dinnerDic;
    
    NSMutableDictionary *breakTempDic  =[[dataDictionary objectForKey:@"breakfast"] mutableCopy];
    breakFastdic = [Globals dietCustomiseSendingDictonary:[breakTempDic objectForKey:@"supplement"] foodDic:[breakTempDic objectForKey:@"dietFood"]:breakTempDic];
    //supplement
    breakFastdic =[[self addTheExtraValueToTheDictionary:breakFastdic tempDic:breakFastdic dietType:@"breakfast"] mutableCopy];
    
    NSMutableDictionary *luncgTempDic  =[[dataDictionary objectForKey:@"lunch"]mutableCopy];
    lunchDic = [[Globals dietCustomiseSendingDictonary:[luncgTempDic objectForKey:@"supplement"] foodDic:[luncgTempDic objectForKey:@"dietFood"] : luncgTempDic] mutableCopy];
    //supplement
    lunchDic =[[self addTheExtraValueToTheDictionary:lunchDic tempDic:luncgTempDic dietType:@"lunch"] mutableCopy];
    
    NSMutableDictionary *snacksTempDic  =[[dataDictionary objectForKey:@"snacks"] mutableCopy];
    snacksDic = [[Globals dietCustomiseSendingDictonary:[snacksTempDic objectForKey:@"supplement"] foodDic:[snacksTempDic objectForKey:@"dietFood"]:snacksTempDic] mutableCopy];
    //supplement
    snacksDic =[[self addTheExtraValueToTheDictionary:snacksDic tempDic:snacksTempDic dietType:@"snacks"] mutableCopy];
    
    NSMutableDictionary *dinnerTempDic  =[[dataDictionary objectForKey:@"dinner"] mutableCopy];
    dinnerDic = [[Globals dietCustomiseSendingDictonary:[dinnerTempDic objectForKey:@"supplement"] foodDic:[dinnerTempDic objectForKey:@"dietFood"]:dinnerTempDic] mutableCopy];
    //supplement
    dinnerDic =[[self addTheExtraValueToTheDictionary:dinnerDic tempDic:dinnerTempDic dietType:@"dinner"] mutableCopy];
    
     NSArray *DaysArrayBreak=[Globals getDaysIntoInteger:breakTempDic];
     NSArray *DaysArraylunch=[Globals getDaysIntoInteger:luncgTempDic];
     NSArray *DaysArraySnacks=[Globals getDaysIntoInteger:snacksTempDic];
     NSArray *DaysArrayDinner=[Globals getDaysIntoInteger:dinnerDic];
    
    
    
    
    
    if (([[breakTempDic objectForKey:@"dietFood"] count] !=0 || [[breakTempDic objectForKey:@"breakfast"]count] !=0) && DaysArrayBreak.count==0 ) {
        _bluredView.hidden=NO;
        _erroriew.hidden=NO;
        _lblError.text=@"Please select at least one day in breakfast!";
        return;
    }
    if (([[luncgTempDic objectForKey:@"dietFood"] count] !=0 || [[luncgTempDic objectForKey:@"supplement"]count]!=0) && DaysArraylunch.count==0 ) {
        _bluredView.hidden=NO;
        _erroriew.hidden=NO;
        _lblError.text=@"Please select at least one day in lunch!";
        return;
    }
    if (([[snacksTempDic objectForKey:@"dietFood"] count] !=0 || [[snacksTempDic objectForKey:@"supplement"]count] !=0) && DaysArraySnacks.count==0) {
        _bluredView.hidden=NO;
        _erroriew.hidden=NO;
        _lblError.text=@"Please select at least one day in snacks!";
        return;
    }
    if (([[dinnerTempDic objectForKey:@"dietFood"] count] !=0 || [[dinnerTempDic objectForKey:@"supplement"]count]!=0) && DaysArrayDinner.count==0 ) {
        _bluredView.hidden=NO;
        _erroriew.hidden=NO;
        _lblError.text=@"Please select at least one day in dinner!";
        return;
    }
    
    
    if (DaysArrayBreak.count==0) {
        [breakFastdic setObject:@"0" forKey:@"weekly"];
    }
    else{
    [breakFastdic setObject:@"1" forKey:@"weekly"];
    }
    
    if (DaysArraylunch.count==0) {
        [lunchDic setObject:@"0" forKey:@"weekly"];
    }
    else{
    [lunchDic setObject:@"1" forKey:@"weekly"];
    }
    
    if (DaysArraySnacks.count==0) {
        [snacksDic setObject:@"0" forKey:@"weekly"];
    }
    else{
         [snacksDic setObject:@"1" forKey:@"weekly"];
    }
    
    if (DaysArrayDinner.count==0) {
        [dinnerDic setObject:@"0" forKey:@"weekly"];
    }
    else{
        [dinnerDic setObject:@"1" forKey:@"weekly"];
    }
    
    if (breakFastdic==nil) {
        breakFastdic=[NSMutableDictionary dictionary];
    }
    if (lunchDic==nil) {
        lunchDic=[NSMutableDictionary dictionary];
    }
    if (snacksDic==nil) {
        snacksDic=[NSMutableDictionary dictionary];
    }
    if (dinnerDic==nil) {
        dinnerDic=[NSMutableDictionary dictionary];
    }
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    // preparing the arry for data
    NSMutableArray *dataArraySend=[NSMutableArray array];
    if (breakFastdic.count!=0) {
        [dataArraySend addObject:breakFastdic];
    }
    if (lunchDic.count!=0) {
        [dataArraySend addObject:lunchDic];
    }
    if (snacksDic.count!=0) {
        [dataArraySend addObject:snacksDic];
    }
    if (dinnerDic.count!=0) {
        [dataArraySend addObject:dinnerDic];
    }
    //[NSArray arrayWithObjects:breakFastDataDic,lunchDataDic,snacksDataDic,mainDataDic, nil];
     NSString *url=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlcreateDietPlan apiKey:[Globals apiKey]];
    NSDictionary *dicNEw=[NSDictionary dictionaryWithObjectsAndKeys:dataArraySend,@"Diet", nil];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicNEw options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // NSString* str = [myString stringByReplacingOccurrencesOfString:@"\""
    //    withString:@""];
    if (diet_id==nil || diet_id.length==0) {
        diet_id=@"0";
    }
    NSDictionary *sendingMainDic=[NSDictionary dictionaryWithObjectsAndKeys:diet_id,@"id",@"1",@"personal",clientID,@"clientID",myString,@"meals", nil];
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.view bringSubviewToFront:hudFirst];
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    [self.view bringSubviewToFront:hudFirst];
    [Globals PostApiURL:url data:sendingMainDic success:^(id responseObject) {
        [hudFirst hide:YES];
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[DietPlanController class]] ) {
                DietPlanController *tom = (DietPlanController*)viewController;
                [self.navigationController popToViewController:tom animated:YES];
            }
        }
    } failure:^(NSError *error) {
        [Globals alert:@"Unable to update. Please try again"];
        [hudFirst hide:YES];
    }];
    
}
-(NSDictionary *)addTheExtraValueToTheDictionary:(NSMutableDictionary *)dictionary tempDic:(NSDictionary *)tempDic dietType:(NSString *)dietType {
    
    if (dictionary !=nil) {

        // NSString *check=[NSString stringWithFormat:@"%@" ,[[[tempDic objectForKey:@"details"] isEqual:[NSNull null]] ?@"0" :[tempDic objectForKey:@"details"]];
        if([tempDic objectForKey:@"details"]){
            [dictionary setObject:[tempDic objectForKey:@"details"] forKey:@"details"];
        }
        else{
            [dictionary setObject:@"NO details" forKey:@"details"];
        }
        if([tempDic objectForKey:@"prepare"]){
            [dictionary setObject:[tempDic objectForKey:@"prepare"] forKey:@"prepare"];
        }
        else{
            [dictionary setObject:@"No desc to prepare" forKey:@"prepare"];
        }
        if([tempDic objectForKey:@"weekly"]){
            [dictionary setObject:[tempDic objectForKey:@"weekly"] forKey:@"weekly"];
        }
        else{
            [dictionary setObject:@"1" forKey:@"weekly"];
        }
        [dictionary setObject:dietType forKey:@"diet_type"];
    }
    return dictionary;
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSIndexPath *indexPath= [self TextFieldIndexpath:textField];
    [self updateTheProductCal:indexPath textFiled:textField];
    [self.CustomDietTable reloadData];
    
}

- (NSIndexPath *)TextFieldIndexpath:(UITextField *)textField {
    CGPoint point = [textField.superview convertPoint:textField.frame.origin toView:_CustomDietTable];
    NSIndexPath * indexPath = [_CustomDietTable indexPathForRowAtPoint:point];
    NSLog(@"Indexpath = %@", indexPath);
    return indexPath;
}

- (NSIndexPath *)ButtonIndexPath:(UIButton *)textField {
    CGPoint point = [textField.superview convertPoint:textField.frame.origin toView:_CustomDietTable];
    NSIndexPath * indexPath = [_CustomDietTable indexPathForRowAtPoint:point];
    NSLog(@"Indexpath = %@", indexPath);
    return indexPath;
}

-(void)updateTheProductCal:(NSIndexPath *)indexPath textFiled:(UITextField *)textField{
    NSMutableDictionary *currentDic;
    NSString *kayName=@"";
    NSMutableArray *currentArry;
    NSMutableArray *supplementArray;
    if (indexPath.section==0) {
        currentDic=[[dataDictionary objectForKey:@"breakfast"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
        supplementArray=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"breakfast";
    }
    else if (indexPath.section==1){
        currentDic=[[dataDictionary objectForKey:@"lunch"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
        supplementArray=[[currentDic objectForKey:@"supplement"] mutableCopy];
        
        kayName=@"lunch";
    }
    else if (indexPath.section==2){
        currentDic=[[dataDictionary objectForKey:@"snacks"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
        supplementArray=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"snacks";
    }
    else if (indexPath.section==3){
        currentDic=[[dataDictionary objectForKey:@"dinner"] mutableCopy];
        currentArry=[[currentDic objectForKey:@"dietFood"] mutableCopy];
        supplementArray=[[currentDic objectForKey:@"supplement"] mutableCopy];
        kayName=@"dinner";
    }
    
    if (currentArry.count>indexPath.row) {
        NSMutableDictionary *updateDic  =[[currentArry objectAtIndex:indexPath.row] mutableCopy];
        if ([updateDic objectForKey:@"quantity"]) {
            [updateDic setObject:textField.text forKey:@"quantity"];
        }
        [currentArry replaceObjectAtIndex:indexPath.row withObject:updateDic];
        [currentDic setObject:currentArry forKey:@"dietFood"];
        [dataDictionary setObject:currentDic forKey:kayName];
    }
    else{
        NSMutableDictionary *updateDic  =[[supplementArray objectAtIndex:indexPath.row-currentArry.count-1] mutableCopy];
        if ([updateDic objectForKey:@"quantity"]) {
            [updateDic setObject:textField.text forKey:@"quantity"];
        }
        [supplementArray replaceObjectAtIndex:indexPath.row-currentArry.count-1 withObject:updateDic];
        [currentDic setObject:supplementArray forKey:@"supplement"];
        [dataDictionary setObject:currentDic forKey:kayName];
    }
  
}

@end
