//
//  howActiveYouAre.h
//  TrainerVate
//
//  Created by Matrid on 21/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface howActiveYouAre : UIViewController

//outlets
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIButton *veryActive;
@property (weak, nonatomic) IBOutlet UIButton *iGoThrough;
@property (weak, nonatomic) IBOutlet UIButton *notAtAll;

//buttons
- (IBAction)next:(id)sender;
- (IBAction)btnActive:(id)sender;
- (IBAction)back:(id)sender;

@end
