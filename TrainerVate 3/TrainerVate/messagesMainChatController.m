//
//  ViewController.m
//  messge chat
//
//  Created by Pankaj Khatri on 12/08/15.
//  Copyright (c) 2015 Pankaj Khatri. All rights reserved.
//

#import "messagesMainChatController.h"
#import "Constants.h"
#import "ClientChatCell.h"
#import "trainerChatCell.h"
#import "UpdateTrainnerController.h"
#import "PTSMessagingCell.h"
#import "MessageComposerView.h"
//#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
//#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))


@interface messagesMainChatController (){
    NSMutableArray  *messagesArray ;
    NSTimer *updateTheMessages;
    MBProgressHUD *  hudFirst;
    NSString *userPic;
    NSString *usrImage;
    NSTimer *timer;
    BOOL isAnimate;
    UITableView *tabMessageController;
}

@end

@implementation messagesMainChatController
@synthesize tabBarController,clientImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IS_IPHONE_5_OR_MORE) {
        tabMessageController=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 427)];
    }
    else {
        tabMessageController=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 339)];
    }
    tabMessageController.delegate=self;
    tabMessageController.dataSource=self;
    [tabMessageController setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollMessages addSubview:tabMessageController];
    //[self.view bringSubviewToFront:tabMessageController];
       messagesArray=[NSMutableArray array];
  //  [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(trainerGetMessages) userInfo:nil repeats:YES];
   // txtMsgView.delegate = self;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTapped)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:recognizer];
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
   timer=  [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(trainerGetMessages) userInfo:nil repeats:YES];
    self.messageComposerView = [[MessageComposerView alloc] init];
    CGRect frame=self.messageComposerView.frame;
    frame.size.height=56;
    self.messageComposerView.frame=frame;
    self.messageComposerView.delegate = self;
    self.messageComposerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.messageComposerView];
    userPic=[[NSUserDefaults standardUserDefaults]objectForKey:@"userPic"];
    if (userPic!=nil) {
        usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",userPic];
        [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:usrImage]];
        
    }
    isAnimate=NO;

}

- (void)viewWillAppear:(BOOL)animated {
    
    [tabMessageController setContentOffset:CGPointMake(0, tabMessageController.contentSize.height - tabMessageController.frame.size.height)];
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    [self trainerGetMessages];
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [super viewWillAppear:animated];
  
}

- (void)viewWillDisappear:(BOOL)animated
{
   
    [timer invalidate];
    timer = nil;
    
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
;
}

//////view end.....................................


-(void)touchTapped{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- table view delegate and datasource method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return messagesArray.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize messageSize = [PTSMessagingCell messageSize:[[messagesArray objectAtIndex:indexPath.row] valueForKey:@"message"]];
    return messageSize.height + 2*[PTSMessagingCell textMarginVertical] + 40.0f;
}

