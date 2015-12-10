//
//  recommendReminderController.m
//  TrainerVate
//
//  Created by Matrid on 03/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "recommendReminderController.h"
#import "Constants.h"
#import "recommend1.h"
#import "recommend2.h"


@interface recommendReminderController () {
    int senderTag;
    int selectedBtn;
    NSString *selectedValue;
    NSArray *pickerValue;
    NSArray *pickerDay;
    NSString *everyday;
    NSMutableDictionary *daysRecord;
    NSMutableArray *reminderProduct;
    NSDictionary *currentDic;
    NSMutableArray *reminderProducts;
    int count;
    BOOL isSet;
    BOOL isExist;
    NSString *recomendID;
    NSString *prevString;
}

@end

@implementation recommendReminderController
@synthesize timePicker,bundelName,clientID,uidStr;

- (void)viewDidLoad {
    
    [Globals GoogleAnalyticsScreenName:@"Recommend Reminder Controller"];
    if (IS_IPHONE_4_OR_LESS) {
        _scroll.contentSize=CGSizeMake(_scroll.frame.size.width, 573);
    }
    [super viewDidLoad];
    isSet=NO;
    for (UIViewController* viewController in self.navigationController.viewControllers ) {
        if ([viewController isKindOfClass:[recommend class]]) {
            for (UIViewController* viewController in self.navigationController.viewControllers ) {
                if ([viewController isKindOfClass:[recommendBundleEditing class]]) {
                    isExist = YES;
                    break;
                }
            }
        }
    }
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommend1 class]]) {
            isExist = NO;
        }
    }
    for (UIViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[recommend2 class]]) {
            isExist = NO;
        }
    }
    // Do any additional setup after loading the view from its nib.
    _mon.layer.cornerRadius=_mon.bounds.size.width/2;
    _tue.layer.cornerRadius=_tue.bounds.size.width/2;
    _wed.layer.cornerRadius=_wed.bounds.size.width/2;
    _thu.layer.cornerRadius=_thu.bounds.size.width/2;
    _fri.layer.cornerRadius=_fri.bounds.size.width/2;
    _sat.layer.cornerRadius=_sat.bounds.size.width/2;
    _sun.layer.cornerRadius=_sun.bounds.size.width/2;
    daysRecord=[[NSMutableDictionary alloc]init];
    _doneReminder.hidden=YES;
    pickerValue=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    pickerDay=[NSArray arrayWithObjects:@"Daily",@"Weekly", nil];
    [timePicker setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    reminderProduct=[[SingletonClass singleton].cartSelectedProduct mutableCopy];
    [self loadProductToProducts:reminderProduct];
    count=0;
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
    

    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)viewProductDiscreption{
    [_days setTitle:@"Daily" forState:normal];
    [self daysDefaultDailyValues];
    if(isExist==YES) {
        [self getEditReminder];
    }
    ProductRecommend *currentProduct=[reminderProducts objectAtIndex:count];
    _lblPrice.text=[NSString stringWithFormat:@"%.2f",currentProduct.price];
    _lblTitle.text=currentProduct.title;
    _lblDis.text=currentProduct.descriptionPro;
    _imgProduct.image=[Globals getImagesFromCache:currentProduct.image];
    _imgProduct.contentMode = UIViewContentModeScaleAspectFit;
    [_timePerDay setTitle:@"1" forState:normal];
    [self commitAnimationPickerView];
    NSDate *now = [NSDate date];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:locale];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    
    [_setTime setTitle:[df stringFromDate:now] forState:normal];
    [_setTime1 setTitle:[df stringFromDate:now] forState:normal];
    [_setTime2 setTitle:[df stringFromDate:now] forState:normal];

    everyday=@"1";
    _time2.alpha=0.5;
    _time3.alpha=0.5;
    _setTimeView2.hidden=NO;
    _setTimeView3.hidden=NO;
    if (count==reminderProduct.count-1) {
        _doneReminder.hidden=NO;
        _skip.hidden=YES;
        _next.hidden=YES;
        return;
    }
    
}

