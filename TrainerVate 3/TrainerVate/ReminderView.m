//
//  ReminderView.m
//  TrainerVate
//
//  Created by Pankaj Khatri on 06/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "ReminderView.h"

@implementation ReminderView
{
   // UITextField *textField;
    UIDatePicker *datePickerNew;
    NSArray *daysArrayChar;
    NSArray *timeArray;
    NSArray *pickerArray;
    NSArray *weekArray;
    NSArray *weekArrayName;
    NSMutableArray *storeBtnInArray;
    UIButton *btnSetReminder;
    
}
@synthesize viewsDaysBtns,PickerViewSelect,txtDays,txtSetTime1,txtSetTime2,txtSetTime3,txtTimesPerDay,DaysArray,imgDays,imgTimesPerDay,rdict,SlectedDaysArray;

- (void)baseInit {
   
    daysArrayChar =[NSArray arrayWithObjects:@"        Daily",@"      Weekly", nil];
    timeArray =[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    weekArray =[NSArray arrayWithObjects:@"M",@"T",@"W",@"T",@"F",@"S",@"S",nil];
    weekArrayName=[NSArray arrayWithObjects:@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday",nil];
    
    SlectedDaysArray = [NSMutableArray array];
    DaysArray = [NSMutableArray array];
    storeBtnInArray =[NSMutableArray array];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *CurrentTime =[formatter stringFromDate:[NSDate date]];
    
    
    self.frame = CGRectMake(0, 0, 280, 340);
    
    UIImageView *dot =[[UIImageView alloc] initWithFrame:CGRectMake(240,5,35,21)];
    dot.image=[UIImage imageNamed:@"logo.png"];
    [self addSubview:dot];

    headerLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 35, 240, 25)];
    headerLabel.font = [UIFont fontWithName:@"Lato-Medium" size:15];
    [headerLabel setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];

    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = @"Set reminders for the workout";
    [self addSubview:headerLabel];
    self.backgroundColor = [UIColor colorWithRed:233.0/255.0 green:233.0/255.0 blue:233.0/255.0 alpha:1.0];
    
    // setting cross button
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"cross.png"] forState:normal];
    [btn addTarget:self action:@selector(crossWithDelegate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // setting the view
    UILabel *lblDay = [[UILabel alloc]initWithFrame:CGRectMake(20, headerLabel.frame.size.height + headerLabel.frame.origin.y +5, 50, 25)];
    lblDay.text=@"Days";
    lblDay.font = [UIFont fontWithName:@"Lato-Medium" size:14];
    [lblDay setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    [self addSubview:lblDay];
    
    txtDays = [[UITextField alloc]initWithFrame:CGRectMake(lblDay.frame.origin.x+lblDay.frame.size.width + 100, lblDay.frame.origin.y, 90, 25)];
    txtDays.backgroundColor = [UIColor whiteColor];
    [txtDays setFont:[UIFont fontWithName:@"Lato-Medium" size:12]];

    txtDays.textAlignment = NSTextAlignmentCenter;
txtDays.text = @"        Daily";
//    [txtDays setValue:[rdict objectForKey:@""] forKey:<#(NSString *)#>
    [txtDays setBackground:[UIImage imageNamed:@"1.png"]];

    //txtDays.layer.borderWidth = 3;
    [self addSubview:txtDays];
    
//    imgDays = [[UIImageView alloc]initWithFrame:CGRectMake(txtDays.frame.origin.x+2, txtDays.frame.origin.y + txtDays.frame.size.height/2 -2  , 24, 9)];
//    [imgDays setImage:[UIImage imageNamed:@"sign_arrow_down.png"] ];
//    [self addSubview:imgDays];
    
    
    viewsDaysBtns = [[UIView alloc]initWithFrame:CGRectMake(0, txtDays.frame.size.height+txtDays.frame.origin.y+5, 280, 40)];
    viewsDaysBtns.backgroundColor = [UIColor clearColor];

    [self addSubview:viewsDaysBtns];
    
    // setting the view
    lblTimesPerDay = [[UILabel alloc]initWithFrame:CGRectMake(20, viewsDaysBtns.frame.origin.y + 45, 100, 25)];
    lblTimesPerDay.text=@"Times Per Day";
    lblTimesPerDay.font = [UIFont fontWithName:@"Lato-Medium" size:14];
    [lblTimesPerDay setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];

    [self addSubview:lblTimesPerDay];

    txtTimesPerDay = [[UITextField alloc]initWithFrame:CGRectMake(lblTimesPerDay.frame.origin.x+lblTimesPerDay.frame.size.width + 50, lblTimesPerDay.frame.origin.y, 90, 25)];
    txtTimesPerDay.backgroundColor = [UIColor whiteColor];
//    txtTimesPerDay.font = [UIFont fontWithName:@"Lato-Medium.ttf" size:13];
    [txtTimesPerDay setFont:[UIFont fontWithName:@"Lato-Medium" size:12]];
    txtTimesPerDay.textAlignment = NSTextAlignmentCenter;
    txtTimesPerDay.text = @"        1";
    [self addSubview:txtTimesPerDay];
    [txtTimesPerDay setBackground:[UIImage imageNamed:@"1.png"]];
    
    //setting img
    //imgTimesPerDay = [[UIImageView alloc]initWithFrame:CGRectMake(txtTimesPerDay.frame.origin.x+2, txtTimesPerDay.frame.origin.y + //txtTimesPerDay.frame.size.height/2 -2  , 24, 9)];
//    [imgTimesPerDay setImage:[UIImage imageNamed:@"arrow.png"] ];
    //	[self addSubview:imgTimesPerDay];
    
    

    // setTIme1
    lblSetTime1 = [[UILabel alloc]initWithFrame:CGRectMake(20, txtTimesPerDay.frame.size.height + txtTimesPerDay.frame.origin.y + 5, 100, 25)];
    lblSetTime1.text=@"Set Time";
    lblSetTime1.font = [UIFont fontWithName:@"Lato-Medium" size:14];
    [lblSetTime1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];

    [self addSubview:lblSetTime1];
    
    txtSetTime1 = [[UITextField alloc]initWithFrame:CGRectMake(lblSetTime1.frame.origin.x+lblSetTime1.frame.size.width + 50, lblSetTime1.frame.origin.y, 90, 25)];
    txtSetTime1.backgroundColor = [UIColor whiteColor];
    txtSetTime1.font = [UIFont fontWithName:@"Lato-Medium" size:12];

    txtSetTime1.textAlignment = NSTextAlignmentRight;
    txtSetTime1.text = CurrentTime;
    [txtSetTime1 setBackground:[UIImage imageNamed:@"1.png"]];

    [self addSubview:txtSetTime1];
   
    // setTIme2
    lblSetTime2 = [[UILabel alloc]initWithFrame:CGRectMake(20, txtSetTime1.frame.size.height + txtSetTime1.frame.origin.y + 5, 100, 25)];
    lblSetTime2.text=@"Set Time";
    lblSetTime2.font = [UIFont fontWithName:@"Lato-Medium" size:14];
    [lblSetTime2 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];

    lblSetTime2.hidden = YES;

    [self addSubview:lblSetTime2];
    
    txtSetTime2 = [[UITextField alloc]initWithFrame:CGRectMake(lblSetTime2.frame.origin.x+lblSetTime2.frame.size.width + 50, lblSetTime2.frame.origin.y, 90, 25)];
    txtSetTime2.backgroundColor = [UIColor whiteColor];
    txtSetTime2.font = [UIFont fontWithName:@"Lato-Medium" size:12];

    txtSetTime2.textAlignment = NSTextAlignmentRight;
    txtSetTime2.text = CurrentTime;
    txtSetTime2.hidden = YES;
    [txtSetTime2 setBackground:[UIImage imageNamed:@"1.png"]];

    [self addSubview:txtSetTime2];
    
    // setTIme3
    lblSetTime3 = [[UILabel alloc]initWithFrame:CGRectMake(20, txtSetTime2.frame.size.height + txtSetTime2.frame.origin.y + 5, 100, 25)];
    lblSetTime3.text=@"Set Time";
    lblSetTime3.font = [UIFont fontWithName:@"Lato-Medium" size:14];
    [lblSetTime3 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];

    lblSetTime3.hidden = YES;
    [self addSubview:lblSetTime3];
    
    txtSetTime3 = [[UITextField alloc]initWithFrame:CGRectMake(lblSetTime3.frame.origin.x+lblSetTime3.frame.size.width + 50, lblSetTime3.frame.origin.y, 90, 25)];
    txtSetTime3.backgroundColor = [UIColor whiteColor];
    txtSetTime3.font = [UIFont fontWithName:@"Lato-Medium" size:12];

    txtSetTime3.textAlignment = NSTextAlignmentRight;
    txtSetTime3.text = CurrentTime;
    txtSetTime3.hidden = YES;
    [txtSetTime3 setBackground:[UIImage imageNamed:@"1.png"]];

    [self addSubview:txtSetTime3];

    
    
    btnSetReminder = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    btnSetReminder.frame = CGRectMake(0,  lblTimesPerDay.frame.size.height+ lblTimesPerDay.frame.origin.y + 50, self.frame.size.width, 38);
    [btnSetReminder setBackgroundImage:[UIImage imageNamed:@"footernewbg.png"] forState:UIControlStateNormal];
    btnSetReminder.tintColor = [UIColor whiteColor];
    [btnSetReminder setTitle:@"Set Reminder" forState:UIControlStateNormal];
    
    [btnSetReminder addTarget:self action:@selector(setRemiderWithDelegate) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnSetReminder];
    [self createInputView];
    [self CreateWeekDaysButton];
    txtDays.delegate = self;
    txtSetTime1.delegate = self;
    txtSetTime2.delegate = self;
    txtSetTime3.delegate = self;
    txtTimesPerDay.delegate = self;
    viewsDaysBtns.hidden = YES;
    
    
    if (txtSetTime2.text.length==0) {
        
    }
    
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self reloadData];
    } completion:nil];

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];
    }
    return self;
}
-(void)setRemiderWithDelegate{
    [self.delegate ReminderViewDetialsDays:txtDays.text numberOfTimes:txtTimesPerDay.text setTime1:txtSetTime1.text setTime2:txtSetTime2.text setTime3:txtSetTime3.text DaysArray:DaysArray];
}
-(void)crossWithDelegate {
    self.viewForBaselineLayout.hidden=YES ;
    [self.delegate CrossButtonTapped];
}
-(void)CreateWeekDaysButton{
    
    int Xvalue=15;
    for (int i=0; i<7; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame: CGRectMake( Xvalue, 5, 30, 30 )];
        button.layer.cornerRadius = 15;
        button.clipsToBounds = YES;
        [button setTitle: [weekArray objectAtIndex:i] forState: UIControlStateNormal];
        [button addTarget:self action:@selector(btnSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        //[button setImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:UIControlStateNormal];
        button.tag = i;
        [viewsDaysBtns addSubview:button];
        Xvalue = Xvalue + 37;
        [storeBtnInArray addObject:button];
    }


}
-(IBAction)btnSelected:(UIButton*)sender{
    if ([SlectedDaysArray containsObject:[NSNumber numberWithInteger:sender.tag]]) {
        NSInteger num = [SlectedDaysArray indexOfObject:[NSNumber numberWithInteger:sender.tag]];
        [SlectedDaysArray removeObjectAtIndex:num];
        [sender setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
        [sender setBackgroundColor:[UIColor clearColor]];
        
    }
    else{
        [SlectedDaysArray addObject:[NSNumber numberWithInteger:sender.tag]];
        [sender setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [sender setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    }
    [DaysArray removeAllObjects];
    for (int i=0; i<SlectedDaysArray.count; i++) {
        int currentNumber =[[SlectedDaysArray objectAtIndex:i] intValue];
        //int num=[[weekArray objectAtIndex:i] intValue];
        [DaysArray addObject:[weekArrayName objectAtIndex:currentNumber]];
    }
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
   
}

//-(IBAction)BtnDays:(UIButton *)sender{
//
//
//}
-(void)reloadData{

    if (viewsDaysBtns.hidden == YES ) {
       lblTimesPerDay.frame =  CGRectMake(20, viewsDaysBtns.frame.origin.y + 5, 100, 25);
        txtTimesPerDay.frame = CGRectMake(lblTimesPerDay.frame.origin.x+lblTimesPerDay.frame.size.width + 50, lblTimesPerDay.frame.origin.y, 90, 25);
        lblSetTime1.frame = CGRectMake(20, txtTimesPerDay.frame.size.height + txtTimesPerDay.frame.origin.y + 5, 100, 25);
        txtSetTime1.frame = CGRectMake(lblSetTime1.frame.origin.x+lblSetTime1.frame.size.width + 50, lblSetTime1.frame.origin.y, 90, 25);
        lblSetTime2.frame = CGRectMake(20, txtSetTime1.frame.size.height + txtSetTime1.frame.origin.y + 5, 100, 25);
        txtSetTime2.frame = CGRectMake(lblSetTime2.frame.origin.x+lblSetTime2.frame.size.width + 50, lblSetTime2.frame.origin.y, 90, 25);
        lblSetTime3.frame = CGRectMake(20, txtSetTime2.frame.size.height + txtSetTime2.frame.origin.y + 5, 100, 25);
        txtSetTime3.frame = CGRectMake(lblSetTime3.frame.origin.x+lblSetTime3.frame.size.width + 50, lblSetTime3.frame.origin.y, 90, 25);
        // btnSetReminder.frame = CGRectMake(0,  lblTimesPerDay.frame.size.height+ lblTimesPerDay.frame.origin.y + 100, self.frame.size.width, 30);
    }
    else{
        lblTimesPerDay.frame =  CGRectMake(20, viewsDaysBtns.frame.origin.y + 45, 100, 25);
        txtTimesPerDay.frame = CGRectMake(lblTimesPerDay.frame.origin.x+lblTimesPerDay.frame.size.width + 50, lblTimesPerDay.frame.origin.y, 90, 25);
        lblSetTime1.frame = CGRectMake(20, txtTimesPerDay.frame.size.height + txtTimesPerDay.frame.origin.y + 5, 100, 25);
        txtSetTime1.frame = CGRectMake(lblSetTime1.frame.origin.x+lblSetTime1.frame.size.width + 50, lblSetTime1.frame.origin.y, 90, 25);
        lblSetTime2.frame = CGRectMake(20, txtSetTime1.frame.size.height + txtSetTime1.frame.origin.y + 5, 100, 25);
        txtSetTime2.frame = CGRectMake(lblSetTime2.frame.origin.x+lblSetTime2.frame.size.width + 50, lblSetTime2.frame.origin.y, 90, 25);
        lblSetTime3.frame = CGRectMake(20, txtSetTime2.frame.size.height + txtSetTime2.frame.origin.y + 5, 100, 25);
        txtSetTime3.frame = CGRectMake(lblSetTime3.frame.origin.x+lblSetTime3.frame.size.width + 50, lblSetTime3.frame.origin.y, 90, 25);
       // btnSetReminder.frame = CGRectMake(0,  lblTimesPerDay.frame.size.height+ lblTimesPerDay.frame.origin.y + 100, self.frame.size.width, 30);
    }
    
    
    if (txtSetTime3.hidden == YES && txtSetTime2.hidden ==YES) {
        btnSetReminder.frame = CGRectMake(0,  txtSetTime1.frame.size.height+ txtSetTime1.frame.origin.y + 5, self.frame.size.width, 38);
    }
    else if (txtSetTime3.hidden == YES){
     btnSetReminder.frame = CGRectMake(0,  txtSetTime2.frame.size.height+ txtSetTime2.frame.origin.y + 5, self.frame.size.width, 38);
    }
    if (txtSetTime2.hidden == NO){
        btnSetReminder.frame = CGRectMake(0,  txtSetTime2.frame.size.height+ txtSetTime2.frame.origin.y + 5, self.frame.size.width, 38);
    }
    if (txtSetTime3.hidden == NO){
    btnSetReminder.frame = CGRectMake(0,  txtSetTime3.frame.size.height+ txtSetTime3.frame.origin.y + 5, self.frame.size.width, 38);
    }
    
    CGRect ViewFrame = self.frame;
    ViewFrame.size.height = btnSetReminder.frame.origin.y+btnSetReminder.frame.size.height;
    self.frame = ViewFrame;
    [self.delegate ReminderVIewObject:self];
}
- (void)createInputView {
    PickerViewSelect = [[UIPickerView alloc] initWithFrame:CGRectZero];
    PickerViewSelect.delegate = self;
    PickerViewSelect.dataSource = self;
    PickerViewSelect.showsSelectionIndicator = YES;
    
    datePickerNew = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [datePickerNew setDatePickerMode:UIDatePickerModeTime];
    
    [datePickerNew setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    
    txtDays.inputView = PickerViewSelect;
    txtSetTime1.inputView = datePickerNew;
    txtSetTime2.inputView = datePickerNew;
    txtSetTime3.inputView = datePickerNew;
    txtTimesPerDay.inputView = PickerViewSelect;
}

#pragma mark- PickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    
    //  NSLog(@"%@",[dataArray objectAtIndex:row]);
    // selectedCategory = [NSString stringWithFormat:@"%@",[dataArray objectAtIndex:row]];
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerArray.count;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [pickerArray objectAtIndex:row];
    
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}

-(void)categoryDoneButtonPressed{
    //   categoryLable.text = selectedCategory;
    [pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)categoryCancelButtonPressed{
    [pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

#pragma mark- textField delegate and data source
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (txtDays == textField) {
        pickerArray = daysArrayChar;
                [PickerViewSelect reloadAllComponents];
    }
    if (txtTimesPerDay== textField) {
        pickerArray =  timeArray;
        [PickerViewSelect reloadAllComponents];
    }
    if (textField == txtSetTime1 || textField == txtSetTime2 || textField == txtSetTime3) {
        
       // NSString *dateStr = @"Tue, 25 May 2010 12:53:58 +0000";
        // Convert string to date object
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm a"];
        NSDate *date = [dateFormat dateFromString:textField.text];
        
        if (date==nil) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"hh:mm a"];
            date = [dateFormat dateFromString:textField.text];
        }
        
      //  [PickerViewSelect set]
        
//        [PickerViewSelect. ];
        [datePickerNew setDate:date];
        
        
    }
   

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (txtDays == textField) {
       NSInteger row = [PickerViewSelect selectedRowInComponent:0];
        txtDays.text = [pickerArray objectAtIndex:row];
        if ([textField.text isEqualToString:@"        Daily"]) {
                viewsDaysBtns.hidden = YES;
        }
        else{
                        viewsDaysBtns.hidden = NO;
        }
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self reloadData];
        } completion:nil];
        
        return;
    }
    if (txtTimesPerDay == textField) {
        NSInteger row = [PickerViewSelect selectedRowInComponent:0];
        txtTimesPerDay.text = [pickerArray objectAtIndex:row];
        if ([textField.text isEqualToString:@"1"]) {
            txtSetTime2.hidden = YES;
            txtSetTime3.hidden = YES;
            lblSetTime2.hidden = YES;
            lblSetTime3.hidden = YES;
        }
        if ([textField.text isEqualToString:@"2"]) {
            txtSetTime2.hidden = NO;
            lblSetTime2.hidden = NO;
            txtSetTime3.hidden = YES;
            lblSetTime3.hidden = YES;
        }
        if ([textField.text isEqualToString:@"3"]) {
            txtSetTime2.hidden = NO;
            txtSetTime3.hidden = NO;
            lblSetTime2.hidden = NO;
            lblSetTime3.hidden = NO;
        }
        
        
        NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
        dateFormatters.dateFormat = @"hh:mm a";
        NSString *currentTime=[dateFormatters stringFromDate:[NSDate date]];
        
        if (txtTimesPerDay == textField) {
            if ([txtTimesPerDay.text isEqualToString:@"1"] && [txtSetTime1.text isEqualToString:@""]) {
                txtSetTime1.text=currentTime;
            }
            if ([txtTimesPerDay.text isEqualToString:@"2"] && [txtSetTime2.text isEqualToString:@""]) {
                txtSetTime2.text=currentTime;
                if ([txtSetTime1.text isEqualToString:@""]) {
                    txtSetTime1.text=currentTime;
                }
            }
            if ([txtTimesPerDay.text isEqualToString:@"3"] && [txtSetTime3.text isEqualToString:@""]) {
                txtSetTime3.text=currentTime;
                if ([txtSetTime2.text isEqualToString:@""]) {
                    txtSetTime2.text=currentTime;
                }
            }
        }

        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [self reloadData];
        } completion:nil];

        
        return;
    }
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"hh:mm a"];
    
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:locale];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
   // [df stringFromDate:datePickerNew.date];
    if (txtSetTime1 == textField) {
        txtSetTime1.text = [df stringFromDate:[datePickerNew date]];
    }
    if (txtSetTime2 == textField) {
        txtSetTime2.text = [df stringFromDate:[datePickerNew date]];
    }
    if (txtSetTime3 == textField) {
        txtSetTime3.text = [df stringFromDate:[datePickerNew date]];
    }
    
