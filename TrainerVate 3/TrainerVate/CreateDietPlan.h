//
//  CreateDietPlan.h
//  TrainerVate
//
//  Created by Matrid on 07/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateDietPlan : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
IBOutlet UIScrollView *scrollViews;
    
    __weak IBOutlet UIView *erroriew;
    __weak IBOutlet UIView *bluredView;
        IBOutlet UILabel *lblcarbohydrates;
        IBOutlet UILabel *lblfat;
        IBOutlet UILabel *lblfiber;
        IBOutlet UILabel *lblprotein;
        IBOutlet UILabel *lblsalt;
        IBOutlet UILabel *lblsugar;
        IBOutlet UILabel *lblCalories;
    __weak IBOutlet UILabel *lblError;
    
}
- (IBAction)backDietPlan:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *mealTable;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextView *dietDiscreption;
@property (weak, nonatomic) IBOutlet UIImageView *btnImage1;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UITextView *txtVHowToPrepare;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalCal;
@property (weak, nonatomic) IBOutlet UIView *viewDaysBtn;
@property (weak, nonatomic) IBOutlet UIView *viewHowToPrepare;
@property (weak, nonatomic) IBOutlet UITextField *txtRepeat;
- (IBAction)ok:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *lblDescription;
@end
