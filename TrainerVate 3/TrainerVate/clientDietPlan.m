//
//  clientDietPlan.m
//  TrainerVate
//
//  Created by Matrid on 13/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "clientDietPlan.h"
#import "Constants.h"
#import "checkOutBundle.h"

@interface clientDietPlan () {
    UITableView *table;
}

@end

@implementation clientDietPlan
@synthesize dicty;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
    if (IS_IPHONE_5_OR_MORE) {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 481)];
    }
    else {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 87, 320, 393)];
    }
    table.delegate=self;
    table.dataSource=self;
    table.backgroundColor=[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [table setSectionIndexTrackingBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:table];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma tableView delegates methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        if ([[dicty objectForKey:@"details"] isEqualToString:@""]) {
            return 113;
        }
        else{
            UILabel *details=[[UILabel alloc]initWithFrame:CGRectMake(15, 101, 305, 56)];
            details.text=[dicty objectForKey:@"details"];
            [details setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            details.lineBreakMode = NSLineBreakByWordWrapping;
            details.numberOfLines = 0;
            details.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
            details.adjustsFontSizeToFitWidth = YES;
            details.adjustsLetterSpacingToFitWidth = YES;
            details.minimumScaleFactor = 10.0f/12.0f;
            details.clipsToBounds = YES;
            details.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            [details sizeToFit];
            value=details.frame.size.height+113;
            return value;
        }
    }
    else if (indexPath.row==1){
        NSArray *temp=[dicty objectForKey:@"dietFood"];
        return 45+temp.count*48;
    }
    else if (indexPath.row==2){
        NSArray *temp=[dicty objectForKey:@"supplement"];
        return 45+temp.count*48;
    }
    else if (indexPath.row==3){
        return 105;
    }
    else {
        if ([[dicty objectForKey:@"prepare"] isEqualToString:@""]) {
            return 97;
        }
        else{
            UILabel *details=[[UILabel alloc]initWithFrame:CGRectMake(15, 101, 305, 56)];
            details.text=[dicty objectForKey:@"prepare"];
            [details setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            details.lineBreakMode = NSLineBreakByWordWrapping;
            details.numberOfLines = 0;
            details.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
            details.adjustsFontSizeToFitWidth = YES;
            details.adjustsLetterSpacingToFitWidth = YES;
            details.minimumScaleFactor = 10.0f/12.0f;
            details.clipsToBounds = YES;
            details.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            [details sizeToFit];
            value=details.frame.size.height+97;
            return value;
        }
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCell=@"simpleTableCell";
    static NSString *tableCell1=@"simpleTableCell1";
    static NSString *tableCell2=@"simpleTableCell2";
    static NSString *tableCell3=@"simpleTableCell3";
    static NSString *tableCell4=@"simpleTableCell4";
    
    NSArray *temp=[dicty objectForKey:@"dietFood"];
    NSArray *temp1=[dicty objectForKey:@"supplement"];
    int kcal=0;
    if (indexPath.row==0) {
        dietHeadder *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"dietHeadder" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
    
        if ([[dicty valueForKey:@"type"] isEqualToString:@"breakfast"]) {
            cell.dietImage.image=[UIImage imageNamed:@"tea.png"];
        }
        else if ([[dicty valueForKey:@"type"] isEqualToString:@"dinner"]) {
            cell.dietImage.image=[UIImage imageNamed:@"flow.png"];
        }
        else if ([[dicty valueForKey:@"type"] isEqualToString:@"lunch"]){
            cell.dietImage.image=[UIImage imageNamed:@"spoon.png"];
        }
        else if ([[dicty valueForKey:@"type"] isEqualToString:@"snacks"] || [[dicty valueForKey:@"type"] isEqualToString:@"snack"]) {
            cell.dietImage.image=[UIImage imageNamed:@"newicon2.png"];
        }
        cell.dietImage.contentMode = UIViewContentModeScaleAspectFit;

        for (int i=0; i<temp.count+temp1.count;i++) {
            int tempChar=0;
            NSString *currentChar;
            if (i<temp.count) {
                currentChar= [NSString stringWithFormat:@"%@" ,[[[temp objectAtIndex:i]valueForKey:@"kcal"] isEqual:[NSNull null]] ?@"0" :[[temp objectAtIndex:i]valueForKey:@"kcal"]];
               
                tempChar= [currentChar intValue];
                kcal=tempChar+kcal;
            }
            else {
                currentChar=[NSString stringWithFormat:@"%@" ,[[[temp1 objectAtIndex:i-temp.count]valueForKey:@"kcal"] isEqual:[NSNull null]] ?@"0" :[[temp1 objectAtIndex:i-temp.count]valueForKey:@"kcal"]];
                
                tempChar=[[NSString stringWithFormat:@"%@" ,[[[temp1 objectAtIndex:i-temp.count]valueForKey:@"kcal"] isEqual:[NSNull null]] ?@"0" :[[temp1 objectAtIndex:i-temp.count]valueForKey:@"kcal"]] intValue];
               // [[[temp objectAtIndex:i-temp.count]valueForKey:@"kcal"] intValue];
                kcal=tempChar+kcal;
            }
        }
        cell.dietKcal.text=[NSString stringWithFormat:@"%d",kcal];
        cell.dietTitle.text=[dicty objectForKey:@"type"];
        UILabel *details=[[UILabel alloc]initWithFrame:CGRectMake(15, 101, 305, 56)];
        details.text=[dicty objectForKey:@"details"];
        [details setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        details.lineBreakMode = NSLineBreakByWordWrapping;
        details.numberOfLines = 0;
        details.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        details.adjustsFontSizeToFitWidth = YES;
        details.adjustsLetterSpacingToFitWidth = YES;
        details.minimumScaleFactor = 10.0f/12.0f;
        details.clipsToBounds = YES;
        details.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
        [details sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 98, 320, details.frame.size.height+6)];
        [label setBackgroundColor:[UIColor whiteColor]];
        [cell addSubview:label];
        [cell addSubview:details];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row==1) {
        dietFoodCell *cell1=[tableView dequeueReusableCellWithIdentifier:tableCell1];
        if (cell1==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"dietFoodCell" owner:self options:nil];
            cell1=[array objectAtIndex:0];
        }
        cell1.dietHeaderTitle.text=@"Foods";
        cell1.btnCart.hidden=YES;
        int yAxis=45;
        for (int i=0; i<temp.count; i++) {
            UILabel *details=[[UILabel alloc]initWithFrame:CGRectMake(15, yAxis+1, 185, 36)];
            details.text=[[temp objectAtIndex:i]valueForKey:@"name"];
            [details setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            details.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yAxis, 320, details.frame.size.height+6)];
            [label setBackgroundColor:[UIColor whiteColor]];
            UILabel *qty=[[UILabel alloc]initWithFrame:CGRectMake(200, yAxis+3, 25, 36)];
            qty.text=@"Qty";
            [qty setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            qty.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            UILabel *qtyValue=[[UILabel alloc]initWithFrame:CGRectMake(230, yAxis+3, 25, 36)];
            qtyValue.text=[[temp objectAtIndex:i]valueForKey:@"quantity"];
            [qtyValue setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            qtyValue.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            
            [cell1 addSubview:label];
            [cell1 addSubview:details];
            [cell1 addSubview:qtyValue];
            [cell1 addSubview:qty];
            yAxis+=45;
        }
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell1;
    }
    else if (indexPath.row==2) {
        dietFoodCell *cell2=[tableView dequeueReusableCellWithIdentifier:tableCell2];
        if (cell2==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"dietFoodCell" owner:self options:nil];
            cell2=[array objectAtIndex:0];
        }
        if(temp1.count!=0 && temp1!=nil) {
            [cell2.btnCart addTarget:self action:@selector(selectedButton) forControlEvents:UIControlEventTouchUpInside];
        }
        int yAxis=45;
        for (int i=0; i<temp1.count; i++) {
            UILabel *details=[[UILabel alloc]initWithFrame:CGRectMake(15, yAxis+1, 185, 36)];
            details.text=[[temp1 objectAtIndex:i]valueForKey:@"name"];
            [details setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            details.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, yAxis, 320, details.frame.size.height+6)];
            [label setBackgroundColor:[UIColor whiteColor]];
            UILabel *qty=[[UILabel alloc]initWithFrame:CGRectMake(200, yAxis+3, 25, 36)];
            qty.text=@"Qty";
            [qty setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            qty.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            UILabel *qtyValue=[[UILabel alloc]initWithFrame:CGRectMake(230, yAxis+3, 25, 36)];
            qtyValue.text=[[temp1 objectAtIndex:i]valueForKey:@"quantity"];
            [qtyValue setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            qtyValue.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            

            [cell2 addSubview:label];
            [cell2 addSubview:details];
            [cell2 addSubview:qtyValue];
            [cell2 addSubview:qty];
            yAxis+=45;
        }
        cell2.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell2;
    }
    else if (indexPath.row==3) {
        dietReminder *cell3=[tableView dequeueReusableCellWithIdentifier:tableCell3];
        if (cell3==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"dietReminder" owner:self options:nil];
            cell3=[array objectAtIndex:0];
        }
        cell3.mon.layer.masksToBounds = YES;
        cell3.mon.layer.cornerRadius = cell3.mon.frame.size.height/2;
        if ([[dicty objectForKey:@"monday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.mon setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.mon setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.mon setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.mon setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.mon setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.mon setBackgroundImage:nil forState:normal];
        }
        cell3.tue.layer.masksToBounds = YES;
        cell3.tue.layer.cornerRadius = cell3.tue.frame.size.height/2;
        if ([[dicty objectForKey:@"tuesday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.tue setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.tue setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.tue setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.tue setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.tue setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.tue setBackgroundImage:nil forState:normal];
        }
        cell3.wed.layer.masksToBounds = YES;
        cell3.wed.layer.cornerRadius = cell3.wed.frame.size.height/2;
        if ([[dicty objectForKey:@"wednesday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.wed setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.wed setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.wed setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.wed setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.wed setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.wed setBackgroundImage:nil forState:normal];
        }
        cell3.thr.layer.masksToBounds = YES;
        cell3.thr.layer.cornerRadius = cell3.thr.frame.size.height/2;
        if ([[dicty objectForKey:@"thursday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.thr setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.thr setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.thr setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.thr setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.thr setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.thr setBackgroundImage:nil forState:normal];
        }
        cell3.fri.layer.masksToBounds = YES;
        cell3.fri.layer.cornerRadius = cell3.fri.frame.size.height/2;
        if ([[dicty objectForKey:@"friday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.fri setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.fri setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.fri setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.fri setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.fri setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.fri setBackgroundImage:nil forState:normal];
        }
        cell3.sat.layer.masksToBounds = YES;
        cell3.sat.layer.cornerRadius = cell3.sat.frame.size.height/2;
        if ([[dicty objectForKey:@"saturday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.sat setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.sat setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.sat setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.sat setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.sat setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.sat setBackgroundImage:nil forState:normal];
        }
        cell3.sun.layer.masksToBounds = YES;
        cell3.sun.layer.cornerRadius = cell3.sun.frame.size.height/2;
        if ([[dicty objectForKey:@"sunday"] isEqualToString:@"0"] && [[dicty objectForKey:@"weekly"] isEqualToString:@"1"]) {
            [cell3.sun setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [cell3.sun setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [cell3.sun setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [cell3.sun setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [cell3.sun setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [cell3.sun setBackgroundImage:nil forState:normal];
        }
        cell3.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell3;
    }
    else {
        dietFoodCell *cell4=[tableView dequeueReusableCellWithIdentifier:tableCell4];
        
        if (cell4==nil) {
            NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"dietFoodCell" owner:self options:nil];
            cell4=[array objectAtIndex:0];
        }
        cell4.dietHeaderTitle.text=@"How To Prepare";
        cell4.btnCart.hidden=YES;
        UILabel *details=[[UILabel alloc]initWithFrame:CGRectMake(15, 49, 305, 56)];
        details.text=[dicty objectForKey:@"prepare"];
        [details setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        details.lineBreakMode = NSLineBreakByWordWrapping;
        details.numberOfLines = 0;
        details.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        details.adjustsFontSizeToFitWidth = YES;
        details.adjustsLetterSpacingToFitWidth = YES;
        details.minimumScaleFactor = 10.0f/12.0f;
        details.clipsToBounds = YES;
        details.textColor = [UIColor colorWithRed:15/255.0 green:50/255.0 blue:64/255.0 alpha:1.0];
        [details sizeToFit];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 46, 320, details.frame.size.height+6)];
        [label setBackgroundColor:[UIColor whiteColor]];
        [cell4 addSubview:label];
        [cell4 addSubview:details];
        cell4.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell4;
    }

}

-(void)selectedButton {
    checkOutBundle *recommend = [[checkOutBundle alloc]init];
    recommend.bundleProduct=[dicty objectForKey:@"supplement"];
    recommend.bundleName=@"Dietplan Checkout";
    [self.navigationController pushViewController:recommend animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
int value = 0;

@end
