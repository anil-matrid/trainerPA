//
//  trainerSettings.h
//  TrainerVate
//
//  Created by Matrid on 08/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trainerSettings : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
- (IBAction)removeBtn:(id)sender;
- (IBAction)clearBtn:(id)sender;
- (IBAction)revenueBtn:(id)sender;
- (IBAction)addProffilepic:(id)sender;
- (IBAction)passBtn:(id)sender;
- (IBAction)emailBtn:(id)sender;
- (IBAction)languageBtn:(id)sender;
- (IBAction)notifications:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *select;
@property (strong, nonatomic) IBOutlet UILabel *headerTItle;
- (IBAction)backBtn:(id)sender;
- (IBAction)navBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)logoutBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)uniqueBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *blurredView;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UILabel *idLbl;
- (IBAction)okBtn:(id)sender;
- (IBAction)clientReq:(id)sender;
- (IBAction)clientPendingReq:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)done:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerQty;
@property (weak, nonatomic) IBOutlet UIButton *done;
@property (weak, nonatomic) IBOutlet UISwitch *notification;


@end
