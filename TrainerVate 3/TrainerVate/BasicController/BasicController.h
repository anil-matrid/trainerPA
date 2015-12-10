//
//  BasicController.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicController : UIViewController
- (IBAction)backAddStats:(id)sender;
- (IBAction)next:(id)sender;
-(IBAction)skip:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *basicHeight;
@property (strong, nonatomic) IBOutlet UITextField *basicWeight;
@property (strong, nonatomic) IBOutlet UITextField *basicWaist;
@property (strong, nonatomic) IBOutlet UITextField *basicBodyFat;
@property (strong, nonatomic) IBOutlet UITextField *basicArmSize;
@property (strong, nonatomic) IBOutlet UITextField *basicLegSize;
@property (strong, nonatomic) IBOutlet UITextField *basicWater;
@property (strong, nonatomic) IBOutlet UITextField *basicChestSize;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *viewError;
- (IBAction)btnOk:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBlured;
@property (weak, nonatomic) IBOutlet UILabel *lblMessages;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;





@end
