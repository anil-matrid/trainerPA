//
//  MainScreenController.h
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScreenController : UIViewController
{
    NSDictionary *userID2;
}
@property (strong ,nonatomic)NSDictionary *userID2;
@property (strong ,nonatomic)NSString *useType;
- (IBAction)login:(id)sender;
- (IBAction)Register:(id)sender;
- (IBAction)back:(id)sender;


@end
