//
//  ProductRecommend.h
//  TrainerVate
//
//  Created by Matrid on 28/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductRecommend : NSObject
@property (nonatomic,strong) NSString *currency;
@property (nonatomic,strong) NSString *descriptionPro;
@property (nonatomic,strong) NSArray *goodFor;
@property (nonatomic,strong) NSString *image;
@property (nonatomic,strong) NSString *imageLarge;
@property (nonatomic,strong) NSString *imageNormal;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *bundelname;
@property (nonatomic) float price;
@property (nonatomic) int timestamps;
@property (nonatomic) int uid;
@property (nonatomic) int quantity;
@property (nonatomic,strong) NSArray *selectedBundel;
@property (nonatomic, strong) NSArray *myBundel;

@end
