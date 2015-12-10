//
//  shopSubSubCategoryController.h
//  TrainerVate
//
//  Created by Matrid on 24/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shopSubSubCategoryController : UIViewController<UITableViewDataSource,UITableViewDelegate>


- (IBAction)back:(id)sender;
@property (weak, nonatomic) NSDictionary  *subCategoryHolder;
@property (weak, nonatomic) NSString  *name;
@property (weak, nonatomic) NSString  *preClass;
- (IBAction)search:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *headerName;
@property (weak, nonatomic) IBOutlet UILabel *lblQty;
@property (weak, nonatomic) IBOutlet UIView *viewLblBack;
@property (weak, nonatomic) IBOutlet UIButton *btnCart;
@end
