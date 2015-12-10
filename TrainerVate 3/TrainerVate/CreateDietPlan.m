 //
//  CreateDietPlan.m
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "CreateDietPlan.h"
#import "CreateDietPlanLunch.h"
#import "Constants.h"


@interface CreateDietPlan ()
{
    NSMutableArray *supplimentArrayBreakfast;
    NSMutableArray *dietArrayBreakfast;
    NSMutableArray *CreateQty;
    NSMutableArray *CreateTitle;
    NSMutableArray *PickerArray;
    NSMutableArray *breakFast;
    NSMutableArray *textData;
    CGRect tableHeight;
    NSMutableDictionary *breakFastDicData;
    NSMutableArray * inputTexts;
    NSArray *ap1Response;
    NSArray *ap2Response;
    MBProgressHUD *  hudFirst;
    NSMutableArray *DaysArray;
    int scrollview_height;
    UIButton *skip;
    UIButton *nextScreen;
    
}

@end

@implementation CreateDietPlan
@synthesize btnImage1,navigationBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Create Diet Paln"];
     inputTexts = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    supplimentArrayBreakfast=[[NSMutableArray alloc] init];
    breakFastDicData = [NSMutableDictionary dictionary];
    CreateQty=[[NSMutableArray alloc] init];
    dietArrayBreakfast=[[NSMutableArray alloc] init];
    textData=[[NSMutableArray alloc] init];
    PickerArray=[NSMutableArray arrayWithObjects:@"Daily",@"Weekly",nil];
    // get dynamic content size
    
    bluredView.hidden=YES;
    erroriew.hidden=YES;
    //implimenting navigation bar
    [navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    //This code will run in the main thread:
   
    [[_lblDescription layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[_lblDescription layer] setBorderWidth:1];
    [[_lblDescription layer] setCornerRadius:5];
    
    [[_txtVHowToPrepare layer] setBorderColor:[[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0] CGColor]];
    [[_txtVHowToPrepare layer] setBorderWidth:1];
    [[_txtVHowToPrepare layer] setCornerRadius:5];
    
    [self createTheButtons];
    self.txtRepeat.text=@"Daily";
    [self textFieldDidEndEditing:self.txtRepeat];
    
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
    CreateDietPlanLunch *dietPlan = [[CreateDietPlanLunch alloc]init];
    [self.navigationController pushViewController:dietPlan animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [SingletonClass singleton].breakfastdietPlanBundelFood = [dietArrayBreakfast mutableCopy];
    [SingletonClass singleton].breakfastdietPlanBundelSuppliment = [supplimentArrayBreakfast mutableCopy];
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
        daysBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [daysBtn.titleLabel setFont:[UIFont fontWithName:@"Lato-Bold" size:14]];
        daysBtn.layer.borderColor = [UIColor blackColor].CGColor;
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
        [breakFastDicData setObject:@"0" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
        
        [senderBtn setTitleColor:[  UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:UIControlStateNormal];
        [senderBtn setBackgroundColor:[UIColor whiteColor]];
       
        
        NSInteger index=[DaysArray indexOfObject:[NSNumber numberWithInteger:senderBtn.tag]];
        [DaysArray removeObjectAtIndex:index];
    }
    else{
        [breakFastDicData setObject:@"1" forKey:[dayWeekArray objectAtIndex:senderBtn.tag]];
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
    return [PickerArray objectAtIndex:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{

    self.txtRepeat.text=[PickerArray objectAtIndex:row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSArray *checkDaysArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"breadDay"];
    if (checkDaysArray.count!=0) {
        DaysArray = [checkDaysArray mutableCopy];
        breakFastDicData = [[Globals DictionayFormInt:DaysArray] mutableCopy];
    }

    
  //  if ([SingletonClass singleton].breakfastdietPlanBundelFood!=nil && [SingletonClass singleton].breakfastdietPlanBundelFood.count != 0) {
        dietArrayBreakfast=[SingletonClass singleton].breakfastdietPlanBundelFood;
        dietArrayBreakfast = [Globals updateQuantityTo1:dietArrayBreakfast];
     //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
             [self setScrollviewOffset];
            //Do something after that...
        }];
   // }
   // if ([SingletonClass singleton].breakfastdietPlanBundelSuppliment!=nil && [SingletonClass singleton].breakfastdietPlanBundelSuppliment.count != 0) {
        supplimentArrayBreakfast = [SingletonClass singleton].breakfastdietPlanBundelSuppliment;
      //  supplimentArrayBreakfast = [Globals updateQuantityTo1:supplimentArrayBreakfast];
        //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
             [self setScrollviewOffset];
            //Do something after that...
        }];
//}

    // setting the Kcal
    //kcal
    self.lblTotalCal.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"kcal"];
    lblcarbohydrates.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"carbohydrates"];
    lblfat.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"fat"];
    lblfiber.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"fiber"];
    lblprotein.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"protein"];
    lblsalt.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"salt"];
    lblsugar.text=[Globals CalculateTotalCalDietPlan:dietArrayBreakfast keyValue:@"sugar"];
 //   _lblTotalCal.text=self.lblTotalCal.text;
    lblCalories.text=self.lblTotalCal.text;
    
    lblcarbohydrates.adjustsFontSizeToFitWidth=YES;
    lblfat.adjustsFontSizeToFitWidth=YES;
    lblfiber.adjustsFontSizeToFitWidth=YES;
    _lblTotalCal.adjustsFontSizeToFitWidth=YES;
    lblprotein.adjustsFontSizeToFitWidth=YES;
    lblsalt.adjustsFontSizeToFitWidth=YES;
    lblsugar.adjustsFontSizeToFitWidth=YES;
    
    self.lblTotalCal.adjustsFontSizeToFitWidth=YES;
    self.lblTotalCal.textAlignment=NSTextAlignmentCenter;
    
    
     //   [self.lblTotalCal sizeToFit];
    scrollview_height = scrollViews.frame.size.height;
    [self setScrollviewOffset];

}


