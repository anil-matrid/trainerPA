//
//  ViewController.m
//  dietPlanController
//
//  Created by Matrid on 06/11/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "dietPlanGlobalVIew.h"
#import "dietBodyCell.h"
#import "dietFooterCell.h"
#import "dietHeaderCell.h"

@interface dietPlanGlobalVIew ()

@end

@implementation dietPlanGlobalVIew

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 529;
    }
    else if (indexPath.row==1){
        return 200;
    }
    else{
        return 297;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *defaultCell = @"default";
    
        if (indexPath.row==0) {
            dietHeaderCell *cell =[tableView dequeueReusableCellWithIdentifier:defaultCell];
            if (cell==NULL) {
                NSArray *mArray = [[NSBundle mainBundle]loadNibNamed:@"dietHeaderCell" owner:self options:nil];
                cell = [mArray objectAtIndex:0];
        
            }
            return cell;
        }
    else if (indexPath.row==1){
        dietBodyCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
        if (cell==NULL) {
            NSArray *mArray = [[NSBundle mainBundle]loadNibNamed:@"dietBodyCell" owner:self options:nil];
            cell = [mArray objectAtIndex:0];
        }
        return cell;
    }
    else{
        dietFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
        if (cell==NULL) {
            NSArray *mArray = [[NSBundle mainBundle]loadNibNamed:@"dietFooterCell" owner:self options:nil];
            cell = [mArray objectAtIndex:0];

        }
        return cell;
    }
    
}

// TABLE VIEW DELEGATE METHODS END...


- (IBAction)doneBtn:(id)sender {
}

- (IBAction)backBtn:(id)sender {
}
@end
