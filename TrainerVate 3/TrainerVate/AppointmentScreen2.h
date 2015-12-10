//
//  ViewController.h
//  appointment screen2
//
//  Created by Matrid on 15/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface AppointmentScreen2 : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate, UISearchBarDelegate, UISearchDisplayDelegate,UISearchControllerDelegate,MBProgressHUDDelegate>{

    __weak IBOutlet UIView *offView2;
    __weak IBOutlet UIButton *btnTitle;
    __weak IBOutlet UILabel *lbluserName;
    __weak IBOutlet UIView *datePicketViewBg;
    __weak IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UILabel *lblFromDate;
    __weak IBOutlet UILabel *lblFromTime;
    __weak IBOutlet UILabel *lblToTime;
    __weak IBOutlet UILabel *lblToDate;
    __weak IBOutlet UILabel *lblFromAmPm;
    __weak IBOutlet UILabel *lblToAmPm;
    __weak IBOutlet UITextView *where;
    __weak IBOutlet UIView *bookOffView;
    __weak IBOutlet UIButton *book2;
    __weak IBOutlet UITextView *notes;
    __weak IBOutlet UIButton *bookBtn;
}
- (IBAction)appointmentButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *appointmentButton;
@property (strong, nonatomic) NSString *bookTime;
@property (strong, nonatomic) IBOutlet NSDate *CurrentDate;
- (IBAction)bookButton:(id)sender;
- (IBAction)okButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *to;
- (IBAction)doneBtn:(UIButton *)sender;
- (IBAction)btnDateSelect:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableViews;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBarController;
@property (strong, nonatomic) IBOutlet UILabel *view2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *view2DateLbl;
@property (strong, nonatomic) IBOutlet UILabel *view2TimeLbl2;
@property (strong, nonatomic) IBOutlet UILabel *view2TimeLbl1;
- (IBAction)view3Ok:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UILabel *view3Lbl;



@end

