//
//  CreateDietPlan.m
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "CreateDietPlanDinner.h"
#import "Constants.h"

@interface CreateDietPlanDinner () {
    
    NSMutableArray *supplimentArrayDinner;
    NSMutableArray *dietArrayDinner;
    NSMutableArray *CreateQty;
    NSMutableArray *CreateTitle;
    NSMutableArray *PickerArray;
    NSMutableArray *dinner;
    NSMutableArray *textData;
    CGRect tableHeight;
    NSMutableArray *collectionArray;
    NSMutableArray * inputTexts;
    NSArray *ap1Response;
    NSArray *ap2Response;
    NSMutableArray *DaysArray;
    NSMutableDictionary *mainDataDic;
    int scrollview_height;
    UIButton *nextScreen;
}

@end

@implementation CreateDietPlanDinner
@synthesize btnImage1,navigationBar,breakFastDataDic,lunchDataDic,snacksDataDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Create Diet Plan Dinner"];
     inputTexts = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    supplimentArrayDinner=[[NSMutableArray alloc] init];
    CreateQty=[[NSMutableArray alloc] init];
    dietArrayDinner=[[NSMutableArray alloc] init];
    textData=[[NSMutableArray alloc] init];
    PickerArray=[NSMutableArray arrayWithObjects:@"Daily",@"Weekly",nil];
    // get dynamic content size
   
  
    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    //This code will run in the main thread:
    self.txtRepeat.text=@"Daily";
    [self createTheButtons];
    [self textFieldDidEndEditing:self.txtRepeat];
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
    
    [[_txtDescription layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[_txtDescription layer] setBorderWidth:1];
    [[_txtDescription layer] setCornerRadius:5];
    
    [[_txtHowToPrepare layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[_txtHowToPrepare layer] setBorderWidth:1];
    [[_txtHowToPrepare layer] setCornerRadius:5];
    
    // creating buttons
    UIImageView *btnBgImage;
    if (IS_IPHONE_4_OR_LESS) {
        CGRect frame=scrollViews.frame;
        frame.size.height=410;
        scrollViews.frame=frame;
        btnBgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 428, 320, 52)];
    }
    else {
        btnBgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 516, 320, 52)];
    }
    [btnBgImage setImage:[UIImage imageNamed:@"footernewbg.png"] ];
    [self.view addSubview:btnBgImage];
    
    [nextScreen addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextScreen];
    
    if (IS_IPHONE_4_OR_LESS) {
        nextScreen=[[UIButton alloc]initWithFrame:CGRectMake(0, 428, 320, 52)];
    }
    else {
        nextScreen=[[UIButton alloc]initWithFrame:CGRectMake(0, 516, 320, 52)];
    }
    [nextScreen setTitle:@"Done" forState:normal];
    nextScreen.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
    [nextScreen setTitleColor:[UIColor whiteColor] forState:normal];
    [nextScreen addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextScreen];
    [self.view bringSubviewToFront:nextScreen];
  
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [SingletonClass singleton].dinnerdietPlanBundelArray = [dietArrayDinner mutableCopy];
    [SingletonClass singleton].dinnerdietPlanBundelSuppliment = [supplimentArrayDinner mutableCopy];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
   // if ([SingletonClass singleton].dinnerdietPlanBundelArray!=nil && [SingletonClass singleton].dinnerdietPlanBundelArray.count != 0) {
    
    NSArray *checkDaysArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"dinnerDay"];
    if (checkDaysArray.count!=0) {
        DaysArray = [checkDaysArray mutableCopy];
    }
    
        dietArrayDinner=[[SingletonClass singleton].dinnerdietPlanBundelArray mutableCopy];
        dietArrayDinner = [Globals updateQuantityTo1:dietArrayDinner];
     //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...
        }];
  //  }
   // if ([SingletonClass singleton].dinnerdietPlanBundelSuppliment!=nil && [SingletonClass singleton].dinnerdietPlanBundelSuppliment.count != 0) {
        supplimentArrayDinner = [[SingletonClass singleton].dinnerdietPlanBundelSuppliment mutableCopy];
      //   supplimentArrayDinner = [Globals updateQuantityTo1:supplimentArrayDinner];
        //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...
        }];
   // }
    // setting the Kcal
    self.lblTotalCal.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"kcal"];
    lblcarbohydrates.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"carbohydrates"];
    lblfat.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"fat"];
    lblfiber.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"fiber"];
    lblprotein.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"protein"];
    lblsalt.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"salt"];
    lblsugar.text=[Globals CalculateTotalCalDietPlan:dietArrayDinner keyValue:@"sugar"];
    lblkcal.text=self.lblTotalCal.text;
    lblcarbohydrates.adjustsFontSizeToFitWidth=YES;
    lblfat.adjustsFontSizeToFitWidth=YES;
    lblfiber.adjustsFontSizeToFitWidth=YES;
    lblkcal.adjustsFontSizeToFitWidth=YES;
    lblprotein.adjustsFontSizeToFitWidth=YES;
    lblsalt.adjustsFontSizeToFitWidth=YES;
    lblsugar.adjustsFontSizeToFitWidth=YES;
     self.lblTotalCal.adjustsFontSizeToFitWidth=YES;
    

    scrollview_height = scrollViews.frame.size.height;
    [self setScrollviewOffset];


}