#pragma buttons action*************************************************
- (IBAction)btnDays:(id)sender {
    if ([_days.currentTitle isEqualToString:@"Daily"]) {
        [self daysDefaultDailyValues];
        everyday=@"1";
        return;
    }
    if ([sender tag]==2) {
        
        if ([_mon backgroundImageForState:normal] == nil) {
            [_mon setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_mon setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_mon setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"mon"];
        }
        else{
            [_mon setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_mon setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_mon setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"mon"];
        }
        
    }
    else if ([sender tag]==3) {
        if ([_tue backgroundImageForState:normal] == nil) {
            [_tue setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_tue setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_tue setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"tue"];
        }
        else{
            [_tue setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_tue setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_tue setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"tue"];
        }
        
    }
    else if ([sender tag]==4) {
        if ([_wed backgroundImageForState:normal] == nil) {
            [_wed setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_wed setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_wed setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"wed"];
        }
        else{
            [_wed setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_wed setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_wed setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"wed"];
        }
        
    }
    else if ([sender tag]==5) {
        if ([_thu backgroundImageForState:normal] == nil) {
            [_thu setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_thu setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_thu setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"thu"];
        }
        else{
            [_thu setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_thu setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_thu setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"thu"];
        }
        
    }
    else if ([sender tag]==6) {
        if ([_fri backgroundImageForState:normal] == nil) {
            [_fri setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_fri setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_fri setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"fri"];
        }
        else{
            [_fri setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_fri setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_fri setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"fri"];
        }
     
        
    }
    else if ([sender tag]==7) {
        if ([_sat backgroundImageForState:normal] == nil) {
            [_sat setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_sat setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_sat setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"sat"];
        }
        else{
            [_sat setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_sat setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_sat setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"sat"];
        }
        
    }
    else if ([sender tag]==8) {
        if ([_sun backgroundImageForState:normal] == nil) {
            [_sun setBackgroundColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0]];
            [_sun setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
            [_sun setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
            [daysRecord setObject:@"0" forKey:@"sun"];
        }
        else{
            [_sun setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
            [_sun setTitleColor:[UIColor colorWithRed:255/255.0  green:255/255.0  blue:255/255.0 alpha:1.0] forState:normal];
            [_sun setBackgroundImage:nil forState:normal];
            [daysRecord setObject:@"1" forKey:@"sun"];
        }
        
    }
   
}

- (IBAction)screenBtns:(id)sender {
    if ([sender tag]==1) {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[recommend class]] ) {
                recommend *tom = (recommend*)viewController;
                [self.navigationController popToViewController:tom animated:YES];
            }
            else if ([viewController isKindOfClass:[recommend1 class]] ) {
                recommend1 *tom = (recommend1*)viewController;
                [self.navigationController popToViewController:tom animated:YES];
            }
        }
    }
    else if ([sender tag]==9) {
        count+=1;
        [self loadProductToProducts:reminderProduct];
        
    }
    else if ([sender tag]==10) {
        [self callDataFormServer];
      }
    else if ([sender tag]==21) {
        senderTag=21;
        [self callDataFormServer];
    }
    else if ([sender tag]==15) {
        senderTag=(int)[sender tag];
        [self commitAnimationPickerView];
    }
}

