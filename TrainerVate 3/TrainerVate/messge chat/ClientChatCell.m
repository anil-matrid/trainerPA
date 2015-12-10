//
//  ClientChatCell.m
//  TrainerVate
//
//  Created by Matrid on 01/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ClientChatCell.h"

@implementation ClientChatCell

- (void)awakeFromNib {
    // Initialization code
    _userImage.layer.cornerRadius=_userImage.bounds.size.height/2;
    _userImage.clipsToBounds=YES;
    _userImage.backgroundColor=[UIColor greenColor];
    
    self.message.lineBreakMode = NSLineBreakByCharWrapping;
    self.message.numberOfLines = 1000;
    
    self.layer.cornerRadius=5;
    self.clipsToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
