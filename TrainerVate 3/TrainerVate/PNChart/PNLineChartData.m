//
// Created by Jörg Polakowski on 14/12/13.
// Copyright (c) 2013 kevinzhow. All rights reserved.
//

#import "PNLineChartData.h"

@implementation PNLineChartData

- (id)init
{
    self = [super init];
    if (self) {
        [self setupDefaultValues];
    }
    
    return self;
}

- (void)setupDefaultValues
{
    _inflexionPointStyle = PNLineChartPointStyleNone;
    _inflexionPointWidth = 9.f;
    _lineWidth = 1.f;
    _alpha = 1.f;
}

@end