- (IBAction)btnPicker:(id)sender {
    if ([sender tag]==11) {
        senderTag=(int)[sender tag];
        selectedBtn=11;
        [_pickerQty reloadAllComponents];
        _pickerQty.hidden=NO;
        _timePickerView.hidden=YES;
        prevString=_days.currentTitle;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self commitAnimationPickerView];
        });
       // NSUInteger index = [pickerDay indexOfObject:_days.titleLabel.text];
       // [_pickerQty selectRow:index inComponent:0 animated:YES];
       // [self pickerView:self.pickerQty didSelectRow:index inComponent:0];
        if ([[sender currentTitle] isEqualToString:@"Daily"]) {
            [self.pickerQty selectRow:0 inComponent:0 animated:YES];
        }
        else {
            [self.pickerQty selectRow:1 inComponent:0 animated:YES];
        }
    }
    else if ([sender tag]==12) {
        senderTag=(int)[sender tag];
        selectedBtn=12;
        [_pickerQty reloadAllComponents];
        _pickerQty.hidden=NO;
        _timePickerView.hidden=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self commitAnimationPickerView];
        });
       // NSUInteger index = [pickerValue indexOfObject:_timePerDay.titleLabel.text];
        if ([[sender currentTitle] isEqualToString:@"1"]) {
            [self.pickerQty selectRow:0 inComponent:0 animated:YES];
        }
        else if ([[sender currentTitle] isEqualToString:@"2"]) {
            [self.pickerQty selectRow:1 inComponent:0 animated:YES];
        }
        else {
            [self.pickerQty selectRow:2 inComponent:0 animated:YES];
        }
    }
    else if ([sender tag]==13) {
        senderTag=(int)[sender tag];
        [_pickerQty reloadAllComponents];
        _pickerQty.hidden=YES;
        _timePickerView.hidden=NO;
        [_done addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventTouchUpInside];
        [self commitAnimationPickerView];
        selectedBtn=13;
    }
    else if ([sender tag]==14) {
        senderTag=(int)[sender tag];
        [_pickerQty reloadAllComponents];
        _pickerQty.hidden=YES;
        _timePickerView.hidden=NO;
        [_done addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventTouchUpInside];
        [self commitAnimationPickerView];
        selectedBtn=14;
    }
    else if([sender tag]==20) {
        senderTag=(int)[sender tag];
        [_pickerQty reloadAllComponents];
        _pickerQty.hidden=YES;
        _timePickerView.hidden=NO;
        [_done addTarget:self action:@selector(LabelTitle:) forControlEvents:UIControlEventTouchUpInside];
        [self commitAnimationPickerView];
        selectedBtn=20;
    }

}


- (void)commitAnimationPickerView {
   
    if (senderTag ==11 || senderTag == 12 || senderTag ==13 || senderTag == 14 || senderTag == 20) {
        CGRect newFrame = _done.frame;
        newFrame.origin.y = 358;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _done.frame = newFrame;
        }];
        
        CGRect nFrame = _pickerQty.frame;
        nFrame.origin.y = 406;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _pickerQty.frame = nFrame;
        }];
        
        CGRect n1Frame = _timePickerView.frame;
        n1Frame.origin.y = 406;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _timePickerView.frame = n1Frame;
        }];
                
    }
    else{
        CGRect newFrame = _done.frame;
        newFrame.origin.y = 568;    // shift right by 500pts
        [UIView animateWithDuration:0.5 animations:^{
            _done.frame = newFrame;
        }];
                
        CGRect nFrame = _pickerQty.frame;
        nFrame.origin.y = 616;    // shift right by 500pts
         [UIView animateWithDuration:0.5 animations:^{
            _pickerQty.frame = nFrame;
        }];
                
        CGRect n1Frame = _timePickerView.frame;
        n1Frame.origin.y = 616;    // shift right by 500pts
        [UIView animateWithDuration:0.5  animations:^{
            _timePickerView.frame = n1Frame;
        }];
                
    }

}
////////button Action end.......................................................

