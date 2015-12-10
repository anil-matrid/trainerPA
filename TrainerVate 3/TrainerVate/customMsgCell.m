//
//  customMsgCell.m
//  TrainerVate
//
//  Created by Matrid on 01/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "customMsgCell.h"

@implementation customMsgCell
@synthesize textLablel=textLablel;
@synthesize userImage=_userImage;

- (void)awakeFromNib {
    
    _userImage.layer.cornerRadius=_userImage.frame.size.width/2;
    _userImage.clipsToBounds=YES;
    textLablel.lineBreakMode = NSLineBreakByWordWrapping;
    textLablel.font=[UIFont systemFontOfSize:10];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
