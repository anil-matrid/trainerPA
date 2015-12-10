//
//  EditReminderController.m
//  My Client- Workout
//
//  Created by Matrid on 03/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "EditReminderController.h"

@interface EditReminderController (){
    int senderTag;
    int selectedBtn;
    NSString *selectedValue;
    NSArray *pickerValue;
    NSArray *pickerDay;
    int count;
}

@end

@implementation EditReminderController
@synthesize donebtn,mon,tue,wed,thu,fri,sat,sun,addbtn,pickerView,datepicker,daysbtn,occurencebtn,setTime1,setTime2,setTime3,view2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    mon.layer.cornerRadius = mon.bounds.size.width/2.0;

    tue.layer.cornerRadius=tue.bounds.size.width/2.0;
    wed.layer.cornerRadius=wed.bounds.size.width/2.0;
    thu.layer.cornerRadius=thu.bounds.size.width/2.0;
    fri.layer.cornerRadius=fri.bounds.size.width/2.0;
    sat.layer.cornerRadius=sat.bounds.size.width/2.0;
    sun.layer.cornerRadius=sun.bounds.size.width/2.0;
    pickerValue=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    pickerDay=[NSArray arrayWithObjects:@"     Daily",@"     Weekly",@"     Monthly", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)daysbtns:(UIButton *)sender {
    if (sender.tag==5) {
        if ([mon backgroundImageForState:normal]==nil) {
            [mon setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [mon setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [mon setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [mon setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [mon setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [mon setBackgroundImage:nil forState:normal];

        }
    }
    else if (sender.tag==6){
        if ([tue backgroundImageForState:normal]==nil) {
            [tue setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [tue setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [tue setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [tue setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [tue setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [tue setBackgroundImage:nil forState:normal];
        }
    }
    else if (sender.tag==7){
        if ([wed backgroundImageForState:normal]==nil) {
            [wed setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [wed setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [wed setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [wed setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [wed setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [wed setBackgroundImage:nil forState:normal];
        }
    }
    else if (sender.tag==8){
        if ([thu backgroundImageForState:normal]==nil) {
            [thu setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [thu setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [thu setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [thu setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [thu setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [thu setBackgroundImage:nil forState:normal];
        }
    }
    
    else if (sender.tag==9){
        if ([fri backgroundImageForState:normal]==nil) {
            [fri setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [fri setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [fri setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [fri setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [fri setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [fri setBackgroundImage:nil forState:normal];
        }
        
    }
    else if (sender.tag==10){
        if ([sat backgroundImageForState:normal]==nil) {
            [sat setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [sat setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [sat setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [sat setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [sat setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [sat setBackgroundImage:nil forState:normal];
        }
        
    }
    
    else if (sender.tag==11){
        if ([sun backgroundImageForState:normal]==nil) {
            [sun setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
            [sun setTitleColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0] forState:normal];
            [sun setBackgroundImage:[UIImage imageNamed:@"circle.png"] forState:normal];
        }
        else{
            [sun setBackgroundColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [sun setTitleColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:normal];
            [sun setBackgroundImage:nil forState:normal];
        }
        
    }
    
}



- (IBAction)pickerBtns:(UIButton *)sender {
    if (sender.tag==1) {
        senderTag=(int)[sender tag];
        selectedBtn=1;
        [pickerView reloadAllComponents];
        pickerView.hidden=NO;
        view2.hidden=YES;
        donebtn.hidden=NO;

        [self commitAnimationPickerView];
        
        
    }
    else if (sender.tag==2){
        senderTag=(int)[sender tag];
        selectedBtn =2;
        [pickerView reloadAllComponents];
        pickerView.hidden=NO;
        view2.hidden=YES;
        donebtn.hidden=NO;

        [self commitAnimationPickerView];
    }
    else if (sender.tag==3){
        senderTag=(int)[sender tag];
        selectedBtn=3;
        [pickerView reloadAllComponents];
        pickerView.hidden=YES;
        view2.hidden=NO;
        donebtn.hidden=NO;


        [self commitAnimationPickerView];
    }
    else if (sender.tag==4){
        senderTag=(int)[sender tag];
        selectedBtn=4;
        [pickerView reloadAllComponents];
        pickerView.hidden=YES;
        view2.hidden=NO;
        donebtn.hidden=NO;

        [self commitAnimationPickerView];
    }
    else if (sender.tag==14){
        senderTag=(int)[sender tag];
        selectedBtn=14;
        [pickerView reloadAllComponents];
        pickerView.hidden=YES;
        view2.hidden=NO;
        donebtn.hidden=NO;

        [self commitAnimationPickerView];
    }

}
- (IBAction)addBtn:(id)sender {
}


-(void)commitAnimationPickerView{
    if (selectedBtn==1 || selectedBtn==2 || selectedBtn==3 || selectedBtn==4 || selectedBtn==12 || selectedBtn==14) {
        CGRect newFrame = donebtn.frame;
        newFrame.origin.y =358;
        
        [UIView animateWithDuration:0.5 animations:^{donebtn.frame=newFrame;}];
        
        CGRect nFrame = pickerView.frame;
        nFrame.origin.y = 406;
        
        [UIView animateWithDuration:0.5 animations:^{pickerView.frame=nFrame;}];
        
        CGRect n1Frame = view2.frame;
        n1Frame.origin.y = 406;
        
        [UIView animateWithDuration:0.5 animations:^{view2.frame=n1Frame;}];
    }
    else{
        CGRect newFrame =donebtn.frame;
        newFrame.origin.y=568;
        
        [UIView animateWithDuration:0.5 animations:^{donebtn.frame=newFrame;}];
        
        CGRect nFrame = pickerView.frame;
        nFrame.origin.y=616;
        
        [UIView animateWithDuration:0.5 animations:^{pickerView.frame=nFrame;}];
        
        CGRect n1Frame = view2.frame;
        n1Frame.origin.y=616;
        
        [UIView animateWithDuration:0.5 animations:^{view2.frame=n1Frame;}];
    
}
}


// picker view
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (selectedBtn==1) {
        selectedValue = [pickerDay objectAtIndex:row];
    }
    else if (selectedBtn==2) {
        selectedValue = [pickerValue objectAtIndex:row];
    }
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (selectedBtn==1) {
        return [pickerDay count];
    }
    else{
        return [pickerValue count];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (selectedBtn==1) {
        return [pickerDay objectAtIndex:row];
    }
   
    else{
        return [pickerValue objectAtIndex:row];
    }
}


- (IBAction)donebtn:(UIButton *)sender {
    NSDateFormatter *dateFormat =[[NSDateFormatter alloc]init];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"hh:mm:a"];
    NSString *str = [NSString stringWithFormat:@"      %@",[dateFormat stringFromDate:datepicker.date]];
    if (selectedBtn==3) {
        [setTime1 setTitle:str forState:normal];
        donebtn.hidden=YES;
        view2.hidden=YES;

    }
    else if (selectedBtn==4){
        [setTime2 setTitle:str forState:normal];
        donebtn.hidden=YES;
        view2.hidden=YES;
    }
    else if (selectedBtn==14){
        [setTime3 setTitle:str forState:normal];
        donebtn.hidden=YES;
        view2.hidden=YES;

    }
    else if (selectedBtn==1) {
        pickerView.hidden=YES;
        [daysbtn setTitle:selectedValue forState:normal];
        donebtn.hidden=YES;

    }
    else if (selectedBtn==2){
        pickerView.hidden=YES;
        [occurencebtn setTitle:selectedValue forState:normal];
        donebtn.hidden=YES;

    }
    
}

@end