- (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *currentMessageDic=[messagesArray objectAtIndex:indexPath.row];
//    if ([[currentMessageDic objectForKey:@"user_sent"] intValue]==0) {
//    static NSString *simpleTable1=@"simpleTableCell1";
//        if ([[currentMessageDic objectForKey:@"imageFlag"] intValue]==1) {
//            trainerImageCell *cellImg= [tableView dequeueReusableCellWithIdentifier:simpleTable1];
//            if (cellImg==nil) {
//                NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"trainerImageCell" owner:self options:nil ];
//                cellImg= [data objectAtIndex:0];
//            }
//            
//            cellImg.imageView.image=[self decodeBase64ToImage:[currentMessageDic objectForKey:@"image"]];
//            cellImg.contentMode = UIViewContentModeScaleAspectFit;
//            return cellImg;
//            
//        }
//        
//        
//    trainerChatCell *cell1= [tableView dequeueReusableCellWithIdentifier:simpleTable1];
//    if (cell1==nil) {
//        NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"trainerChatCell" owner:self options:nil ];
//        cell1= [data objectAtIndex:0];
//    }
//        
//        
//        cell1.userImage.image= [UIImage imageNamed:@"default5.jpeg"];
//        cell1.userImage.layer.cornerRadius=cell1.userImage.bounds.size.width/2;
//        cell1.message.text=[currentMessageDic objectForKey:@"message"];
//     
//        CGSize labelSize = [self findHeightForText:[currentMessageDic objectForKey:@"message"] havingWidth:255 andFont:[UIFont systemFontOfSize:16]];
//       
//            dispatch_async(dispatch_get_main_queue(), ^{
//                  if (labelSize.height>50) {
//                      cell1.message.frame = CGRectMake(
//                                                       cell1.message.frame.origin.x, cell1.message.frame.origin.y,
//                                                       cell1.message.frame.size.width, labelSize.height);
//                      cell1.imgBackground.frame = CGRectMake(
//                                                             cell1.imgBackground.frame.origin.x, cell1.imgBackground.frame.origin.y,
//                                                             cell1.imgBackground.frame.size.width, labelSize.height);
//                }
//                  else{
//                      cell1.message.frame = CGRectMake(
//                                                       cell1.message.frame.origin.x, cell1.message.frame.origin.y,
//                                                       cell1.message.frame.size.width, labelSize.height);
//                      cell1.imgBackground.frame = CGRectMake(
//                                                             cell1.imgBackground.frame.origin.x, cell1.imgBackground.frame.origin.y,
//                                                             cell1.imgBackground.frame.size.width, cell1.imgBackground.frame.size.height);
//                  }
//            });
//        
//        return cell1;
//    }
//    
//    else{
//        
//    static NSString *simpleTable=@"simpleTableCell";
//    ClientChatCell *cell= [tableView dequeueReusableCellWithIdentifier:simpleTable];
//    if (cell==nil) {
//        NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"ClientChatCell" owner:self options:nil ];
//        cell= [data objectAtIndex:0];
//    }
//        cell.userImage.image= [UIImage imageNamed:@"imgPc.jpeg"];
//    
//       cell.message.text=[currentMessageDic objectForKey:@"message"];
//        
//       CGSize labelSize = [self findHeightForText:[currentMessageDic objectForKey:@"message"] havingWidth:255 andFont:[UIFont systemFontOfSize:16]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (labelSize.height>50) {
//                                                 cell.message.frame = CGRectMake(
//                                                                                 cell.message.frame.origin.x, cell.message.frame.origin.y,
//                                                                                 cell.message.frame.size.width, labelSize.height);
//                cell.imgBackground.frame = CGRectMake(
//                                                       cell.imgBackground.frame.origin.x, cell.imgBackground.frame.origin.y,
//                                                       cell.imgBackground.frame.size.width, labelSize.height);
//            }
//            else{
//                cell.message.frame = CGRectMake(
//                                                 cell.message.frame.origin.x, cell.message.frame.origin.y,
//                                                 cell.message.frame.size.width, labelSize.height);
//                cell.imgBackground.frame = CGRectMake(
//                                                       cell.imgBackground.frame.origin.x, cell.imgBackground.frame.origin.y,
//                                                       cell.imgBackground.frame.size.width, cell.imgBackground.frame.size.height);
//            }
//        });
//
//
//    return cell;
//}
//
//}

/////////////////////table view method end...............................

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*This method sets up the table-view.*/
    
    static NSString* cellIdentifier = @"messagingCell";
    
    PTSMessagingCell * cell = (PTSMessagingCell*) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell == nil) {
        cell = [[PTSMessagingCell alloc] initMessagingCellWithReuseIdentifier:cellIdentifier];
    }
    cell.userImage.layer.masksToBounds = YES;
    cell.userImage.layer.cornerRadius = 25.0;
    [self configureCell:cell atIndexPath:indexPath];
//    cell.messageLabel.text=txtMsgView.text;
    return cell;
}
-(void)configureCell:(id)cell atIndexPath:(NSIndexPath *)indexPath {
    PTSMessagingCell* ccell = (PTSMessagingCell*)cell;
    ccell.userImage.image=[UIImage imageNamed:@"default4.png"];
    ccell.avatarImageView.image = [UIImage imageNamed:@"sign_circle.png"];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
        if ([[[messagesArray objectAtIndex:indexPath.row] valueForKey:@"user_sent"] isEqualToString:@"0"]) {
            ccell.sent = YES;
            if (userPic==nil || [userPic isEqual:[NSNull null] ] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"null"]) {
                ccell.userImage.image=[UIImage imageNamed:@"default8.png"];
            }
            else{
                ccell.userImage.image=[Globals getImagesFromCache:usrImage];
            }
        }
        else {
            ccell.sent = NO;
            if (clientImage==nil || [clientImage isEqual:[NSNull null] ] || [clientImage isEqualToString:@"NULL"] || [clientImage isEqualToString:@""] || [clientImage isEqualToString:@"null"]) {
                ccell.userImage.image=[UIImage imageNamed:@"default8.png"];
            }
            else{
                ccell.userImage.image = [Globals getImagesFromCache:clientImage];
            }
            
        }
    }
    else {
        if ([[[messagesArray objectAtIndex:indexPath.row] valueForKey:@"user_sent"] isEqualToString:@"1"]) {
            ccell.sent = YES;
            if (userPic==nil || [userPic isEqual:[NSNull null] ] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"null"]) {

                ccell.userImage.image=[UIImage imageNamed:@"default8.png"];
            }
            else{
                ccell.userImage.image=[Globals getImagesFromCache:usrImage];
            }
        } else {
            ccell.sent = NO;
            ccell.avatarImageView.image = [UIImage imageNamed:@"sign_circle.png"];
        }
    }
    ccell.messageLabel.text = [[messagesArray objectAtIndex:indexPath.row] valueForKey:@"message"];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}


