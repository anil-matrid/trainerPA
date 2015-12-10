//
//  CustomTableDiet.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableDiet : UITableViewCell<UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *dietImage;
@property (strong, nonatomic) IBOutlet UILabel *dietName;
@property (weak, nonatomic) IBOutlet UILabel *dietDisc;


@property (strong, nonatomic) IBOutlet UIImageView *tick;

@end
