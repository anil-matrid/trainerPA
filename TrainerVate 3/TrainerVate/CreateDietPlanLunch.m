//
//  CreateDietPlan.m
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "CreateDietPlanLunch.h"
#import "CreateDietPlanDSnacks.h"
#import "Constants.h"

@interface CreateDietPlanLunch ()
{
    NSMutableArray *supplimentArrayLunch;
    NSMutableArray *dietArrayLunch;
    NSMutableArray *CreateQty;
    NSMutableArray *CreateTitle;
    NSMutableArray *PickerArray;
    NSMutableArray *lunch;
    NSMutableArray *textData;
    CGRect tableHeight;
    NSMutableArray *collectionArray;
    NSMutableArray * inputTexts;
    NSArray *ap1Response;
    NSArray *ap2Response;
    MBProgressHUD *  hudFirst;
    NSMutableArray *DaysArray;
    NSMutableDictionary *MainDataDic;
    int scrollview_height;
    UIButton *skip;
    UIButton *nextScreen;
    
}

@end

@implementation CreateDietPlanLunch
@synthesize btnImage1,navigationBar,breakFastDataDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Create Diet Paln Lunch"];
    NSLog(@"%@",breakFastDataDic);
     inputTexts = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    supplimentArrayLunch=[[NSMutableArray alloc] init];
    CreateQty=[[NSMutableArray alloc] init];
    dietArrayLunch=[[NSMutableArray alloc] init];
    textData=[[NSMutableArray alloc] init];
    PickerArray=[NSMutableArray arrayWithObjects:@"Daily",@"Weekly",nil];
    MainDataDic =[NSMutableDictionary dictionary];
    // get dynamic content size
   
    
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    //This code will run in the main thread:
    self.txtRepeat.text=@"Daily";
    [self createTheButtons];
    [self textFieldDidEndEditing:self.txtRepeat];
    
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
        skip=[[UIButton alloc]initWithFrame:CGRectMake(0, 428, 160, 52)];
    }
    else {
        skip=[[UIButton alloc]initWithFrame:CGRectMake(0, 516, 160, 52)];
    }
    [skip setTitle:@"Skip" forState:normal];
    skip.titleLabel.font=[UIFont fontWithName:@"Lato-Italic" size:15];
    [skip setTitleColor:[UIColor whiteColor] forState:normal];
    [skip addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:skip];
    [self.view bringSubviewToFront:skip];
    
    if (IS_IPHONE_4_OR_LESS) {
        nextScreen=[[UIButton alloc]initWithFrame:CGRectMake(160, 428, 160, 52)];
    }
    else {
        nextScreen=[[UIButton alloc]initWithFrame:CGRectMake(160, 516, 160, 52)];
    }
    [nextScreen setImage:[UIImage imageNamed:@"skip.png"] forState:normal];
    [nextScreen addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextScreen];
    [self.view bringSubviewToFront:nextScreen];
}

