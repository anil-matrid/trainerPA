//
//  clientCustomChatCell.m
//  messge chat
//
//  Created by Pankaj Khatri on 12/08/15.
//  Copyright (c) 2015 Pankaj Khatri. All rights reserved.
//

#import "clientCustomChatCell.h"

@implementation clientCustomChatCell

- (void)awakeFromNib {
    // Initialization code
    _userImage.layer.cornerRadius=_userImage.bounds.size.height/2;
    _userImage.clipsToBounds=YES;
    _userImage.backgroundColor=[UIColor greenColor];
    
    self.layer.cornerRadius=5;
    self.clipsToBounds=YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
