//
//  DatePickerController.h
//  TrainerVate
//
//  Created by Matrid on 31/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerController : UIViewController<UIPickerViewDelegate>
{
    IBOutlet UIDatePicker *datePicker;
    __weak IBOutlet UILabel *lblTimeShow;
}


@end
