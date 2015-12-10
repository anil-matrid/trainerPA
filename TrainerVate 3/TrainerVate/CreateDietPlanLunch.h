//
//  CreateDietPlan.h
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateDietPlanLunch : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
IBOutlet UIScrollView *scrollViews;
    
    IBOutlet UILabel *lblcarbohydrates;
    IBOutlet UILabel *lblfat;
    IBOutlet UILabel *lblfiber;
    IBOutlet UILabel *lblkcal;
    IBOutlet UILabel *lblprotein;
    IBOutlet UILabel *lblsalt;
    IBOutlet UILabel *lblsugar;
    

}
- (IBAction)backDietPlan:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *erroriew;
@property (weak, nonatomic) IBOutlet UIView *bluredView;
@property (weak, nonatomic) IBOutlet UILabel *lblError;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewDaysBtn;
@property (weak, nonatomic) IBOutlet UIView *viewHowToPrepare;
@property (strong, nonatomic) IBOutlet UITableView *mealTable;
@property (weak, nonatomic) IBOutlet UITextField *txtRepeat;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextView *dietDiscreption;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage1;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)daysOptions:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
@property (weak, nonatomic) IBOutlet UITextView *txtHowToPrepare;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalCal;


//PreDic
@property(strong,nonatomic)NSDictionary *breakFastDataDic;

@end
