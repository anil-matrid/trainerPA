//
//  DatePickerController.m
//  TrainerVate
//
//  Created by Matrid on 31/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DatePickerController.h"

@interface DatePickerController ()
{
    UIDatePicker *datePikers;
}
@end

@implementation DatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
       //UIDatePicker *datePikers=[[UIDatePicker alloc]init];
    datePicker.datePickerMode=UIDatePickerModeTime;
        [datePicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];

    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Date" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert setValue:datePicker forKey:@"accessoryView"];
    [alert show];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)pickerChanged:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    
    // populate the text field with new date
    lblTimeShow.text =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[datePicker date]]];
    [dateFormatter stringFromDate:datePicker.date];
    
   // lblTimeShow.text=[NSString stringWithFormat:@"%@",[datePicker date]];
    NSLog(@"value: %@",[sender date]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
