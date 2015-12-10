//
//  ViewController.h
//  messge chat
//
//  Created by Pankaj Khatri on 12/08/15.
//  Copyright (c) 2015 Pankaj Khatri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "WhiteRaccoon.h"
#import "MBProgressHUD.h"
#import "MessageComposerView.h"


@interface messagesMainChatController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,MBProgressHUDDelegate,UITextViewDelegate,MessageComposerViewDelegate>

@property (nonatomic, strong) MessageComposerView *messageComposerView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMessages;
//@property (weak, nonatomic) IBOutlet UITableView *tabMessageController;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *navigationBar;
@property (weak, nonatomic) IBOutlet UIView *headderView;
@property (strong, nonatomic) NSString *clientImage;
@property (nonatomic, retain) UITabBarController* tabBarController;


@end
