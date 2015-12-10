//
//  recommendationBundelInfo.h
//  TrainerVate
//
//  Created by Matrid on 26/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recommendationBundelInfo : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    
    __weak IBOutlet UILabel *headerLabel;
//    __weak IBOutlet UITableView *table;
}
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
- (IBAction)back:(id)sender;
- (IBAction)next:(id)sender;
@property (strong, nonatomic) NSString *bundleName;
@property (strong, nonatomic) NSMutableArray *bundleProduct;
@property (weak, nonatomic) IBOutlet UIButton *proceedBtn;


@end
