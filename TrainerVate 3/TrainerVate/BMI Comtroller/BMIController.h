//
//  BMIController.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMIController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *bmiTotalWeight;
@property (strong, nonatomic) IBOutlet UITextField *bmiPhysicalRating;
@property (strong, nonatomic) IBOutlet UITextField *bmiBoneMass;
@property (strong, nonatomic) IBOutlet UITextField *bmiBmr;
@property (strong, nonatomic) IBOutlet UITextField *bmiVisceralFat;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@property (weak, nonatomic) IBOutlet UIView *viewBlured;
@property (weak, nonatomic) IBOutlet UIView *viewError;
- (IBAction)btnOk:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblMessages;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;

@end