#pragma mark- picker view****************************************************************
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
   
    if (selectedBtn==11) {
        [_days setTitle:[pickerDay objectAtIndex:row] forState:normal];
        if ([[_days titleForState:normal ] isEqualToString:@"Daily"]) {
            [self daysDefaultDailyValues];
            _btnView.hidden=YES;
            everyday=@"1";
        }
        else{
            [self daysDefaultWeeklyValues];
            _btnView.hidden=NO;
            everyday=@"0";
        }
    }
    else if(selectedBtn==12){
        [_timePerDay setTitle:[pickerValue objectAtIndex:row] forState:normal];
        
        if ([[_timePerDay titleForState:normal] isEqualToString:@"1"]) {
            
            _time2.alpha=0.5;
            _time3.alpha=0.5;
            _setTimeView2.hidden=NO;
            _setTimeView3.hidden=NO;
            
        }
        if ([[_timePerDay titleForState:normal] isEqualToString:@"2"]) {
            _time2.alpha=1.0;
            _time3.alpha=0.5;
            _setTimeView2.hidden=YES;
            _setTimeView3.hidden=NO;
        }
        if ([[_timePerDay titleForState:normal] isEqualToString:@"3"]) {
            _time2.alpha=1.0;
            _time3.alpha=1.0;
            _setTimeView2.hidden=YES;
            _setTimeView3.hidden=YES;
            
        }
    }

   
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    if (senderTag==11) {
        selectedValue=nil;
        selectedValue = [pickerDay objectAtIndex: row];
        // [self commitPickerAnimation];
        
    }
    else if(senderTag==12){
        selectedValue=nil;
        selectedValue = [pickerValue objectAtIndex: row];
    }
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (selectedBtn==12) {
        return 3;
    }
    return 2;
     
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (senderTag==11) {
        return [pickerDay objectAtIndex: row];
    }
    return [pickerValue objectAtIndex: row];
}

-(void)LabelTitle:(id)sender
{
    
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [df setLocale:locale];
    [df setDateStyle:NSDateFormatterNoStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
   // NSString *dateTimeString = [df stringFromDate:datePicker.date];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *str=[NSString stringWithFormat:@"%@",[df stringFromDate:timePicker.date]];
    //assign text to label
    if (selectedBtn==13) {
        [_setTime setTitle:str forState:normal];
    }
    else if(selectedBtn==14) {
        [_setTime1 setTitle:str forState:normal];
    }
    else {
        [_setTime2 setTitle:str forState:normal];
    }
    
}

#pragma reminder api*************************************************
-(void)callDataFormServer {
    if ([_days.currentTitle isEqualToString:@"Daily"]) {
        [self daysDefaultDailyValues];
    }
    if ([[daysRecord objectForKey:@"sun"]isEqualToString:@"0"] && [[daysRecord objectForKey:@"mon"]isEqualToString:@"0"] && [[daysRecord objectForKey:@"tue"]isEqualToString:@"0"] && [[daysRecord objectForKey:@"wed"]isEqualToString:@"0"] && [[daysRecord objectForKey:@"thu"]isEqualToString:@"0"] &&[[daysRecord objectForKey:@"fri"]isEqualToString:@"0"] && [[daysRecord objectForKey:@"sat"]isEqualToString:@"0"] && [_days.currentTitle isEqualToString:@"Weekly"]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblError.text=@"Please select atleast one day!";
        return;
        
    }
    if ([_timePerDay.currentTitle isEqualToString:@"1"]) {
        [_setTime1 setTitle:@"1" forState:normal];
        [_setTime2 setTitle:@"2" forState:normal];
    }
        
    else if ([_timePerDay.currentTitle isEqualToString:@"2"]) {
        [_setTime2 setTitle:@"2" forState:normal];
    }
    
    if ([_setTime.currentTitle isEqualToString:_setTime1.currentTitle]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblError.text=@"Time must not be same!";
        return;
    }
    
    if ([_setTime.currentTitle isEqualToString:_setTime1.currentTitle] || [_setTime.currentTitle isEqualToString:_setTime2.currentTitle] || [_setTime1.currentTitle isEqualToString:_setTime2.currentTitle]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblError.text=@"Time must not be same!";
        return;
    }
    
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    if ([uidStr isEqualToString:@""] || uidStr.length==0) {
           uidStr = recomendID;
    }
    if ([_days.currentTitle isEqualToString:@"Weekly"]) {
        everyday=@"0";
    }
    else {
        everyday=@"1";
    }
    NSString *urlString=[Globals urlCombileHash:kApiDomin3 ClassUrl:KurlUpdateRecommendationReminder apiKey:[Globals apiKey]];
    NSString *pid=[[reminderProduct objectAtIndex:count] valueForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uidStr,@"uid",pid,@"product_id",everyday,@"everyday",[daysRecord  objectForKey:@"sun"],@"sunday",[daysRecord  objectForKey:@"mon"],@"monday",[daysRecord  objectForKey:@"tue"],@"tuesday",[daysRecord  objectForKey:@"wed"],@"wednesday",[daysRecord  objectForKey:@"thu"],@"thursday",[daysRecord  objectForKey:@"fri"],@"friday",[daysRecord  objectForKey:@"sat"],@"saturday",[_timePerDay titleForState:normal],@"occurance",[_setTime titleForState:normal],@"set_time_1",[_setTime1 titleForState:normal],@"set_time_2",[_setTime2 titleForState:normal],@"set_time_3",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                count+=1;
                [hudFirst hide:YES];
                if (senderTag==21) {
                    isSet=YES;
                    _bluredView.hidden=NO;
                    _errorView.hidden=NO;
                    _lblError.text=@"Your reminder for products have been set.";
                    _lblToHide.hidden=YES;
                    _errorLbl.hidden=YES;
                }
                else {
                     [self loadProductToProducts:reminderProduct];
                }
            }
            else {
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblError.text=@"Something went wrong! Please try again later.";
                [hudFirst hide:YES];
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblError.text=@"Something went wrong! Please try again later.";
    }];
    
}

