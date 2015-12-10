//
//  ViewController.h
//  Appointment screen
//
//  Created by Matrid on 15/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentScreen : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *timeFrom;

- (IBAction)bookButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
- (IBAction)okButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *am;
@property (strong, nonatomic) IBOutlet UILabel *pm;

- (IBAction)rejectBtn:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *timeTO;
@property (strong, nonatomic) NSDictionary *apppointmentData;
@property (strong, nonatomic) IBOutlet UILabel *from;
@property (strong, nonatomic) IBOutlet UILabel *from2;
@property (strong, nonatomic) IBOutlet UITextView *where;
@property (strong, nonatomic) IBOutlet UITextView *notes;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
- (IBAction)back:(id)sender;
- (IBAction)nav:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *view2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *view2DateLbl;
@property (strong, nonatomic) IBOutlet UILabel *view2FromTime;
@property (strong, nonatomic) IBOutlet UILabel *view2TImeTo;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UILabel *view2TOLbl;
@property (strong, nonatomic) IBOutlet UIView *footerLbl;

@end

