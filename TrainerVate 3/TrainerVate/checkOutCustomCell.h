//
//  checkOutCustomCell.h
//  TrainerVate
//
//  Created by Matrid on 26/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface checkOutCustomCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *productQty;
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@end
