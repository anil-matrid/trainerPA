//
//  SkinFoldController.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkinFoldController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)skip:(id)sender;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *sfPectoral;
@property (strong, nonatomic) IBOutlet UITextField *sfAbdominal;
@property (strong, nonatomic) IBOutlet UITextField *sfThigh;
@property (strong, nonatomic) IBOutlet UITextField *sfTriceps;
@property (strong, nonatomic) IBOutlet UITextField *sfSubscapular;
@property (strong, nonatomic) IBOutlet UITextField *sfSupralic;
@property (strong, nonatomic) IBOutlet UITextField *sfAxila;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (weak, nonatomic) IBOutlet UIView *viewBlured;
@property (weak, nonatomic) IBOutlet UIView *viewError;
- (IBAction)btnOk:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblMessages;
@end
