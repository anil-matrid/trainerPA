//
//  UpdateTrainnerController.h
//  TrainerVate
//
//  Created by Matrid on 11/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateTrainnerController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIPopoverControllerDelegate>
{
    UIActionSheet *actionSheet;
    UIPopoverController *popoverController;
}
- (IBAction)PostData:(id)sender;
-(IBAction)pickImage:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UIButton *imagbtn;
- (IBAction)back:(id)sender;
@end