-(void)loadProductToProducts:(NSArray *)response {
    reminderProducts = [[NSMutableArray alloc]init];
    NSMutableArray *imageArr=[NSMutableArray array];
    for (int i=0; i<response.count;i++ ) {
        currentDic=[response objectAtIndex:i];
        ProductRecommend *product=[ProductRecommend new];
        product.title=[currentDic valueForKey:@"title"];
        product.image=[currentDic valueForKey:@"image"];
        product.price=[[currentDic valueForKey:@"price"] floatValue];
        product.uid=[[currentDic valueForKey:@"uid"] intValue];
        product.quantity=1;
        [imageArr addObject:product.image];
        [reminderProducts addObject:product];
    }
    [Globals saveUserImagesIntoCache:imageArr];
    [self viewProductDiscreption];
}

#pragma days default values**************************************************
-(void)daysDefaultWeeklyValues {
    [daysRecord setObject:@"0" forKey:@"mon"];
    [_mon setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_mon setBackgroundColor:[UIColor whiteColor]];
    [_mon setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
    
    [daysRecord setObject:@"0" forKey:@"tue"];
    [_tue setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_tue setBackgroundColor:[UIColor whiteColor]];
    [_tue setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
   
    [daysRecord setObject:@"0" forKey:@"wed"];
    [_wed setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_wed setBackgroundColor:[UIColor whiteColor]];
    [_wed setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
    
    [daysRecord setObject:@"0" forKey:@"thu"];
    [_thu setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_thu setBackgroundColor:[UIColor whiteColor]];
    [_thu setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
  
    [daysRecord setObject:@"0" forKey:@"fri"];
    [_fri setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_fri setBackgroundColor:[UIColor whiteColor]];
    [_fri setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
   
    [daysRecord setObject:@"0" forKey:@"sat"];
    [_sat setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_sat setBackgroundColor:[UIColor whiteColor]];
    [_sat setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
    
    [daysRecord setObject:@"0" forKey:@"sun"];
    [_sun setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
    [_sun setBackgroundColor:[UIColor whiteColor]];
    [_sun setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
}
-(void)daysDefaultDailyValues {
    [daysRecord setObject:@"1" forKey:@"mon"];
    [_mon setTitleColor:[UIColor whiteColor] forState:normal];
    [_mon setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_mon setBackgroundImage:nil forState:normal];
    
    [daysRecord setObject:@"1" forKey:@"tue"];
    [_tue setTitleColor:[UIColor whiteColor] forState:normal];
    [_tue setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_tue setBackgroundImage:nil forState:normal];
    
    [daysRecord setObject:@"1" forKey:@"wed"];
    [_wed setTitleColor:[UIColor whiteColor] forState:normal];
    [_wed setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_wed setBackgroundImage:nil forState:normal];
    
    [daysRecord setObject:@"1" forKey:@"thu"];
    [_thu setTitleColor:[UIColor whiteColor] forState:normal];
    [_thu setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_thu setBackgroundImage:nil forState:normal];
    
    [daysRecord setObject:@"1" forKey:@"fri"];
    [_fri setTitleColor:[UIColor whiteColor] forState:normal];
    [_fri setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_fri setBackgroundImage:nil forState:normal];
    
    [daysRecord setObject:@"1" forKey:@"sat"];
    [_sat setTitleColor:[UIColor whiteColor] forState:normal];
    [_sat setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_sat setBackgroundImage:nil forState:normal];
    
    [daysRecord setObject:@"1" forKey:@"sun"];
    [_sun setTitleColor:[UIColor whiteColor] forState:normal];
    [_sun setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
    [_sun setBackgroundImage:nil forState:normal];
}

- (IBAction)ok:(id)sender {
    if (isSet==YES) {
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            if ([viewController isKindOfClass:[recommend class]]) {
                recommend *tom = (recommend*)viewController;
                [self.navigationController popToViewController:tom animated:YES];
                break;
            }
            else if ([viewController isKindOfClass:[recommend1 class]]){
                recommend1 *tom = (recommend1*)viewController;
                [self.navigationController popToViewController:tom animated:YES];
                break;
            }
        }
    }
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
}

-(void)getEditReminder
{
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"GetRecomendationProductReminder/" apiKey:[Globals apiKey]];
    NSString *pid=[[reminderProduct objectAtIndex:count] valueForKey:@"uid"];
    recomendID=[[SingletonClass singleton].bundelSelectedProduct  objectForKey:@"name"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:recomendID,@"recommendation_id",pid,@"product_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqual:@"SUCCESS"]) {
                NSArray *jsonData=[json objectForKey:@"returnset"];
                [daysRecord setObject:[jsonData valueForKey:@"sunday"] forKey:@"sun"];
                [daysRecord setObject:[jsonData valueForKey:@"monday"] forKey:@"mon"];
                [daysRecord setObject:[jsonData valueForKey:@"tuesday"] forKey:@"tue"];
                [daysRecord setObject:[jsonData valueForKey:@"wednesday"] forKey:@"wed"];
                [daysRecord setObject:[jsonData valueForKey:@"thursday"] forKey:@"thu"];
                [daysRecord setObject:[jsonData valueForKey:@"friday"] forKey:@"fri"];
                [daysRecord setObject:[jsonData valueForKey:@"saturday"] forKey:@"sat"];
                if (![[jsonData valueForKey:@"set_time_1"] isEqualToString:@"0"]) {
                    [_setTime setTitle:[jsonData valueForKey:@"set_time_1"] forState:normal];
                    [_timePerDay setTitle:@"1" forState:normal];
                    _time2.alpha=0.5;
                    _time3.alpha=0.5;
                    _setTimeView2.hidden=NO;
                    _setTimeView3.hidden=NO;
                }
                if (![[jsonData valueForKey:@"set_time_2"] isEqualToString:@"1"]) {
                    [_setTime1 setTitle:[jsonData valueForKey:@"set_time_2"] forState:normal];
                    [_timePerDay setTitle:@"2" forState:normal];
                    _time2.alpha=1.0;
                    _time3.alpha=0.5;
                    _setTimeView2.hidden=YES;
                    _setTimeView3.hidden=NO;
                }
                if (![[jsonData valueForKey:@"set_time_3"] isEqualToString:@"2"]) {
                    [_setTime2 setTitle:[jsonData valueForKey:@"set_time_3"] forState:normal];
                    [_timePerDay setTitle:@"3" forState:normal];
                    _time2.alpha=1.0;
                    _time3.alpha=1.0;
                    _setTimeView2.hidden=YES;
                    _setTimeView3.hidden=YES;
                }
                if ([[daysRecord objectForKey:@"sun"]isEqualToString:@"1"] && [[daysRecord objectForKey:@"mon"]isEqualToString:@"1"] && [[daysRecord objectForKey:@"tue"]isEqualToString:@"1"] && [[daysRecord objectForKey:@"wed"]isEqualToString:@"1"] && [[daysRecord objectForKey:@"thu"]isEqualToString:@"1"] &&[[daysRecord objectForKey:@"fri"]isEqualToString:@"1"] && [[daysRecord objectForKey:@"sat"]isEqualToString:@"1"]) {
                    [_days setTitle:@"Daily" forState:normal];
                    [self daysDefaultDailyValues];
                    
                }
                
                else if ([[daysRecord objectForKey:@"sun"]isEqualToString:@"1"] || [[daysRecord objectForKey:@"mon"]isEqualToString:@"1"] || [[daysRecord objectForKey:@"tue"]isEqualToString:@"1"] || [[daysRecord objectForKey:@"wed"]isEqualToString:@"1"] || [[daysRecord objectForKey:@"thu"]isEqualToString:@"1"] ||[[daysRecord objectForKey:@"fri"]isEqualToString:@"1"] || [[daysRecord objectForKey:@"sat"]isEqualToString:@"1"]) {
                    [_days setTitle:@"Weekly" forState:normal];
                    if ([[daysRecord objectForKey:@"mon"] isEqualToString:@"1"]) {
                        [_mon setTitleColor:[UIColor whiteColor] forState:normal];
                        [_mon setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_mon setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_mon setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_mon setBackgroundColor:[UIColor whiteColor]];
                        [_mon setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                    if ([[daysRecord objectForKey:@"tue"] isEqualToString:@"1"]) {
                        [_tue setTitleColor:[UIColor whiteColor] forState:normal];
                        [_tue setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_tue setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_tue setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_tue setBackgroundColor:[UIColor whiteColor]];
                        [_tue setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                    if ([[daysRecord objectForKey:@"wed"] isEqualToString:@"1"]) {
                        [_wed setTitleColor:[UIColor whiteColor] forState:normal];
                        [_wed setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_wed setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_wed setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_wed setBackgroundColor:[UIColor whiteColor]];
                        [_wed setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                    if ([[daysRecord objectForKey:@"thu"] isEqualToString:@"1"]) {
                        [_thu setTitleColor:[UIColor whiteColor] forState:normal];
                        [_thu setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_thu setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_thu setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_thu setBackgroundColor:[UIColor whiteColor]];
                        [_thu setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                    if ([[daysRecord objectForKey:@"fri"] isEqualToString:@"1"]) {
                        [_fri setTitleColor:[UIColor whiteColor] forState:normal];
                        [_fri setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_fri setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_fri setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_fri setBackgroundColor:[UIColor whiteColor]];
                        [_fri setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                    if ([[daysRecord objectForKey:@"sat"] isEqualToString:@"1"]) {
                        [_sat setTitleColor:[UIColor whiteColor] forState:normal];
                        [_sat setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_sat setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_sat setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_sat setBackgroundColor:[UIColor whiteColor]];
                        [_sat setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                    if ([[daysRecord objectForKey:@"sun"] isEqualToString:@"1"]) {
                        [_sun setTitleColor:[UIColor whiteColor] forState:normal];
                        [_sun setBackgroundColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0]];
                        [_sun setBackgroundImage:nil forState:normal];
                    }
                    else {
                        [_sun setTitleColor:[UIColor colorWithRed:15/255.0  green:47/255.0  blue:64/255.0 alpha:1.0] forState:normal];
                        [_sun setBackgroundColor:[UIColor whiteColor]];
                        [_sun setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
                    }
                    
                }
                
                else{
                    _days.titleLabel.text=@"Daily";
                }
                
                [hudFirst hide:YES];
                    
            }
            else{
                _bluredView.hidden=NO;
                _errorView.hidden=NO;
                _lblError.text=@"Somthing went wrong! Please try again later.";
                [hudFirst hide:YES];
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _bluredView.hidden=NO;
        _errorView.hidden=NO;
        _lblError.text=@"Somthing went wrong! Please try again later.";
    }];
    
}
@end
