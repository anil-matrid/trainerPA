//
//  ReminderView.h
//  TrainerVate
//
//  Created by Pankaj Khatri on 06/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReminderViewDelegate <NSObject>
@required
- (void)ReminderViewDetialsDays:(NSString *)daySet numberOfTimes:(NSString *)numberOfTime setTime1:(NSString *)setTime1 setTime2:(NSString *)setTime2 setTime3:(NSString *)setTime3 DaysArray:(NSArray *)daysArray ;
-(void)ReminderVIewObject:(UIView*)View;
-(void)CrossButtonTapped;
@end



@interface ReminderView : UIView<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    UILabel *headerLabel;
    UIActionSheet*  pickerViewPopup;
    UILabel *lblTimesPerDay;  // lbl for btn timeperday
    
    id <ReminderViewDelegate> _delegate;
    
        UILabel *lblSetTime1;  // lbl for btn timeperday
        UILabel *lblSetTime2;  // lbl for btn timeperday
        UILabel *lblSetTime3;  // lbl for btn timeperday
    
    
}
@property (assign, nonatomic) int NumberOf;
@property (nonatomic, strong) UIView *viewsDaysBtns;
@property (nonatomic, retain) UIPickerView *PickerViewSelect;

@property (nonatomic, retain) UITextField *txtDays;
@property (nonatomic, retain) UIImageView *imgDays;
@property (nonatomic, retain) UIImageView *imgTimesPerDay;
@property (nonatomic, retain) UITextField *txtTimesPerDay;
@property (nonatomic, retain) UITextField *txtSetTime1;
@property (nonatomic, retain) UITextField *txtSetTime2;
@property (nonatomic, retain) UITextField *txtSetTime3;
@property (nonatomic, retain) NSMutableArray *DaysArray;
@property (nonatomic, retain) NSMutableArray *SlectedDaysArray;
@property (nonatomic,strong) id delegate;
@property (nonatomic, retain) NSMutableDictionary *rdict;

-(void)reloadData;
-(void)reloadDaysBtns;
@end
