//
//  clientListViewCell.h
//  TrainerVate
//
//  Created by Matrid on 29/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clientListViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblClientName;
@property (weak, nonatomic) IBOutlet UIImageView *imgUserPic;
@property (weak, nonatomic) IBOutlet UILabel *lblLatestMessage;

@end
