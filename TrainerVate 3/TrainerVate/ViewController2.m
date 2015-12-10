//
//  ViewController.m
//  messge chat
//
//  Created by Pankaj Khatri on 12/08/15.
//  Copyright (c) 2015 Pankaj Khatri. All rights reserved.
//

#import "ViewController.h"
#import "trainerCustomChatCell.h"
#import "clientCustomChatCell.h"


@interface ViewController (){
    NSMutableArray  *messagesArray ;
    NSArray *randomArray;
    int msgID;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabMessageController.estimatedRowHeight = 70.0; // for example. Set your average height
    self.tabMessageController.rowHeight = UITableViewAutomaticDimension;
    msgID=0;
    messagesArray=[NSMutableArray array];
    randomArray=[NSArray arrayWithObjects:@"Hello",@"How are you",@"where are you from",@"what are you talking about",@"i am form delhi",@"i like what you are talking",@"i understand",@"not bad",@"Great job",@"Not that good",@"it could be better", nil];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTapped)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer];
    [self generateTheMessageCustom];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)generateTheMessageCustom
{
    int randNum ;
    if (messagesArray.count==0) {
        randNum=0;
    }
    else
    {
        randNum = rand() % 10;
    }
    

    NSDate *date=[NSDate date];
   
    NSDictionary *userDic=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:msgID],@"msgId",[randomArray objectAtIndex:randNum],@"message",date,@"time",@"0",@"isSender",nil];
    [messagesArray addObject:userDic];
    msgID++;
     [self.tabMessageController reloadData];
    [self moveTableToBottom];

}
-(void)touchTapped{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- table view delegate and datasource method

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messagesArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *CurrentDic=[messagesArray objectAtIndex:indexPath.row];
    
    if ([[CurrentDic objectForKey:@"isSender"] intValue]==1) {
    static NSString *simpleTable1=@"simpleTableCell1";
    clientCustomChatCell *cell1= [tableView dequeueReusableCellWithIdentifier:simpleTable1];

    if (cell1==nil) {
        NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"clientCustomChatCell" owner:self options:nil ];
        cell1= [data objectAtIndex:0];
    }
        
    cell1.userImage.image= [UIImage imageNamed:@"womanPc.jpeg"];
    cell1.message.text=[CurrentDic objectForKey:@"message"];
        
        return cell1;
    }
    
    else{
        
        static NSString *simpleTable=@"simpleTableCell";
    trainerCustomChatCell *cell= [tableView dequeueReusableCellWithIdentifier:simpleTable];
    if (cell==nil) {
        NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"trainerCustomChatCell" owner:self options:nil ];
        cell= [data objectAtIndex:0];
    }
        cell.userImage.image= [UIImage imageNamed:@"imgPc.jpeg"];
        cell.message.text=[CurrentDic objectForKey:@"message"];

    return cell;
}

}

- (IBAction)SendBtn:(UIButton *)sender {
    
     NSDate *date=[NSDate date];
    NSDictionary *userDic=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:msgID],@"msgId",txtMsgView.text,@"message",date,@"time",@"1",@"isSender",nil];
    [messagesArray addObject:userDic];
    msgID++;
    [self.tabMessageController reloadData];
    txtMsgView.text=@"";
    [self performSelector:@selector(generateTheMessageCustom) withObject:nil afterDelay:1.0];
    [self moveTableToBottom];
    //[self performSelectorOnMainThread:@selector(generateTheMessageCustom) withObject:nil waitUntilDone:2.5];
}
#define kOFFSET_FOR_KEYBOARD 80.0
#pragma mark- setting keyboard check view rect
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
   
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    
}
#pragma mark- setting keyboard updown rect
//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD+108;
        rect.size.height += kOFFSET_FOR_KEYBOARD-108;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD+108;
        rect.size.height -= kOFFSET_FOR_KEYBOARD-108;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
#pragma mark- Class helper objects
-(void)moveTableToBottom
{
//    CGPoint offset = CGPointMake(0, self.tabMessageController.contentSize.height);
//            [self.tabMessageController setContentOffset:offset animated:YES];
    
//    if (self.tabMessageController.contentSize.height > self.tabMessageController.frame.size.height)
//    {
//        CGPoint offset = CGPointMake(0, self.tabMessageController.contentSize.height -     self.tabMessageController.frame.size.height);
//        [self.tabMessageController setContentOffset:offset animated:YES];
//    }
}


@end
