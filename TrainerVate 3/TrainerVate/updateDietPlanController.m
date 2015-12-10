//
//  updateDietPlanController.m
//  TrainerVate
//
//  Created by Pankaj Khatri on 23/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "updateDietPlanController.h"
#import "breakFastFooterCustomCell.h"

@interface updateDietPlanController ()

@end

@implementation updateDietPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableView methods************************************************

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 105;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5; //one male and other female
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaultCell=@"default";
    breakFastFooterCustomCell *cell=(breakFastFooterCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    if (cell==NULL) {
        NSArray *dietCustom=[[NSBundle mainBundle]loadNibNamed:@"breakFastFooterCustomCell" owner:self options:nil];
        cell=[dietCustom objectAtIndex:0];
    }
    [cell.addFoodBreakFast addTarget:self action:@selector(addProduct:) forControlEvents:UIControlEventTouchUpInside];
    [cell.addSupplementBreakFast addTarget:self action:@selector(addSuppliment:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
   
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    CGFloat xAxis = 10;
    
    for (int i=0; i<7; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(xAxis, 10, 20, 20)];
        button.layer.cornerRadius = button.frame.size.width/2;
        button.clipsToBounds = YES;
        button.tag = i;
        button.backgroundColor = [UIColor lightGrayColor];
        [footerView addSubview:button];
        xAxis=xAxis + 25;
    }
    
    return footerView;
}

#pragma mark- nibaction
-(IBAction)addProduct:(id)sender{

}
-(IBAction)addSuppliment:(id)sender{

}

@end
