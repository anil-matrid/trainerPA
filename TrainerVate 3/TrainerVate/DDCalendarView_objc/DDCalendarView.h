//
//  DDCalendarView.h
//  CustomerApp
//
//  Created by Dominik Pich on 25/09/15.
//  Copyright © 2015 Dominik Pich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDCalendarViewDelegate;
@protocol DDCalendarViewDataSource;
@class DDCalendarEvent;
@class DDCalendarEventView;

IB_DESIGNABLE
@interface DDCalendarView : UIView

@property(nonatomic, strong) NSDate *  date; //note, causes a reloadData
@property(nonatomic, assign) IBInspectable BOOL showsTomorrow;
@property(nonatomic, assign) IBInspectable BOOL showsTimeMarker;

@property(nonatomic, weak) IBOutlet id<DDCalendarViewDelegate> delegate;
@property(nonatomic, weak) IBOutlet id<DDCalendarViewDataSource> dataSource; //note, causes a reloadData

- (void)reloadData;
- (void)scrollDateToVisible:(NSDate* )date animated:(BOOL)animated;

@end

@protocol DDCalendarViewDelegate <NSObject>

@optional
- (void)calendarView:(DDCalendarView* )view focussedOnDay:(NSDate* )date;
- (void)calendarView:(DDCalendarView* )view didSelectEvent:(DDCalendarEvent* )event;
- (BOOL)calendarView:(DDCalendarView* )view allowEditingEvent:(DDCalendarEvent* )event;
- (void)calendarView:(DDCalendarView* )view commitEditEvent:(DDCalendarEvent* )event; //if allow editing returns yes, this is mandatory

@end

@protocol DDCalendarViewDataSource <NSObject>

- (NSArray* )calendarView:(DDCalendarView* )view eventsForDay:(NSDate* )date;

@optional
- (DDCalendarEventView* )calendarView:(DDCalendarView* )view viewForEvent:(DDCalendarEvent* )event; //if not implemented / returns nil, default views are used

@end