-(void)createTheButtons{
    
    
    UIPickerView *   categoryPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    [categoryPickerView setDataSource: self];
    [categoryPickerView setDelegate: self];
    categoryPickerView.showsSelectionIndicator = YES;
    self.txtRepeat.inputView =  categoryPickerView;
    
    self.txtRepeat.delegate=self;
    
    DaysArray = [NSMutableArray array];
    int xAxis=23;
    NSArray *days=[NSArray arrayWithObjects:@"M",@"T",@"W",@"T",@"F",@"S",@"S", nil];
    for (int i=0; i<7; i++) {
        UIButton *daysBtn=[[UIButton alloc]initWithFrame:CGRectMake(xAxis, 9, 32, 32)];
        [daysBtn setTitle:[days objectAtIndex:i] forState:UIControlStateNormal];
        //        daysBtn.titleLabel.text=;
        //    daysBtn.titleLabel.textColor=[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
        daysBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        //    daysBtn.backgroundColor=[UIColor whiteColor];
        [daysBtn.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:14]];
        daysBtn.layer.borderColor = [UIColor blackColor].CGColor;
        //      daysBtn.backgroundColor=[UIColor whiteColor];
        [daysBtn setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        daysBtn.tag=i;
        daysBtn.layer.cornerRadius=daysBtn.frame.size.width/2.0;
        daysBtn.layer.cornerRadius=daysBtn.frame.size.height/2.0;
        daysBtn.clipsToBounds=YES;
        [daysBtn addTarget:self action:@selector(daysBtn:) forControlEvents:UIControlEventTouchUpInside];
        [daysBtn setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.viewDaysBtn addSubview:daysBtn];
        xAxis=xAxis+40;
    }
    
}
-(IBAction)daysBtn:(UIButton *)senderBtn{
    
    // NSMutableDictionary *currentDic;
    //  NSArray *dietArray=[NSArray arrayWithObjects:@"breakfast",@"lunch",@"snacks",@"dinner", nil];
    NSArray *dayWeekArray=[NSArray arrayWithObjects:@"monday",@"tuesday",@"wednesday",@"thursday",@"friday",@"saturday",@"sunday", nil];
    if ([DaysArray containsObject:[NSNumber numberWithInteger:senderBtn.tag]]) {
        [mainDataDic setObject:@"0" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
        [senderBtn setTitleColor:[  UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
        [senderBtn setBackgroundColor:[UIColor whiteColor]];
        NSInteger index=[DaysArray indexOfObject:[NSNumber numberWithInteger:senderBtn.tag]];
        [DaysArray removeObjectAtIndex:index];
    }
    else{
        [mainDataDic setObject:@"1" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
        [senderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [senderBtn setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [DaysArray addObject:[NSNumber numberWithInteger:senderBtn.tag]];
    }
}

#pragma mark- picker view delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row==0) {
        return @"Daily";
    }
    return @"Weekly";
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    
    if (row==0) {
        self.txtRepeat.text=@"Daily";
    }
    else{
        self.txtRepeat.text=@"Weekly";
    }
}


#pragma tableView methods************************************************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dietArrayDinner.count+1+supplimentArrayDinner.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dietArrayDinner.count==indexPath.row) {
        return 105;
    }
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //
    if (dietArrayDinner.count==indexPath.row) {
        
        static NSString *defaultCell=@"default";
        breakFastFooterCustomCell *cell=(breakFastFooterCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
        if (cell==NULL) {
            NSArray *dietCustom=[[NSBundle mainBundle]loadNibNamed:@"breakFastFooterCustomCell" owner:self options:nil];
            cell=[dietCustom objectAtIndex:0];
        }
        [cell.addFoodBreakFast addTarget:self action:@selector(addProduct) forControlEvents:UIControlEventTouchUpInside];
        [cell.addSupplementBreakFast addTarget:self action:@selector(addSuppliment) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    CreateDietCustomCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (dietArrayDinner.count<indexPath.row) {
        if (cell==NULL) {
            NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
            cell=[mArray objectAtIndex:0];
        }
        cell.createDietName.text=[[supplimentArrayDinner objectAtIndex:indexPath.row-1-dietArrayDinner.count ] valueForKey:@"title"];
        cell.txtQty.tag= indexPath.row;
        cell.txtQty.delegate = self;
        if (![cell.txtQty.text isEqual:@""] ) {
            [textData addObject:cell.txtQty.text];
        }
        ProductRecommend *recomnd = [supplimentArrayDinner objectAtIndex:indexPath.row-1-dietArrayDinner.count];
        cell.txtQty.text = [NSString stringWithFormat:@"%i",recomnd.quantity];
        return cell;
    }
    
   
    if (cell==NULL) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    cell.createDietName.text=[[dietArrayDinner objectAtIndex:indexPath.row ] valueForKey:@"Long_Desc"];
    [cell.txtQty addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    cell.txtQty.tag= indexPath.row;
    cell.txtQty.delegate = self;
    if ([[dietArrayDinner objectAtIndex:indexPath.row] valueForKey:@"Qty"]) {
        cell.txtQty.text = [[dietArrayDinner objectAtIndex:indexPath.row] valueForKey:@"Qty"];
    }
    return cell;
  
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *dietCreateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    dietCreateView.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
    UILabel *createDietTitle=[[UILabel alloc]initWithFrame:CGRectMake(22, 0, tableView.frame.size.width, 40)];
    [createDietTitle setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [createDietTitle setFont:[UIFont boldSystemFontOfSize:16]];
    [createDietTitle setText:@"Dinner"];
    [dietCreateView addSubview:createDietTitle];
    return dietCreateView;
}

#pragma mark- textfield delegate methods
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(self.txtRepeat == textField){
        if ([textField.text isEqualToString:@"Daily"]) {
            if (self.viewDaysBtn.hidden==YES) {
                return;
            }
            self.viewDaysBtn.hidden=YES;
            CGRect frame=self.viewHowToPrepare.frame;
            frame.origin.y = self.viewHowToPrepare.frame.origin.y-self.viewDaysBtn.frame.size.height;
            self.viewHowToPrepare.frame=frame;
        }
        else{
            self.viewDaysBtn.hidden=NO;
            CGRect frame=self.viewHowToPrepare.frame;
            frame.origin.y = self.viewDaysBtn.frame.origin.y+self.viewDaysBtn.frame.size.height;
            self.viewHowToPrepare.frame=frame;
        }
        return;
    }
    

    
    int tag =(int) textField.tag;
    if (tag < dietArrayDinner.count) {
        NSMutableDictionary *currentDic = [[dietArrayDinner objectAtIndex:tag] mutableCopy];
        if (![currentDic objectForKey:@"Qty"]) {
            [currentDic setObject:textField.text forKey:@"Qty"];
            [currentDic setObject:@"0" forKey:@"supplements"];
        } else {
            [currentDic setObject:textField.text forKey:@"Qty"];
        }
        [dietArrayDinner replaceObjectAtIndex:tag withObject:currentDic];
    }
    else
    {
        ProductRecommend *prduct =[supplimentArrayDinner objectAtIndex:tag - dietArrayDinner.count - 1];
        prduct.quantity = [textField.text intValue];
    }
}

-(void)addProduct
{
    DietPlanCustomiseController1 *dietCustomise=[[DietPlanCustomiseController1 alloc]init];
    dietCustomise.preClass=@"dinner";
    [self.navigationController pushViewController:dietCustomise animated:YES];
}

-(void)addSuppliment
{
    shopController *dietCustomise=[[shopController alloc]init];
    dietCustomise.preClass = @"dinner";
    [self.navigationController pushViewController:dietCustomise animated:YES];
}


- (void)userSelclected:(UIButton *)senderBtn {
}



//Picker View end

- (IBAction)backDietPlan:(id)sender {
[self.navigationController popViewControllerAnimated:YES];
}



-(void)nextAction:(UIButton *)sender{
    
//    [SingletonClass singleton].dinnerdietPlanBundelArray = [dietArrayDinner mutableCopy];
//    [SingletonClass singleton].dinnerdietPlanBundelSuppliment = [supplimentArrayDinner mutableCopy];
//
//    
//    
//    // breakfast
//    NSMutableDictionary *MainBreakFastsDictionary = [NSMutableDictionary dictionary];
//    NSMutableArray *currenBreakFastArray =[NSMutableArray array];
//    for (int i =0; i<[SingletonClass singleton].breakfastdietPlanBundelFood.count+[SingletonClass singleton].breakfastdietPlanBundelSuppliment.count; i++) {
//        if (i < [SingletonClass singleton].breakfastdietPlanBundelFood.count) {
//            NSDictionary *getDic =[[SingletonClass singleton].breakfastdietPlanBundelFood objectAtIndex:i];
//            NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[getDic objectForKey:@"Qty"],@"Qty",[getDic objectForKey:@"NDB_No"],@"product_id",@"0",@"supplements", nil];
//            [currenBreakFastArray addObject:currentDic];
//        }
//        else{
//            ProductRecommend *getDic =[[SingletonClass singleton].breakfastdietPlanBundelSuppliment objectAtIndex:i-[SingletonClass singleton].breakfastdietPlanBundelFood.count];
//            NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",getDic.quantity],@"Qty",[NSString stringWithFormat:@"%i",getDic.uid],@"product_id",@"1",@"supplements", nil];
//            [currenBreakFastArray addObject:currentDic];
//
//        }
//    }
//    [MainBreakFastsDictionary setObject:currenBreakFastArray forKey:@"Items"];
//    [MainBreakFastsDictionary setObject:@"breakfast" forKey:@"diet_type"];
//    [MainBreakFastsDictionary setObject:@"how to prepare" forKey:@"prepare"];
//    [MainBreakFastsDictionary setObject:@"details of food" forKey:@"details"];
//    
//    
//    // lunch
//    NSMutableDictionary *MainLunchDictionary = [NSMutableDictionary dictionary];
//    NSMutableArray *currenLunchFastArray =[NSMutableArray array];
//    for (int i =0; i<[SingletonClass singleton].lunchdietPlanBundelArray.count+[SingletonClass singleton].lunchdietPlanBundelSuppliment.count; i++) {
//        if (i < [SingletonClass singleton].lunchdietPlanBundelArray.count) {
//            NSDictionary *getDic =[[SingletonClass singleton].lunchdietPlanBundelArray objectAtIndex:i];
//            NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[getDic objectForKey:@"Qty"],@"Qty",[getDic objectForKey:@"NDB_No"],@"product_id",@"0",@"supplements", nil];
//            [currenLunchFastArray addObject:currentDic];
//        }
//        else{
//            ProductRecommend *getDic =[[SingletonClass singleton].lunchdietPlanBundelSuppliment objectAtIndex:i-[SingletonClass singleton].lunchdietPlanBundelArray.count];
//           NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",getDic.quantity],@"Qty",[NSString stringWithFormat:@"%i",getDic.uid],@"product_id",@"1",@"supplements", nil];
//            [currenLunchFastArray addObject:currentDic];
//            
//        }
//    }
//    
//    [MainLunchDictionary setObject:currenLunchFastArray forKey:@"Items"];
//    [MainLunchDictionary setObject:@"lunch" forKey:@"diet_type"];
//    [MainLunchDictionary setObject:@"how to prepare" forKey:@"prepare"];
//    [MainLunchDictionary setObject:@"details of food" forKey:@"details"];
//    
//    
//    // dinner
//    NSMutableDictionary *MainDinnerDictionary = [NSMutableDictionary dictionary];
//    NSMutableArray *currenDinnerArray =[NSMutableArray array];
//    for (int i =0; i<[SingletonClass singleton].dinnerdietPlanBundelArray.count+[SingletonClass singleton].dinnerdietPlanBundelSuppliment.count; i++) {
//        if (i < [SingletonClass singleton].dinnerdietPlanBundelArray.count) {
//            NSDictionary *getDic =[[SingletonClass singleton].dinnerdietPlanBundelArray objectAtIndex:i];
//            NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[getDic objectForKey:@"Qty"],@"Qty",[getDic objectForKey:@"NDB_No"],@"product_id",@"0",@"supplements", nil];
//            [currenDinnerArray addObject:currentDic];
//        }
//        else{
//            ProductRecommend *getDic =[[SingletonClass singleton].dinnerdietPlanBundelSuppliment objectAtIndex:i-[SingletonClass singleton].dinnerdietPlanBundelArray.count];
//             NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",getDic.quantity],@"Qty",[NSString stringWithFormat:@"%i",getDic.uid],@"product_id",@"1",@"supplements", nil];
//            [currenDinnerArray addObject:currentDic];
//            
//        }
//    }
//    [MainDinnerDictionary setObject:currenLunchFastArray forKey:@"Items"];
//    [MainDinnerDictionary setObject:@"dinner" forKey:@"diet_type"];
//    [MainDinnerDictionary setObject:@"how to prepare" forKey:@"prepare"];
//    [MainDinnerDictionary setObject:@"details of food" forKey:@"details"];
//    
//    // Sncks
//    NSMutableDictionary *MainSnacksDictionary = [NSMutableDictionary dictionary];
//    NSMutableArray *currenSnacksFastArray =[NSMutableArray array];
//    for (int i =0; i<[SingletonClass singleton].snaksdietPlanBundelArray.count+[SingletonClass singleton].snaksdietPlanBundelSuppliment.count; i++) {
//        if (i < [SingletonClass singleton].snaksdietPlanBundelArray.count) {
//            NSDictionary *getDic =[[SingletonClass singleton].snaksdietPlanBundelArray objectAtIndex:i];
//            NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[getDic objectForKey:@"Qty"],@"Qty",[getDic objectForKey:@"NDB_No"],@"product_id",@"0",@"supplements", nil];
//            [currenSnacksFastArray addObject:currentDic];
//        }
//        else{
//            ProductRecommend *getDic =[[SingletonClass singleton].snaksdietPlanBundelSuppliment objectAtIndex:i-[SingletonClass singleton].snaksdietPlanBundelArray.count];
//            NSDictionary *currentDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%i",getDic.quantity],@"Qty",[NSString stringWithFormat:@"%i",getDic.uid],@"product_id",@"1",@"supplements", nil];
//            [currenSnacksFastArray addObject:currentDic];
//            
//        }
//    }
//    [MainSnacksDictionary setObject:currenLunchFastArray forKey:@"Items"];
//    [MainSnacksDictionary setObject:@"snacks" forKey:@"diet_type"];
//    [MainSnacksDictionary setObject:@"how to prepare" forKey:@"prepare"];
//    [MainSnacksDictionary setObject:@"details of food" forKey:@"details"];
//

    mainDataDic =[[Globals dietSendingDictonary:supplimentArrayDinner foodDic:dietArrayDinner mainDataDic:mainDataDic] mutableCopy];
    if (mainDataDic !=nil) {
        [mainDataDic setObject:self.txtDescription.text forKey:@"details"];
        [mainDataDic setObject:@"dinner" forKey:@"diet_type"];
        [mainDataDic setObject:self.txtHowToPrepare.text forKey:@"prepare"];
        //[mainDataDic setObject: self.lblTotalCal.text forKey:@"kcal"];
        if ([self.txtRepeat.text isEqualToString:@"Weekly"]) {
            [mainDataDic setObject:@"1"  forKey:@"weekly"];
        }
        else{
            [mainDataDic setObject:@"0" forKey:@"weekly"];
        }
    }
    NSArray *daysArr=[Globals getDaysIntoInteger:mainDataDic];
    if ([[mainDataDic objectForKey:@"weekly"]isEqualToString:@"1"] && daysArr.count==0) {
        _bluredView.hidden=NO;
        _erroriew.hidden=NO;
        _lblError.text=@"Please select at least one day!";
        return;
    }
    
    if (mainDataDic == nil) {
        mainDataDic = [NSMutableDictionary dictionary];
    }
    if (lunchDataDic == nil) {
        lunchDataDic = [NSMutableDictionary dictionary];
    }
    if (breakFastDataDic == nil) {
        breakFastDataDic = [NSMutableDictionary dictionary];
    }
    if (snacksDataDic == nil) {
        snacksDataDic=[NSMutableDictionary dictionary];
    }
    
    if (mainDataDic.allKeys.count == 0 && lunchDataDic.allKeys.count == 0 && breakFastDataDic.allKeys.count == 0 && snacksDataDic.allKeys.count == 0 ) {
        self.erroriew.hidden = NO;
        self.lblError.text = @"Please select atleast one diet plan!";
        self.bluredView.hidden = NO;
        return;
    }
    
    
    NSString *BundleNAme=[[NSUserDefaults standardUserDefaults]objectForKey:@"customDietID"];
 NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    // preparing the arry for data
    NSMutableArray *dataArraySend=[NSMutableArray array];
    if (breakFastDataDic.allKeys.count !=0) {
         [dataArraySend addObject:breakFastDataDic];
    }
    if (lunchDataDic.allKeys.count !=0) {
        [dataArraySend addObject:lunchDataDic];
    }
    if (snacksDataDic.allKeys.count !=0) {
        [dataArraySend addObject:snacksDataDic];
    }
    if (mainDataDic.allKeys.count !=0) {
        [dataArraySend addObject:mainDataDic];
    }
    
    //[NSArray arrayWithObjects:breakFastDataDic,lunchDataDic,snacksDataDic,mainDataDic, nil];
    NSDictionary *dicNEw=[NSDictionary dictionaryWithObjectsAndKeys:dataArraySend,@"Diet", nil];
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dicNEw options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // NSString* str = [myString stringByReplacingOccurrencesOfString:@"\""
                                                      //    withString:@""];
    NSDictionary *sendingMainDic=[NSDictionary dictionaryWithObjectsAndKeys:BundleNAme,@"name",@"videotsdfsd",@"video",@"0",@"custom",@"0",@"alt_id",clientID,@"clientID",myString,@"meals", nil];
   //  KUrlcreateDietPlan
   //CALLING API
    
    
    
    MBProgressHUD * hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    //NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlcreateDietPlan apiKey:[Globals apiKey]];
    // NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    // urlString = [Globals urlCombileHash:kApiDomin ClassUrl:KUrlGetDietMeals apiKey:[Globals apiKey]];
    // NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:[SingletonClass singleton].Workout,@"name",clientID,@"clientID",@"1",@"alt_id",@"0",@"custom",@"viejwfrlDef",@"video",myString,@"meals", nil];
    // cartResponse
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    // [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:urlString parameters:sendingMainDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"customDietID"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"snacksDay"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lunchDay"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"breadDay"];
        
        if (json !=nil && json.allKeys.count!=0) {
            if([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"])
            {
                for (UIViewController* viewController in self.navigationController.viewControllers) {
                    if ([viewController isKindOfClass:[DietPlanController class]] ) {
                        DietPlanController *tom = (DietPlanController*)viewController;
                        [self.navigationController popToViewController:tom animated:YES];
                    }
                }
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
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"snacksDay"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lunchDay"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"breadDay"];
    }];
}

-(void)setScrollviewOffset {
    [scrollViews setContentSize:(CGSizeMake(320, self.viewBottom.frame.origin.y+self.viewBottom.frame.size.height))];
    scrollViews.frame = CGRectMake(0, scrollViews.frame.origin.y, scrollViews.frame.size.width, scrollview_height);
}

#pragma increase decrease view height
- (void)increaseHeight {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = _mealTable.frame;
        tableHeight=frame;
        frame.size.height =105+40+(dietArrayDinner.count*25)+(supplimentArrayDinner.count*25);
        _mealTable.frame = frame;
        CGRect frames= _viewBottom.frame;
        frames.origin.y =(_mealTable.frame.size.height+_mealTable.frame.origin.y)+20;
        _viewBottom.frame = frames;
        [self setScrollviewOffset];
    });
}

- (IBAction)ok:(id)sender {
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
}

@end
