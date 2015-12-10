//
//  shopProductController.h
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface  shopSearchControllerViewController: UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIPickerView *pickerViewQty;
    __weak IBOutlet UIView *pickerViewBg;
    __weak IBOutlet UIView *blockedView;
}
@property (weak, nonatomic) IBOutlet UILabel *lablQty;
@property (weak, nonatomic) IBOutlet UIImageView *errorIcon;
- (IBAction)btnCart:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)doneBtn:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UITableView *tblSupplements;
@property (weak, nonatomic) IBOutlet UIView *viewLblBack;
@property (weak, nonatomic) IBOutlet UIButton *cart;
@property (weak, nonatomic) NSString *uid;
- (IBAction)search:(id)sender;
@property (strong, nonatomic) NSString *preClass;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchText;

@end
