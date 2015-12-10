//
//  AppoinmentViewController.m
//  TrainerVate
//
//  Created by Matrid on 03/11/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AppoinmentViewController.h"
#import "DDCalendarEvent.h"
#import "NSDate+DDCalendar.h"
#import "DDCalendarView.h"
#import "EventView.h"
#import "Constants.h"

@interface AppoinmentViewController ()<DDCalendarViewDataSource, DDCalendarViewDelegate>

@end

@implementation AppoinmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.calendarView scrollDateToVisible:[NSDate date] animated:animated];
}

- (NSArray *)eventsForDay:(NSInteger)dayMod {
    DDCalendarEvent *event2 = [DDCalendarEvent new];
    [event2 setTitle: @"Demo Event 3"];
    [event2 setDateBegin:[NSDate dateWithHour:3 min:15 inDays:dayMod]];
    [event2 setDateEnd:[NSDate dateWithHour:4 min:0 inDays:dayMod]];
    [event2 setUserInfo:@{@"color":[UIColor yellowColor]}];
    
    DDCalendarEvent *event3 = [DDCalendarEvent new];
    [event3 setTitle: @"Demo Event 1"];
    [event3 setDateBegin:[NSDate dateWithHour:1 min:00 inDays:dayMod]];
    [event3 setDateEnd:[NSDate dateWithHour:2 min:10 inDays:dayMod]];
    
    DDCalendarEvent *event4 = [DDCalendarEvent new];
    [event4 setTitle: @"Demo Event 5"];
    [event4 setDateBegin:[NSDate dateWithHour:5 min:39 inDays:dayMod]];
    [event4 setDateEnd:[NSDate dateWithHour:6 min:13 inDays:dayMod]];
    [event4 setUserInfo:@{@"color":[UIColor yellowColor]}];
    
    DDCalendarEvent *event1 = [DDCalendarEvent new];
    [event1 setTitle: @"Demo Event 7"];
    [event1 setDateBegin:[NSDate dateWithHour:7 min:00 inDays:dayMod]];
    [event1 setDateEnd:[NSDate dateWithHour:12 min:13 inDays:dayMod]];
    
    DDCalendarEvent *event5 = [DDCalendarEvent new];
    [event5 setTitle: @"Demo Event 13"];
    [event5 setDateBegin:[NSDate dateWithHour:13 min:00 inDays:dayMod]];
    [event5 setDateEnd:[NSDate dateWithHour:14 min:13 inDays:dayMod]];
    
    DDCalendarEvent *event7 = [DDCalendarEvent new];
    [event7 setTitle: @"Demo Event 15"];
    [event7 setDateBegin:[NSDate dateWithHour:15 min:30 inDays:dayMod]];
    [event7 setDateEnd:[NSDate dateWithHour:16 min:30 inDays:dayMod]];
    [event7 setUserInfo:@{@"color":[UIColor greenColor]}];
    
    DDCalendarEvent *event8 = [DDCalendarEvent new];
    [event8 setTitle: @"Demo Event 17"];
    [event8 setDateBegin:[NSDate dateWithHour:17 min:40 inDays:dayMod]];
    [event8 setDateEnd:[NSDate dateWithHour:21 min:30 inDays:dayMod]];
    
    DDCalendarEvent *event9 = [DDCalendarEvent new];
    [event9 setTitle: @"Demo Event 22"];
    [event9 setDateBegin:[NSDate dateWithHour:22 min:00 inDays:dayMod]];
    [event9 setDateEnd:[NSDate dateWithHour:23 min:30 inDays:dayMod]];
    
    return @[event1, event2, event3, event4, event5, event7, event8, event9];
}

#pragma mark DDCalendarViewDelegate

- (void)calendarView:(DDCalendarView* )view focussedOnDay:(NSDate* )date {
  //  self.dayLabel.text = date.stringWithDateOnly;
}

- (void)calendarView:(DDCalendarView* )view didSelectEvent:(DDCalendarEvent* )event {
    NSLog(@"%@", event);
}

- (BOOL)calendarView:(DDCalendarView* )view allowEditingEvent:(DDCalendarEvent* )event {
    return YES;
}

- (void)calendarView:(DDCalendarView* )view commitEditEvent:(DDCalendarEvent* )event {
    NSLog(@"%@", event);
    //should do conflic validation and maybe save ;) or revert :P
}

#pragma mark DDCalendarViewDataSource

- (NSArray *)calendarView:(DDCalendarView *)view eventsForDay:(NSDate *)date {
    //should come from db ;) NOW using testdata
    NSInteger daysMod = [date daysFromDate:[NSDate date]];
    NSArray *newE = [self eventsForDay:daysMod]; //always today ;)
    
    NSMutableArray *dates = [NSMutableArray array];
    for (DDCalendarEvent *e in newE) {
        if([e.dateBegin isEqualDay:date] ||
           [e.dateEnd isEqualDay:date]) {
            [dates addObject:e];
        }
    }
    return dates;
}

//optionally provide a view
- (DDCalendarEventView *)calendarView:(DDCalendarView *)view viewForEvent:(DDCalendarEvent *)event {
    return [[EventView alloc] initWithEvent:event];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