#pragma tableView methods************************************************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dietArrayBreakfast.count+1+supplimentArrayBreakfast.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dietArrayBreakfast.count==indexPath.row) {
        return 105;
    }
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //
    if (dietArrayBreakfast.count==indexPath.row) {
        
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
    
    
    if (dietArrayBreakfast.count<indexPath.row) {
        if (cell==NULL) {
            NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
            cell=[mArray objectAtIndex:0];
        }
        ProductRecommend *recomnd = [supplimentArrayBreakfast objectAtIndex:indexPath.row-1-dietArrayBreakfast.count];
        cell.createDietName.text=[[supplimentArrayBreakfast objectAtIndex:indexPath.row-1-dietArrayBreakfast.count ] valueForKey:@"title"];
        if (![cell.txtQty.text isEqual:@""] ) {
            [textData addObject:cell.txtQty.text];
        }

        cell.txtQty.tag= indexPath.row;
        cell.txtQty.delegate = self;
        cell.txtQty.text = [NSString stringWithFormat:@"%i",recomnd.quantity];
        return cell;
    }
    if (cell==NULL) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    cell.txtQty.tag = indexPath.row;
    cell.txtQty.delegate = self;
    cell.createDietName.text=[[dietArrayBreakfast objectAtIndex:indexPath.row ] valueForKey:@"Long_Desc"];
    //[cell.txtQty addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    if ([[dietArrayBreakfast objectAtIndex:indexPath.row] valueForKey:@"Qty"]) {
        cell.txtQty.text = [[dietArrayBreakfast objectAtIndex:indexPath.row] valueForKey:@"Qty"];
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
    [createDietTitle setText:@"Breakfast"];
    [dietCreateView addSubview:createDietTitle];
    return dietCreateView;
    
    
}

#pragma mark- textfield delegate methods
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    scrollViews.contentOffset=self.mealTable.frame.origin;
    

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
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
    if (tag < dietArrayBreakfast.count) {
        NSMutableDictionary *currentDic = [[dietArrayBreakfast objectAtIndex:tag] mutableCopy];
        if (![currentDic objectForKey:@"Qty"]) {
            [currentDic setObject:textField.text forKey:@"Qty"];
            [currentDic setObject:@"0" forKey:@"supplements"];
        } else {
          [currentDic setObject:textField.text forKey:@"Qty"];
        }
        [dietArrayBreakfast replaceObjectAtIndex:tag withObject:currentDic];
    }
    else
    {
        ProductRecommend *prduct =[supplimentArrayBreakfast objectAtIndex:tag - dietArrayBreakfast.count - 1];
        prduct.quantity = [textField.text intValue];
    
    }
    
    
    
    
}


