//
//  ClientHomeScreen.h
//  TrainerVate
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientHomeScreen : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *userprofilePic;
- (IBAction)workoutClient:(id)sender;
- (IBAction)dietPlanClient:(id)sender;
- (IBAction)calendarClient:(id)sender;
- (IBAction)messagesClient:(id)sender;
- (IBAction)myStats:(id)sender;
- (IBAction)recommended:(id)sender;
- (IBAction)shopClient:(id)sender;
- (IBAction)settingClient:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
