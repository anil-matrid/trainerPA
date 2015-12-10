//
//  recommendationBundelInfo.m
//  TrainerVate
//
//  Created by Matrid on 26/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "recommendationBundelInfo.h"
#import "Constants.h"
#import "recommendationCustomCell.h"
#import "checkOutBundle.h"

@interface recommendationBundelInfo () {
    NSMutableArray *days;
    NSMutableArray *weekDays;
    UITableView *table;
}

@end

@implementation recommendationBundelInfo
@synthesize bundleName,bundleProduct;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
        if (IS_IPAD) {
            self = [super initWithNibName:@"MyClientController_ipad" bundle:nibBundleOrNil];
        }
        else if(IS_IPHONE_5_OR_MORE) {
    
            self = [super initWithNibName:@"recommendationBundelInfo" bundle:nibBundleOrNil];
        }
        else {
            self = [super initWithNibName:@"recommendBundelInfo_4" bundle:nibBundleOrNil];
        }
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONE_5_OR_MORE) {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 429)];
    }
    else {
        table=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 342)];
    }
    table.delegate=self;
    table.dataSource=self;
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:table];
    [self.view bringSubviewToFront:table];
    // Do any additional setup after loading the view from its nib.
    headerLabel.text=bundleName;
    weekDays=[NSMutableArray arrayWithObjects:@"M",@"TU",@"W",@"TH",@"F",@"SA",@"SU",nil];
    [self daysOptions];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return bundleProduct.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 106;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    recommendationCustomCell *cell = (recommendationCustomCell *)[table dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==NULL) {
        NSArray *data= [[NSBundle mainBundle]loadNibNamed:@"recommendationCustomCell" owner:self options:nil];
        cell = [data objectAtIndex:0];
    }
    UIButton *senderBtnAction=[[UIButton alloc]initWithFrame:CGRectMake(284,1,34,21)];
    senderBtnAction.backgroundColor=[UIColor clearColor];
    [senderBtnAction  setImage:[UIImage imageNamed:@"cross.png"] forState:normal ];
    
    // [senderBtnAction addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    cell.croosBnt.hidden=YES;
    cell.tempLbl.hidden=YES;
    cell.dayLbl.hidden=YES;
    cell.lblError.hidden=YES;
    cell.NameLbl.text = [[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"title"];
    if ([[[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"set_time_1"] isEqualToString:@"0"]) {
        cell.timeLbl.hidden=YES;
        cell.setTime2.hidden=YES;
        cell.setTime3.hidden=YES;
        cell.lblError.hidden=NO;
    }
    if ([[[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"set_time_2"] isEqualToString:@"1"]) {
        cell.setTime2.hidden=YES;
        cell.setTime3.hidden=YES;
    }
    if ([[[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"set_time_3"] isEqualToString:@"2"]) {
        cell.setTime3.hidden=YES;
    }
    int xAxis=9;
    NSArray *temp=[days objectAtIndex:indexPath.row];
    for (int i=0; i<temp.count; i++) {
        if ([[temp objectAtIndex:i] isEqualToString:@"1"]) {
            UILabel *labelCus=[[UILabel alloc]initWithFrame:CGRectMake(xAxis, 40, 23, 23)];
            labelCus.text=[weekDays objectAtIndex:i];
            labelCus.textColor=[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
            labelCus.textAlignment=NSTextAlignmentCenter;
            labelCus.backgroundColor=[UIColor whiteColor];
            [labelCus setFont:[UIFont fontWithName:@"Lato-Bold" size:13]];
            labelCus.layer.borderColor = [UIColor blackColor].CGColor;
            labelCus.layer.cornerRadius=labelCus.frame.size.width/2.0;
            labelCus.layer.cornerRadius=labelCus.frame.size.height/2.0;
            labelCus.clipsToBounds=YES;
            UIImageView *images=[[UIImageView alloc]initWithFrame:CGRectMake(xAxis, 40, 23, 23)];
            images.image=[UIImage imageNamed:@"circle.png"];
            [cell  addSubview:labelCus];
            [cell  addSubview:images];
            xAxis=xAxis+32;
        }
    }
    cell.timeLbl.text = [[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"set_time_1"];
    cell.setTime2.text = [[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"set_time_2"];
    cell.setTime3.text = [[bundleProduct objectAtIndex:indexPath.row]valueForKey:@"set_time_3"];
    return cell;
}

-(void)daysOptions{
    days=[[NSMutableArray alloc]init];
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    NSMutableArray *temp1=[[NSMutableArray alloc]init];
    for (int i=0;i<bundleProduct.count;i++) {
        temp1=[bundleProduct objectAtIndex:i];
        [temp removeAllObjects];
        if ([temp1 valueForKey:@"monday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"monday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"tuesday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"tuesday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"wednesday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"wednesday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"thursday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"thursday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"friday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"friday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"saturday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"saturday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        if ([temp1 valueForKey:@"sunday"]!=0) {
            [temp addObject:[temp1 valueForKey:@"sunday"]];
        }
        else {
            [temp addObject:@"0"];
        }
        
        for(int i = 0; i < temp.count; i++){
            if([temp[i] isKindOfClass:[NSNull class]]){
                temp[i] = @"0";
            }
        }
        [days addObject:[temp mutableCopy]];
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    checkOutBundle *checkOut=[[checkOutBundle alloc]init];
    checkOut.bundleProduct=bundleProduct;
    checkOut.bundleName=bundleName;
    [self.navigationController pushViewController:checkOut animated:YES];
    
}
@end