//    if (txtSetTime1 == textField && [txtSetTime1.text isEqualToString:@""]) {
//        textField.text=currentTime;
//    }
//    if (txtSetTime2 == textField && [txtSetTime2.text isEqualToString:@""]) {
//        textField.text=currentTime;
//    }
//    if (txtSetTime3 == textField && [txtSetTime3.text isEqualToString:@""]) {
//        textField.text=currentTime;
//    }
    
    
}
-(void)reloadDaysBtns{
    
    for (int i=0; i<SlectedDaysArray.count; i++) {
        int value=[[SlectedDaysArray objectAtIndex:i] intValue];
        UIButton *selectedBtn=[storeBtnInArray objectAtIndex:value];
            [selectedBtn setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
         [selectedBtn setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    }
    [DaysArray removeAllObjects];
    for (int i=0; i<SlectedDaysArray.count; i++) {
        int currentNumber =[[SlectedDaysArray objectAtIndex:i] intValue];
        //int num=[[weekArray objectAtIndex:i] intValue];
        [DaysArray addObject:[weekArrayName objectAtIndex:currentNumber]];
    }
    
    if (txtSetTime1.text.length==0 && [txtTimesPerDay.text isEqualToString:@"0"]) {
        txtSetTime1.hidden=YES;
        lblSetTime1.hidden=YES;
        txtTimesPerDay.text=@"0";
    }
    else{
        lblSetTime1.hidden=NO;
        txtSetTime1.hidden=NO;
        txtTimesPerDay.text=@"1";
    }
    if (txtSetTime2.text.length==0 &&  [txtTimesPerDay.text isEqualToString:@"1"]) {
        txtSetTime2.hidden=YES;
        lblSetTime2.hidden=YES;
         txtTimesPerDay.text=@"1";
    }
    else{
        if (txtSetTime1.text.length!=0) {
            txtSetTime2.hidden=NO;
            lblSetTime2.hidden=NO;
            txtTimesPerDay.text=@"2";
        }
    }
    if (txtSetTime3.text.length==0 && [txtTimesPerDay.text isEqualToString:@"2"]) {
        txtSetTime3.hidden=YES;
        lblSetTime3.hidden=YES;
         txtTimesPerDay.text=@"2";
    }
    else{
        if (txtSetTime2.text.length!=0 && txtSetTime1.text.length!=0) {
            txtSetTime3.hidden=NO;
            lblSetTime3.hidden=NO;
            txtTimesPerDay.text=@"3";

        }
    }
    [self reloadData];
    
}

@end