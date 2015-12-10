//
//  dietHeadder.h
//  TrainerVate
//
//  Created by Matrid on 13/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dietHeadder : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dietImage;
@property (weak, nonatomic) IBOutlet UILabel *dietTitle;
@property (weak, nonatomic) IBOutlet UILabel *dietKcal;

@end
