//
//  dietReminder.h
//  TrainerVate
//
//  Created by Matrid on 13/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dietReminder : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mon;
@property (weak, nonatomic) IBOutlet UIButton *tue;
@property (weak, nonatomic) IBOutlet UIButton *wed;
@property (weak, nonatomic) IBOutlet UIButton *thr;
@property (weak, nonatomic) IBOutlet UIButton *fri;
@property (weak, nonatomic) IBOutlet UIButton *sat;
@property (weak, nonatomic) IBOutlet UIButton *sun;

@end