#pragma Buttons Actions..
-(void)skipAction:(UIButton *)sender {
    CreateDietPlanDSnacks *dinner=[[CreateDietPlanDSnacks alloc]init];
    dinner.breakFastDataDic = breakFastDataDic;
    [self.navigationController pushViewController:dinner animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [SingletonClass singleton].lunchdietPlanBundelArray = [dietArrayLunch mutableCopy];
    [SingletonClass singleton].lunchdietPlanBundelSuppliment = [supplimentArrayLunch mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    NSArray *checkDaysArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"lunchDay"];
    if (checkDaysArray.count!=0) {
        DaysArray = [checkDaysArray mutableCopy];
          MainDataDic = [[Globals DictionayFormInt:DaysArray] mutableCopy];
    }
   // if ([SingletonClass singleton].lunchdietPlanBundelArray!=nil && [SingletonClass singleton].lunchdietPlanBundelArray.count != 0) {
        dietArrayLunch=[[SingletonClass singleton].lunchdietPlanBundelArray mutableCopy];
         dietArrayLunch = [Globals updateQuantityTo1:dietArrayLunch];
     //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...
        }];
  // }
  //  if ([SingletonClass singleton].lunchdietPlanBundelSuppliment!=nil && [SingletonClass singleton].lunchdietPlanBundelSuppliment.count != 0) {
        supplimentArrayLunch = [[SingletonClass singleton].lunchdietPlanBundelSuppliment mutableCopy];
       // supplimentArrayLunch = [Globals updateQuantityTo1:supplimentArrayLunch];
        //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...
        }];
   // }
    // setting the Kcal
    self.lblTotalCal.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"kcal"];
    lblcarbohydrates.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"carbohydrates"];
    lblfat.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"fat"];
    lblfiber.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"fiber"];
    lblprotein.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"protein"];
    lblsalt.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"salt"];
    lblsugar.text=[Globals CalculateTotalCalDietPlan:dietArrayLunch keyValue:@"sugar"];
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
       // [self.lblTotalCal sizeToFit];
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
        [MainDataDic setObject:@"0" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
        
        [senderBtn setTitleColor:[  UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
        [senderBtn setBackgroundColor:[UIColor whiteColor]];
        
        
        NSInteger index=[DaysArray indexOfObject:[NSNumber numberWithInteger:senderBtn.tag]];
        [DaysArray removeObjectAtIndex:index];
    }
    else{
        [MainDataDic setObject:@"1" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
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
    return dietArrayLunch.count+1+supplimentArrayLunch.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dietArrayLunch.count==indexPath.row) {
        return 105;
    }
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //
    if (dietArrayLunch.count==indexPath.row) {
        
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
    
    
    if (dietArrayLunch.count<indexPath.row) {
        if (cell==NULL) {
            NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
            cell=[mArray objectAtIndex:0];
        }
        cell.txtQty.tag= indexPath.row;
        cell.txtQty.delegate = self;
        cell.createDietName.text=[[supplimentArrayLunch objectAtIndex:indexPath.row-1-dietArrayLunch.count ] valueForKey:@"title"];
        if (![cell.txtQty.text isEqual:@""] ) {
            [textData addObject:cell.txtQty.text];
        }
        ProductRecommend *recomnd = [supplimentArrayLunch objectAtIndex:indexPath.row-1-dietArrayLunch.count];
        cell.txtQty.text = [NSString stringWithFormat:@"%i",recomnd.quantity];
       // cell.txtQty.text = [NSString stringWithFormat:@"%i",recomnd.quantity];
        return cell;
    }
    
   
    if (cell==NULL) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    cell.txtQty.tag= indexPath.row;
    cell.txtQty.delegate = self;
    if ([[dietArrayLunch objectAtIndex:indexPath.row] valueForKey:@"Qty"]) {
        cell.txtQty.text = [[dietArrayLunch objectAtIndex:indexPath.row] valueForKey:@"Qty"];
    }
    cell.createDietName.text=[[dietArrayLunch objectAtIndex:indexPath.row ] valueForKey:@"Long_Desc"];
    [cell.txtQty addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
  
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *dietCreateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    dietCreateView.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
    UILabel *createDietTitle=[[UILabel alloc]initWithFrame:CGRectMake(22, 0, tableView.frame.size.width, 40)];
    [createDietTitle setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [createDietTitle setFont:[UIFont boldSystemFontOfSize:16]];
    [createDietTitle setText:@"Lunch"];
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
    if (tag < dietArrayLunch.count) {
        NSMutableDictionary *currentDic = [[dietArrayLunch objectAtIndex:tag] mutableCopy];
        if (![currentDic objectForKey:@"Qty"]) {
            [currentDic setObject:textField.text forKey:@"Qty"];
            [currentDic setObject:@"0" forKey:@"supplements"];
        } else {
            [currentDic setObject:textField.text forKey:@"Qty"];
        }
        [dietArrayLunch replaceObjectAtIndex:tag withObject:currentDic];
    }
    else {
        ProductRecommend *prduct =[supplimentArrayLunch objectAtIndex:tag - dietArrayLunch.count - 1];
        prduct.quantity = [textField.text intValue];
        
    }
   
}


-(void)addProduct
{
    DietPlanCustomiseController1 *dietCustomise=[[DietPlanCustomiseController1 alloc]init];
    dietCustomise.preClass=@"lunch";
    [self.navigationController pushViewController:dietCustomise animated:YES];
}
-(void)addSuppliment
{
    shopController *dietCustomise=[[shopController alloc]init];
     dietCustomise.preClass=@"lunch";
    [self.navigationController pushViewController:dietCustomise animated:YES];

}

- (void)userSelclected:(UIButton *)senderBtn {
//
//    if (selectedUser==(int)senderBtn.tag) {
//        selectedUser=-1;
//        Drop=0;
//        [client reloadData];
//        return;
//    }
//    if (Drop==0 || selectedUser!= senderBtn.tag) {
//        selectedUser=(int)senderBtn.tag;
//        [UIView transitionWithView:client duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            [client reloadData];
//        } completion:nil];
//        
//        std=(int)senderBtn.tag;
//        NSString * ID=[[[SingletonClass singleton].MyClientDetail objectAtIndex:std]objectForKey:@"id"];
//        [[NSUserDefaults standardUserDefaults]setObject:ID forKey:@"uid"];
//        Drop++;
//        [client scrollRectToVisible:[client convertRect:client.tableFooterView.bounds fromView:client.tableFooterView] animated:YES];
//    }
//    else {
//        
//        [UIView transitionWithView:client duration:0.25f options:UIViewAnimationOptionTransitionNone animations:^{
//            [client reloadData];
//        } completion:nil];
//        
//        Drop=0;
//    }
    
}

//
//
//#pragma mark - Picker View Data source
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 1;
//}
//-(NSInteger)pickerView:(UIPickerView *)pickerView
//numberOfRowsInComponent:(NSInteger)component{
//    return [PickerArray count];
//}
//
//#pragma mark- Picker View Delegate
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
//(NSInteger)row inComponent:(NSInteger)component{
//    [daysOptions1 setTitle:[PickerArray objectAtIndex:row] forState:normal];
//    _daysPicker.hidden=YES;
//    
//}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
//(NSInteger)row forComponent:(NSInteger)component{
//    return [PickerArray objectAtIndex:row];
//}


//Picker View end

- (IBAction)backDietPlan:(id)sender {
[self.navigationController popViewControllerAnimated:YES];
}

-(void)nextAction:(UIButton *)sender {
    
    MainDataDic = [[Globals dietSendingDictonary:supplimentArrayLunch foodDic:dietArrayLunch mainDataDic:MainDataDic] mutableCopy];
    if (MainDataDic != nil) {
        
        [[NSUserDefaults standardUserDefaults]setObject:DaysArray forKey:@"lunchDay"];
        
        [MainDataDic setObject:self.txtDescription.text forKey:@"details"];
        [MainDataDic setObject:@"lunch" forKey:@"diet_type"];
        [MainDataDic setObject:self.txtHowToPrepare.text forKey:@"prepare"];
       // [MainDataDic setObject: self.lblTotalCal.text forKey:@"kcal"];
        if ([self.txtRepeat.text isEqualToString:@"Weekly"]) {
            [MainDataDic setObject:@"1"  forKey:@"weekly"];
        }
        else {
            [MainDataDic setObject:@"0" forKey:@"weekly"];
        }
        
//        [supplimentArrayLunch removeAllObjects];
//        [dietArrayLunch removeAllObjects];
        // [collectionArray addObject:breakFast];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        }completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...+
        }];
        NSArray *daysArr=[Globals getDaysIntoInteger:MainDataDic];
        if ([[MainDataDic objectForKey:@"weekly"]isEqualToString:@"1"] && daysArr.count==0) {
            _bluredView.hidden=NO;
            _erroriew.hidden=NO;
            _lblError.text=@"Please select at least one day!";
            return;
        }
        CreateDietPlanDSnacks *dietPlan = [[CreateDietPlanDSnacks alloc]init];
        dietPlan.breakFastDataDic = breakFastDataDic;
        dietPlan.lunchDataDic = MainDataDic;
        [self.navigationController pushViewController:dietPlan animated:YES];
        
    }
    else {
        _bluredView.hidden=NO;
        _erroriew.hidden=NO;
        _lblError.text=@"Please add at-least one food or suppliment!";
        return;
    }
}

//- (IBAction)nextScreen:(id)sender {
//
//    if ((supplimentArrayLunch.count!=0 && supplimentArrayLunch!=nil)) {
//        lunch=[[NSMutableArray alloc]init];
//        [lunch arrayByAddingObjectsFromArray:[supplimentArrayLunch valueForKey:@"uid"]];
//        [lunch arrayByAddingObjectsFromArray:[dietArrayLunch valueForKey:@"NDB_No"]];
//        [supplimentArrayLunch removeAllObjects];
//        [dietArrayLunch removeAllObjects];
//        [UIView animateWithDuration:0 animations:^{
//            [_mealTable reloadData];
//        } completion:^(BOOL finished) {
//            [self increaseHeight];
//            //Do something after that...
//        }];
//        CreateDietPlanDSnacks *dinner=[[CreateDietPlanDSnacks alloc]init];
//        [self.navigationController pushViewController:dinner animated:YES];
//    }
//    else {
//        return;
//    }
// 
//}

-(void)setScrollviewOffset
{
    
    
    [scrollViews setContentSize:(CGSizeMake(320, self.viewBottom.frame.origin.y+self.viewBottom.frame.size.height))];
    
    scrollViews.frame = CGRectMake(0, scrollViews.frame.origin.y, scrollViews.frame.size.width, scrollview_height);
}


#pragma increase decrease view height
- (void)increaseHeight {
  dispatch_async(dispatch_get_main_queue(), ^{
      CGRect frame = _mealTable.frame;
        tableHeight=frame;
      frame.size.height =105+40+(dietArrayLunch.count*25)+(supplimentArrayLunch.count*25);
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
