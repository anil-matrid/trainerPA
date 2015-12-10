//
//  Client workout custom cell.h
//  My Client- Workout
//
//  Created by Matrid on 21/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface clientWorkoutCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (strong, nonatomic) IBOutlet UILabel *days1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *days2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *days3Lbl;
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *tick;
@property (weak, nonatomic) IBOutlet UILabel *backLbl;
@property (weak, nonatomic) IBOutlet UIImageView *lblToHide;

@end
