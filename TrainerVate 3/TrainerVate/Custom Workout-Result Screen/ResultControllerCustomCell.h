//
//  ResultControllerCustomCell.h
//  My Client- Workout
//
//  Created by Matrid on 01/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultControllerCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *weightlbl;
@property (strong, nonatomic) IBOutlet UILabel *speedlbl;
@property (strong, nonatomic) IBOutlet UILabel *repslbl;
@property (strong, nonatomic) IBOutlet UIImageView *picsimg;
@property (strong, nonatomic) IBOutlet UILabel *namelbl;

@end
