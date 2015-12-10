//
//  AddBodyStats.h
//  TrainerVate
//
//  Created by Matrid on 02/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBodyStats : UIViewController
- (IBAction)backStats:(id)sender;
- (IBAction)basic:(id)sender;
- (IBAction)bmi:(id)sender;
- (IBAction)sm:(id)sender;
- (IBAction)skinFold:(id)sender;
- (IBAction)bf:(id)sender;
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *navigationBar;


@end
