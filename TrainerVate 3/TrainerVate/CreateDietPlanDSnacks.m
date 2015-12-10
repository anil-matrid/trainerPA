//
//  CreateDietPlan.m
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "CreateDietPlanDSnacks.h"
#import "CreateDietPlanDinner.h"
#import "Constants.h"

@interface CreateDietPlanDSnacks () {
    
    NSMutableArray *supplimentArraySnacks;
    NSMutableArray *dietArraySnacks;
    NSMutableArray *CreateQty;
    NSMutableArray *CreateTitle;
    NSMutableArray *PickerArray;
    NSMutableArray *snacks;
    CGRect tableHeight;
    NSMutableArray *collectionArray;
    NSMutableArray * inputTexts;
    NSArray *ap1Response;
    NSArray *ap2Response;
    NSMutableArray *DaysArray;
    MBProgressHUD *  hudFirst;
    NSMutableDictionary *mainDataDic;
    int scrollview_height;
    __weak IBOutlet UILabel *lblError;
    UIButton *skip;
    UIButton *nextScreen;
    
}

@end

@implementation CreateDietPlanDSnacks
@synthesize navigationBar,breakFastDataDic,lunchDataDic,lblError;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Create Diet Plan Snacks"];
     inputTexts = [[NSMutableArray alloc] init];
    mainDataDic=[NSMutableDictionary dictionary];
    // Do any additional setup after loading the view from its nib.
    supplimentArraySnacks=[[NSMutableArray alloc] init];
    CreateQty=[[NSMutableArray alloc] init];
    dietArraySnacks=[[NSMutableArray alloc] init];
    PickerArray=[NSMutableArray arrayWithObjects:@"Daily",@"Weekly",nil];
    // get dynamic content size
    
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
    CreateDietPlanDinner *diet = [[CreateDietPlanDinner alloc]init];
    diet.breakFastDataDic = breakFastDataDic;
    diet.lunchDataDic = lunchDataDic;
    [self.navigationController pushViewController:diet animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [SingletonClass singleton].snaksdietPlanBundelArray = [dietArraySnacks mutableCopy];
    [SingletonClass singleton].snaksdietPlanBundelSuppliment = [supplimentArraySnacks mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated {
    
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
    
    
    NSArray *checkDaysArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"snacksDay"];
    if (checkDaysArray.count!=0) {
        DaysArray = [checkDaysArray mutableCopy];
        mainDataDic = [[Globals DictionayFormInt:DaysArray] mutableCopy];

    }
    //if ([SingletonClass singleton].snaksdietPlanBundelArray!=nil && [SingletonClass singleton].snaksdietPlanBundelArray.count != 0) {
        dietArraySnacks=[[SingletonClass singleton].snaksdietPlanBundelArray mutableCopy];
            dietArraySnacks = [Globals updateQuantityTo1:dietArraySnacks];
     //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...
        }];
    //}
    //if ([SingletonClass singleton].snaksdietPlanBundelSuppliment!=nil && [SingletonClass singleton].snaksdietPlanBundelSuppliment.count != 0) {
        supplimentArraySnacks = [[SingletonClass singleton].snaksdietPlanBundelSuppliment mutableCopy];
        // supplimentArraySnacks = [Globals updateQuantityTo1:supplimentArraySnacks];
        //   [_mealTable reloadData];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...
        }];
    //}
    // setting the Kcal
    self.lblTotalCal.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"kcal"];
    lblcarbohydrates.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"carbohydrates"];
    lblfat.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"fat"];
    lblfiber.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"fiber"];
    lblprotein.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"protein"];
    lblsalt.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"salt"];
    lblsugar.text=[Globals CalculateTotalCalDietPlan:dietArraySnacks keyValue:@"sugar"];
        lblkcal.text=self.lblTotalCal.text;
    
    lblcarbohydrates.adjustsFontSizeToFitWidth=YES;
    lblfat.adjustsFontSizeToFitWidth=YES;
    lblfiber.adjustsFontSizeToFitWidth=YES;
    lblkcal.adjustsFontSizeToFitWidth=YES;
    lblprotein.adjustsFontSizeToFitWidth=YES;
    lblsalt.adjustsFontSizeToFitWidth=YES;
    lblsugar.adjustsFontSizeToFitWidth=YES;
     self.lblTotalCal.adjustsFontSizeToFitWidth=YES;
   // [self.lblTotalCal sizeToFit];
    
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
    return dietArraySnacks.count+1+supplimentArraySnacks.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dietArraySnacks.count==indexPath.row) {
        return 105;
    }
    return 25;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   //
    if (dietArraySnacks.count==indexPath.row) {
        
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
    
    
    if (dietArraySnacks.count<indexPath.row) {
        if (cell==NULL) {
            NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
            cell=[mArray objectAtIndex:0];
        }
        cell.createDietName.text=[[supplimentArraySnacks objectAtIndex:indexPath.row-1-dietArraySnacks.count ] valueForKey:@"title"];
        cell.txtQty.tag= indexPath.row;
        cell.txtQty.delegate = self;

        if (![cell.txtQty.text isEqual:@""] ) {
         //   [textData addObject:cell.txtQty.text];
        }
        ProductRecommend *recomnd = [supplimentArraySnacks objectAtIndex:indexPath.row-1-dietArraySnacks.count];
        cell.txtQty.text = [NSString stringWithFormat:@"%i",recomnd.quantity];
        return cell;
    }
    
   
    if (cell==NULL) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CreateDietCustomCell" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    cell.createDietName.text=[[dietArraySnacks objectAtIndex:indexPath.row ] valueForKey:@"Long_Desc"];
    [cell.txtQty addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    cell.txtQty.tag= indexPath.row;
    cell.txtQty.delegate = self;
    if ([[dietArraySnacks objectAtIndex:indexPath.row] valueForKey:@"Qty"]) {
        cell.txtQty.text = [[dietArraySnacks objectAtIndex:indexPath.row] valueForKey:@"Qty"];
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
    [createDietTitle setText:@"Snacks"];
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
    if (tag < dietArraySnacks.count) {
        NSMutableDictionary *currentDic = [[dietArraySnacks objectAtIndex:tag] mutableCopy];
        if (![currentDic objectForKey:@"Qty"]) {
            [currentDic setObject:textField.text forKey:@"Qty"];
            [currentDic setObject:@"0" forKey:@"supplements"];
        } else {
            [currentDic setObject:textField.text forKey:@"Qty"];
        }
        [dietArraySnacks replaceObjectAtIndex:tag withObject:currentDic];
    }
    else
    {
        ProductRecommend *prduct =[supplimentArraySnacks objectAtIndex:tag - dietArraySnacks.count - 1];
        prduct.quantity = [textField.text intValue];
        
    }
    
    
    
}




-(void)addProduct
{
    DietPlanCustomiseController1 *dietCustomise=[[DietPlanCustomiseController1 alloc]init];
    dietCustomise.preClass=@"snaks";
    [self.navigationController pushViewController:dietCustomise animated:YES];
}
-(void)addSuppliment
{
    shopController *dietCustomise=[[shopController alloc]init];
    dietCustomise.preClass=@"snaks";
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





//Picker View end

- (IBAction)backDietPlan:(id)sender {
[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ok:(id)sender {
    
    _bluredView.hidden=YES;
    _erroriew.hidden=YES;
}

-(void)nextAction:(UIButton *)sender {
    
    mainDataDic = [[Globals dietSendingDictonary:supplimentArraySnacks foodDic:dietArraySnacks mainDataDic:mainDataDic] mutableCopy];
    if (mainDataDic != nil) {
        
        [[NSUserDefaults standardUserDefaults]setObject:DaysArray forKey:@"snacksDay"];
        
        [mainDataDic setObject:self.txtDescription.text forKey:@"details"];
        [mainDataDic setObject:@"snacks" forKey:@"diet_type"];
        [mainDataDic setObject:self.txtHowToPrepare.text forKey:@"prepare"];
       // [mainDataDic setObject: self.lblTotalCal.text forKey:@"kcal"];
        if ([self.txtRepeat.text isEqualToString:@"Weekly"]) {
            [mainDataDic setObject:@"1"  forKey:@"weekly"];
        }
        else{
            [mainDataDic setObject:@"0" forKey:@"weekly"];
        }
        
//        [supplimentArraySnacks removeAllObjects];
//        [dietArraySnacks removeAllObjects];
        // [collectionArray addObject:breakFast];
        [UIView animateWithDuration:0 animations:^{
            [_mealTable reloadData];
        } completion:^(BOOL finished) {
            [self increaseHeight];
            //Do something after that...+
        }];
        
        NSArray *daysArr=[Globals getDaysIntoInteger:mainDataDic];
        if ([[mainDataDic objectForKey:@"weekly"]isEqualToString:@"1"] && daysArr.count==0) {
            _bluredView.hidden=NO;
            _erroriew.hidden=NO;
            lblError.text=@"Please select at least one day!";
            return;
        }
        
        
        CreateDietPlanDinner *dietPlan = [[CreateDietPlanDinner alloc]init];
        dietPlan.breakFastDataDic = breakFastDataDic;
        dietPlan.lunchDataDic = lunchDataDic;
        dietPlan.snacksDataDic = mainDataDic;
        [self.navigationController pushViewController:dietPlan animated:YES];

        
    }
    else {
        _bluredView.hidden=NO;
        lblError.text=@"Please add at-least one food or suppliment!";
        _erroriew.hidden=NO;
        return;
    }
}

//- (IBAction)nextScreen:(id)sender {
//
//        for (int i=0;i<supplimentArraySnacks.count+dietArraySnacks.count;i++) {
//            if (i<supplimentArraySnacks.count) {
//                [snacks addObject:[NSString stringWithFormat:@"%@",[[supplimentArraySnacks objectAtIndex:i] valueForKey:@"uid"]]];
//            }
//            else{
//                [snacks addObject:[[dietArraySnacks objectAtIndex:i-supplimentArraySnacks.count]valueForKey:@"NDB_No"]];
//            }
//            
//        }
//        [supplimentArraySnacks removeAllObjects];
//        [dietArraySnacks removeAllObjects];
//        [UIView animateWithDuration:0 animations:^{
//            [_mealTable reloadData];
//        } completion:^(BOOL finished) {
//            [self increaseHeight];
//            //Do something after that...+
//        }];
//
//    CreateDietPlanDinner *diet = [[CreateDietPlanDinner alloc]init];
//    [self.navigationController pushViewController:diet animated:YES];
//}

-(void)setScrollviewOffset {
    [scrollViews setContentSize:(CGSizeMake(320, self.viewBottom.frame.origin.y+self.viewBottom.frame.size.height))];
    scrollViews.frame = CGRectMake(0, scrollViews.frame.origin.y, scrollViews.frame.size.width, scrollview_height);
}

#pragma increase decrease view height
- (void)increaseHeight {
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect frame = _mealTable.frame;
        tableHeight=frame;
        frame.size.height =105+40+(dietArraySnacks.count*25)+(supplimentArraySnacks.count*25);
        _mealTable.frame = frame;
        CGRect frames= _viewBottom.frame;
        frames.origin.y =(_mealTable.frame.size.height+_mealTable.frame.origin.y)+20;
        _viewBottom.frame = frames;
        [self setScrollviewOffset];
    });
}





@end
