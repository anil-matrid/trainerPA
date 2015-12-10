//
//  HomeScreenController.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface HomeScreenController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *profilePics;
- (IBAction)btnHomeScreen:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *profileUserName;
- (IBAction)profilePicEditor:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editProfile;


@end
