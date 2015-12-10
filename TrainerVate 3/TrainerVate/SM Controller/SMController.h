//
//  SMController.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *smArmR;
@property (strong, nonatomic) IBOutlet UITextField *smArmL;
@property (strong, nonatomic) IBOutlet UITextField *smTrunk;
@property (strong, nonatomic) IBOutlet UITextField *smLegR;
@property (strong, nonatomic) IBOutlet UITextField *smLegL;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UIView *viewBlured;
@property (weak, nonatomic) IBOutlet UIView *viewError;
- (IBAction)btnOk:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblMessages;
@end
