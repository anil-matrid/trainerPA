//
//  recommendationCustomCell.h
//  TrainerVate
//
//  Created by Matrid on 30/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recommendationCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *dayLbl;
@property (strong, nonatomic) IBOutlet UIButton *croosBnt;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *setTime2;
@property (weak, nonatomic) IBOutlet UILabel *setTime3;
@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
@property (strong, nonatomic) IBOutlet UILabel *lblError;
@end
