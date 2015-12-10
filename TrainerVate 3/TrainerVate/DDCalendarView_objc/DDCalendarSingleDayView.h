//
//  DDCalendarView.h
//  CustomerApp
//
//  Created by Dominik Pich on 25/09/15.
//  Copyright © 2015 Dominik Pich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDCalendarView;

@interface DDCalendarSingleDayView : UIScrollView

@property(nonatomic, strong) NSDate *  date;
@property(nonatomic, assign) BOOL showsTomorrow;
@property(nonatomic, assign) BOOL showsTimeMarker;

@property(nonatomic, strong) NSArray *  events;
@property(nonatomic, weak) DDCalendarView *  calendar;

- (void)scrollTimeToVisible:(NSDate* )date animated:(BOOL)animated;

@end
