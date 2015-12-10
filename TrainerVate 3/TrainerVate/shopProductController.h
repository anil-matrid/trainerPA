//
//  shopProductController.h
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface shopProductController : UIViewController<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UIPickerView *pickerViewQty;
    __weak IBOutlet UIView *pickerViewBg;
}
@property (weak, nonatomic) IBOutlet UILabel *lablQty;
- (IBAction)btnCart:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)doneBtn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIView *viewLblBack;
@property (weak, nonatomic) IBOutlet UIButton *cart;
@property (weak, nonatomic) NSString *uid;
@property (weak, nonatomic) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *headerName;
@property (weak, nonatomic) IBOutlet UIView *clearView;

@end
