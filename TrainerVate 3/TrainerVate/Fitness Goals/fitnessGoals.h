//
//  fitnessGoals.h
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fitnessGoals : UIViewController
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *loseWeight;
@property (weak, nonatomic) IBOutlet UIButton *strengthCore;
@property (weak, nonatomic) IBOutlet UIButton *targetUpper;
@property (weak, nonatomic) IBOutlet UIButton *targetLower;
@property (weak, nonatomic) IBOutlet UIButton *buildMuscle;
@property (weak, nonatomic) IBOutlet UIButton *toneMuscle;
@property (weak, nonatomic) IBOutlet UIButton *improveIndurance;
@property (weak, nonatomic) IBOutlet UIButton *improveFlexi;
- (IBAction)goal:(id)sender;
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UIView *errorView;
- (IBAction)ok:(id)sender;

@end
