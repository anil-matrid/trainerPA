//
//  Exercise Name.h
//  My Client- Workout
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseName : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet UIButton *savebtn;
- (IBAction)removebtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *removebtn;
- (IBAction)addbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addbtn;
- (IBAction)backbtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtfield1;
@property (strong, nonatomic) IBOutlet UITextField *textfield2;
@property (strong, nonatomic) IBOutlet UITextField *textfield3;
@property (weak, nonatomic) IBOutlet UITextField *txtReps;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (weak, nonatomic) IBOutlet UIButton *yes;
@property (weak, nonatomic) IBOutlet UIButton *no;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIImageView *img2;

@property (weak, nonatomic) IBOutlet UITextView *txtViewDetail;
@property (weak, nonatomic) IBOutlet UITextView *lblInstruction;
@property (weak, nonatomic) IBOutlet UILabel *lblExerciseName;
- (IBAction)yesBtn:(id)sender;
- (IBAction)noBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewToHide;
@property (weak, nonatomic) IBOutlet UIScrollView *scorllViews;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UILabel *view2Lbl;
- (IBAction)okBtn2:(id)sender;

@end
