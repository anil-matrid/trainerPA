//
//  sentToClientCustomCell.h
//  TrainerVate
//
//  Created by Matrid on 09/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sentToClientCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *customUserImage;
@property (weak, nonatomic) IBOutlet UIImageView *tick;

@property (strong, nonatomic) IBOutlet UILabel *CustomUserName;
//@property (weak, nonatomic) IBOutlet UIImageView *tickImage;

@end
