//
//  ViewController.h
//  messge chat
//
//  Created by Pankaj Khatri on 12/08/15.
//  Copyright (c) 2015 Pankaj Khatri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITextView *txtMsgView;
    IBOutlet UIView *msgBgView;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tabMessageController;
- (IBAction)SendBtn:(UIButton *)sender;

@end
