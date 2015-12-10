//
//  CreateAccountController.h
//  TrainerVate
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountController : UIViewController
- (IBAction)back:(id)sender;
- (IBAction)next:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *tainerImage;
@property (weak, nonatomic) IBOutlet UIImageView *clientimage;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;

@end