-(void)addProduct
{
    DietPlanCustomiseController1 *dietCustomise=[[DietPlanCustomiseController1 alloc]init];
    dietCustomise.preClass = @"breakfast";
    [self.navigationController pushViewController:dietCustomise animated:YES];
}
-(void)addSuppliment
{
    shopController *dietCustomise=[[shopController alloc]init];
     dietCustomise.preClass=@"breakfast";
    [self.navigationController pushViewController:dietCustomise animated:YES];

}


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
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
//(NSInteger)row forComponent:(NSInteger)component{
//    return [PickerArray objectAtIndex:row];
//}


//Picker View end

- (IBAction)backDietPlan:(id)sender {
[self.navigationController popViewControllerAnimated:YES];
}

-(void)nextAction:(UIButton *)sender {
    
    breakFastDicData = [[Globals dietSendingDictonary:supplimentArrayBreakfast foodDic:dietArrayBreakfast mainDataDic:breakFastDicData] mutableCopy];
    if (breakFastDicData != nil) {
        
       // saving days
        [[NSUserDefaults standardUserDefaults]setObject:DaysArray forKey:@"breadDay"];
        
        
        [breakFastDicData setObject:self.lblDescription.text forKey:@"details"];
        [breakFastDicData setObject:@"breakfast" forKey:@"diet_type"];
        [breakFastDicData setObject:self.txtVHowToPrepare.text forKey:@"prepare"];
       // [breakFastDicData setObject: self.lblTotalCal.text forKey:@"kcal"];
        if ([_txtRepeat.text isEqualToString:@"Weekly"]) {
            [breakFastDicData setObject:@"1"  forKey:@"weekly"];
        }
        else{
            [breakFastDicData setObject:@"0" forKey:@"weekly"];
        }
        
       // [supplimentArrayBreakfast removeAllObjects];
       // [dietArrayBreakfast removeAllObjects];
        // [collectionArray addObject:breakFast];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...+
        }];
        NSArray *daysArr=[Globals getDaysIntoInteger:breakFastDicData];
        if ([[breakFastDicData objectForKey:@"weekly"]isEqualToString:@"1"] && daysArr.count==0) {
            bluredView.hidden=NO;
            lblError.text=@"Please select at least one day!";
            erroriew.hidden=NO;
            return;
        }
        CreateDietPlanLunch *dietPlan = [[CreateDietPlanLunch alloc]init];
        dietPlan.breakFastDataDic = breakFastDicData;
        [self.navigationController pushViewController:dietPlan animated:YES];
    
    }
    
    else {
        bluredView.hidden=NO;
        lblError.text=@"Please add at least one food or suppliment!";
        erroriew.hidden=NO;
        return;
    }
}

-(void)setScrollviewOffset
{
    
    [scrollViews setContentSize:(CGSizeMake(320, self.viewBottom.frame.origin.y+self.viewBottom.frame.size.height))];
    
    scrollViews.frame = CGRectMake(0, scrollViews.frame.origin.y, scrollViews.frame.size.width, scrollview_height);
    
}
int days1=0;


#pragma increase decrease view height
- (void)increaseHeight {
  dispatch_async(dispatch_get_main_queue(), ^{
      CGRect frame = _mealTable.frame;
        tableHeight=frame;
      frame.size.height =105+40+(dietArrayBreakfast.count*25)+(supplimentArrayBreakfast.count*25);
      _mealTable.frame = frame;
    
      CGRect frames= _viewBottom.frame;
      frames.origin.y =(_mealTable.frame.size.height+_mealTable.frame.origin.y)+20;
      _viewBottom.frame = frames;
 [self setScrollviewOffset];
  });
    
}



-(void)updateTheScrollSize{

    
    scrollViews.contentSize = CGSizeMake(scrollViews.frame.size.width, self.viewHowToPrepare.frame.origin.y+ self.viewHowToPrepare.frame.size.height);
//    scrollViews.frame = CGRectMake(scrollViews.frame.origin.x, scrollViews.frame.origin.y, scrollViews.frame.size.width,self.viewHowToPrepare.frame.origin.y+ self.viewHowToPrepare.frame.size.height);

}

- (IBAction)ok:(id)sender {
    bluredView.hidden=YES;
    erroriew.hidden=YES;
}
@end
