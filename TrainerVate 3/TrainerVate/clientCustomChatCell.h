//
//  clientCustomChatCell.h
//  messge chat
//
//  Created by Pankaj Khatri on 12/08/15.
//  Copyright (c) 2015 Pankaj Khatri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clientCustomChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackGround;


@end