#pragma nuttons action*******************************************************************

- (void)messageComposerSendMessageClickedWithMessage:(NSString*)message{
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:hudFirst];
    // if ([txtMsgView.text isEqualToString:@""]) {
    //     return;
    // }
    NSMutableDictionary *sendig=[NSMutableDictionary dictionary];
    // [sendig setObject:txtMsgView.text forKey:@"message"];
    [sendig setObject:@"0" forKey:@"user_sent"];
    [messagesArray addObject:sendig];
    
    //[messagesArray addObject:txtMsgView.text];
    
 
    message = [message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [self trainerSendMessages:message];
    [self.view endEditing:YES];
}

//- (IBAction)SendBtn:(UIButton *)sender {
//    [self.view endEditing:YES];
//    [self.view bringSubviewToFront:hudFirst];
//   // if ([txtMsgView.text isEqualToString:@""]) {
//   //     return;
//   // }
//    NSMutableDictionary *sendig=[NSMutableDictionary dictionary];
//   // [sendig setObject:txtMsgView.text forKey:@"message"];
//    [sendig setObject:@"0" forKey:@"user_sent"];
//    [messagesArray addObject:sendig];
//    
//    //[messagesArray addObject:txtMsgView.text];
//   // [self trainerSendMessages:txtMsgView.text];
//    [self.view endEditing:YES];
//    //[self performSelectorOnMainThread:@selector(generateTheMessageCustom) withObject:nil waitUntilDone:2.5];
//}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#define kOFFSET_FOR_KEYBOARD 80.0
#pragma mark- setting keyboard check view rect*******************************************

- (void)keyboardDidShow: (NSNotification *) notif {
    
    [self.view sendSubviewToBack:_scrollMessages];
    [self setScrollviewOffset];
    CGRect frame=_headderView.frame;
    frame.origin.y=0;
    _headderView.frame=frame;
    _scrollMessages.scrollEnabled = YES;
    
    
}


- (void)keyboardDidHide: (NSNotification *) notif {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    CGRect frame=_headderView.frame;
    frame.origin.y=0;
    _headderView.frame=frame;
    _scrollMessages.scrollEnabled = NO;
    
    
    
    [self.view setNeedsDisplay];
    [UIView commitAnimations];
}
- (void)setScrollviewOffset {
    
    if (IS_IPHONE_4_OR_LESS) {
        _scrollMessages.contentSize = CGSizeMake(_scrollMessages.frame.size.width,370);
    }
    else
    {
        _scrollMessages.contentSize = CGSizeMake(_scrollMessages.frame.size.width, 450);
    }
}



#pragma chat api**************************************************************

- (void)trainerSendMessages:(NSString *)Message {
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    NSString *urlString;
    NSString *uid;
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
        urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrltrainerSendMessages apiKey:[Globals apiKey]];
        uid=[[SingletonClass singleton].clientInfo objectForKey:@"uidMessage"];
    }
    else {
        urlString=[Globals urlCombileHash:kApiDomin ClassUrl:@"clientsendmessage/" apiKey:[Globals apiKey]];
        uid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    }
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",Message,@"message", nil];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSMutableDictionary* json = [[NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error] mutableCopy];
        if (json !=nil && json.allKeys.count!=0){
            NSString *stats = [json objectForKey:@"status_code"];
            if ([stats isEqualToString:@"SUCCESS"]) {
                [hudFirst hide:YES];
                [self trainerGetMessages];
            }
            else{
                [messagesArray removeLastObject];
                [tabMessageController reloadData];
                [Globals alert:@"message not sent"];
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
    }];
}

- (void)trainerGetMessages {
    
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:@"getmessages/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionary];
    NSString *uid;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"1"]) {
        uid=[[SingletonClass singleton].clientInfo objectForKey:@"uidMessage"];
        inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid", nil];
    }
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSMutableDictionary* json = [[NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error] mutableCopy];
        if (json !=nil && json.allKeys.count!=0){
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                messagesArray=[[json objectForKey:@"returnset"] mutableCopy];
                [tabMessageController reloadData];
                [tabMessageController scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messagesArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:isAnimate];
                isAnimate=YES;
                [hudFirst hide:YES];
            }
            else{
                if ([[json objectForKey:@"status_code"] isEqualToString:@"EMPTY"]) {
                    [messagesArray removeAllObjects];
                }
                [tabMessageController reloadData];
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        
        ;
    }];
    
}


@end
