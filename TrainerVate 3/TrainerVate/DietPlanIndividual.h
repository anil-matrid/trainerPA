//
//  DietPlanIndividual.h
//  TrainerVate
//
//  Created by Matrid on 14/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DietPlanIndividual : UIViewController
{
    IBOutlet UIScrollView *dietPlanIndividualViews;
}

@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *weekly;
- (IBAction)weekly:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *yearly;
- (IBAction)yearly:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *daily;
- (IBAction)daily:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage2;
@property (weak, nonatomic) IBOutlet UIButton *daysOptions;
- (IBAction)daysOptions:(id)sender;


@end
