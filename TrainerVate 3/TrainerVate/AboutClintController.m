//
//  AboutClintController.m
//  TrainerVate
//
//  Created by Matrid on 22/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AboutClintController.h"
#define kMaxHeight 100.f


@interface AboutClintController ()

{
    UIPageControl * pageControl;
    NSArray * dataArray;
    NSArray * dataArray1;
    NSMutableArray * clientGoal;
    NSMutableArray *responseArr;
    NSMutableDictionary *tempDict;
    NSArray *clientData;
    int countScreen;
    int _lastContentOffset;
    BOOL flagRemiderService;
    BOOL flagCallDataFromServer;

}
@end

@implementation AboutClintController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"AboutClintController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"AboutClintController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"AboutClientController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"About Client Controller"];
    btnFolatSwitchVal=0;
      // allocation memory to objects
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
  
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    tblReminder.hidden=YES;
    table.hidden=YES;
    
    countScreen=1;
    clientGoal=[[NSMutableArray alloc]init];
    clientData=[[NSArray alloc]init];
   
        [self reminderData];
        [self callDataFormServer];
    
    
    dataArray=[NSArray arrayWithObjects:@"Daily body measurements",@"Weekly body measurements",@"Monthly body measurements",nil];
    
    CGRect scrollViewFrame = CGRectMake(0, 62, 320, 404);
    self.scrollVIew.frame = scrollViewFrame;
    self.scrollVIew.delegate = self;
    [self.view addSubview:self.scrollVIew];
    CGSize scrollViewContentSize = CGSizeMake(640, 404);
    [self.scrollVIew setContentSize:scrollViewContentSize];
    [self.scrollVIew setPagingEnabled:YES];
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(110,5,100,100);
    pageControl.numberOfPages = 2;
    pageControl.currentPage = 0;
    // [self.view addSubview:pageControl];
    pageControl.backgroundColor = [UIColor redColor];
    
    bluredView.hidden=YES;
    viewToHide.hidden=YES;
    _daily.layer.cornerRadius=10;
    _weekly.layer.cornerRadius=10;
    _monthly.layer.cornerRadius=10;
   
    

    
    [clientGoal removeAllObjects];
    [[SingletonClass singleton].aboutClientData removeAllObjects];
    [[SingletonClass singleton].updationValue removeAllObjects];
    [responseArr removeAllObjects];
    [tempDict removeAllObjects];
    floatingButton.frame=CGRectMake(262, 512, 40, 40);
    [floatingButton setBackgroundColor:[UIColor colorWithRed:16/255.0 green:48/255.0 blue:65/255.0 alpha:1.0]];
    floatingButton.layer.cornerRadius=floatingButton.bounds.size.height/2;
    floatingButton.layer.shadowColor = [UIColor colorWithRed:16/255.0 green:48/255.0 blue:65/255.0 alpha:1.0].CGColor;
    floatingButton.imageView.layer.cornerRadius = 3.0f;
    floatingButton.layer.shadowRadius = 5.0f;
    floatingButton.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    floatingButton.layer.shadowOpacity = 1.0f;
    [floatingButton setImage:[UIImage imageNamed:@"pen3.png"] forState:normal];
    floatingButton.layer.masksToBounds = NO;
    bluredView.frame=CGRectMake(0, 0, 320, 568);
    viewToHide.frame=CGRectMake(38, 176, 245, 216);
    [viewToHide setBackgroundColor:[UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0]];
    [self.view addSubview:floatingButton];
    [self.view addSubview:bluredView];
    [self.view addSubview:viewToHide];
   
   
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Calling data form server
-(void)callDataFormServer
{
    if (countScreen==1){
        flagCallDataFromServer=YES;

    
    // NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    NSString *urlString=urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"getClientInfo/" apiKey:[Globals apiKey]];
    NSString *uid=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid", nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                //[hudFirst hide:YES];

                clientData = [json mutableCopy];
                g_buildmuscles=[json objectForKey:@"g_buildmuscles"];
                g_endurance=[json objectForKey:@"g_endurance"];
                g_flexibility=[json objectForKey:@"g_flexibility"];
                g_lowerbody=[json objectForKey:@"g_lowerbody"];
                g_strengthen=[json objectForKey:@"g_strengthen"];
                g_tonemuscles=[json objectForKey:@"g_tonemuscles"];
                g_upperbody=[json objectForKey:@"g_upperbody"];
                g_weight=[json objectForKey:@"g_weight"];

                
                if ([g_weight isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Lose weight"];
                }
                if ([g_strengthen isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Strengthen core"];
                }
                if ([g_upperbody isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Target upper body"];
                }
                if ([g_lowerbody isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Target lower body"];
                }
                if ([g_buildmuscles isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Build muscles"];
                }
                if ([g_tonemuscles isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Tone muscles"];
                }
                if ([g_endurance isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Improve endurance"];
                }
                if ([g_flexibility isEqualToString:@"1"]) {
                    [clientGoal addObject:@"Improve flexibility"];
                }
                loopCount=1;
                table.hidden=NO;
                tblReminder.hidden=NO;
                [table reloadData];
            }
            else{
                //[hudFirst hide:YES];
                [Globals alert:[json objectForKey:@"message"]];
            }
            flagCallDataFromServer=NO;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // [hudFirst hide:YES];
        flagCallDataFromServer=NO;
        //[Globals alert:@"Something went wrong, Please try again later"];
    }];
    }
    
}

-(void)reminderData
{
    if (countScreen==1) {
        flagRemiderService=YES;
        MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hudFirst.delegate = self;
        hudFirst.labelText=@"Please wait";
        hudFirst.center=self.view.center;
        hudFirst.dimBackground=YES;
        hudFirst.removeFromSuperViewOnHide = YES;
        [hudFirst show:YES];
        
        NSString *urlString=urlString=[Globals urlCombileHash:kApiDomin2 ClassUrl:@"getReminder/" apiKey:[Globals apiKey]];
        NSString *uid=[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
        NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid", nil];
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                 options:kNilOptions error:&error];
            if (json !=nil && json.allKeys.count!=0) {
                
                if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                    [hudFirst hide:YES];
                    [responseArr removeAllObjects];
                    NSDictionary *daily_reminder;
                    NSDictionary *monthly_reminder;
                    NSDictionary *weekly_reminder;
                    
                    
                    if (responseArr==nil) {
                        responseArr=[[NSMutableArray alloc]init];
                    }
                    if (tempDict==nil) {
                        tempDict=[[NSMutableDictionary alloc]init];
                    }
                    if ([json objectForKey:@"daily_reminder"]!=nil ) {
                        daily_reminder=[json objectForKey:@"daily_reminder"];
                        [responseArr addObject:[self remove0Values:daily_reminder]];
                        [tempDict setValue:daily_reminder forKey:@"rem1"];
                        [SingletonClass singleton].aboutClientData=[tempDict mutableCopy];
                    }
                    else{
                        [responseArr addObject:[NSDictionary dictionary]];
                    }
                    if ([json objectForKey:@"weekly_reminder"]!=nil ) {
                        weekly_reminder=[json objectForKey:@"weekly_reminder"];
                        [responseArr addObject:[self remove0Values:weekly_reminder]];
                        [tempDict setValue:weekly_reminder forKey:@"rem2"];
                        [SingletonClass singleton].aboutClientData=[tempDict mutableCopy];
                        
                    }
                    else{
                        [responseArr addObject:[NSDictionary dictionary]];
                    }
                    if ([json objectForKey:@"monthly_reminder"]!=nil ) {
                        monthly_reminder=[json objectForKey:@"monthly_reminder"];
                        [responseArr addObject:[self remove0Values:monthly_reminder]];
                        [tempDict setValue:monthly_reminder forKey:@"rem3"];
                        [SingletonClass singleton].aboutClientData=[tempDict mutableCopy];
                        
                    }
                    else{
                        [responseArr addObject:[NSDictionary dictionary]];
                    }
                    loopCount=1;
                    tblReminder.hidden=NO;
                    [tblReminder reloadData];
                    
                }
                else{
                    loopCount=1;
                    tblReminder.hidden=NO;
                    [tblReminder reloadData];
                    [hudFirst hide:YES];
                    //[Globals alert:[json objectForKey:@"message"]];
                }
                flagRemiderService=NO;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [hudFirst hide:YES];
            flagRemiderService=NO;
            [Globals alert:@"Something went wrong, Please try again later"];
        }];

    }
    
}


int loopCount=1;

#pragma mark - scrolView delegates
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastContentOffset = scrollView.contentOffset.x;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.scrollVIew.frame.size.width;
    float fractionalPage = self.scrollVIew.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
    
    if (_lastContentOffset < (int)scrollView.contentOffset.x) {
        // moved right
    }
    else if (_lastContentOffset > (int)scrollView.contentOffset.x) {
        // moved left
    }
    else{
    
        return;
    }
    
  // if (reminder==1) {
    if (page==1) {
        btnFolatSwitchVal=1;
            if (!flagRemiderService) {
              // [self reminderData];
            }
            reminder.backgroundColor=[UIColor whiteColor];
            UIButton *secondBtn=(UIButton *)[self.view viewWithTag:10];
            secondBtn.backgroundColor=[UIColor colorWithRed:228/255.0  green:228/255.0  blue:228/255.0  alpha:1.0];
            loopCount++;
            countScreen=0;
            
            
        }
        else {
            btnFolatSwitchVal=0;
            if (!flagCallDataFromServer) {
                 countScreen=1;
              //  [self callDataFormServer];
               
            }
            //[self callDataFormServer];
            clientInfo.backgroundColor=[UIColor whiteColor];
            UIButton *secondBtn=(UIButton *)[self.view viewWithTag:11];
            secondBtn.backgroundColor=[UIColor colorWithRed:228/255.0  green:228/255.0  blue:228/255.0  alpha:1.0];
            pageControl.currentPage=0;
            loopCount++;
           // countScreen=0;
        }
    
 //   }

    


}

#pragma mark - tableView delegates and datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{   if(tblReminder==tableView){
    return dataArray.count;
}
else{
    return 1;
}
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tblReminder==tableView){
        if (responseArr.count==0 || responseArr.count<section+1) {
            return 1;
        }
        NSDictionary *dicCurrent=[responseArr objectAtIndex:section];
        NSArray *Allkeys=dicCurrent.allKeys;
        if (Allkeys.count%2==0) {
            return (Allkeys.count/2);
        }
        else{
            return (Allkeys.count/2)+1;
        }

        return Allkeys.count;
    }
    else
    {
        return 3;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tblReminder== tableView) {
        return 28;
    }
    else {
        if (indexPath.row==0) {
            return 217;
        }
        else if (indexPath.row==1) {
                if (clientGoal.count!=0) {
                    float height = 55+(clientGoal.count/2)*17;
                    return height+25;
                }
                return 48;
            }
        else if (indexPath.row) {
            int value = 0;
            if (clientData.count!=0) {
                UIFont *font = [UIFont fontWithName:@"Lato-Italic" size:14];
                
                CGRect rect = [[NSString stringWithFormat:@"%@",[clientData valueForKey:@"cannot_do"]] boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{NSFontAttributeName : font}
                                                 context:nil];
                
                value=value+rect.size.height+50;
                rect = [[NSString stringWithFormat:@"%@",[clientData valueForKey:@"can_do"]] boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                                                                                             options:NSStringDrawingUsesLineFragmentOrigin
                                                                                                          attributes:@{NSFontAttributeName : font}
                                                                                                             context:nil];
                
                value=value+rect.size.height+50;
                rect = [[NSString stringWithFormat:@"%@",[clientData valueForKey:@"injuries"]] boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
                                                                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                                                                       attributes:@{NSFontAttributeName : font}
                                                                                                          context:nil];
                
                value=value+rect.size.height+50;
            }
            return value+150;
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tblReminder== tableView) {
        return 44;
    }
    else
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//   table.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    table.rowHeight = UITableViewAutomaticDimension;
    if (tblReminder==tableView) {
        static NSString *simpleTable=@"simpleTableCell";
        aboutClientCusromCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
        if (cell==nil) {
            NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"aboutClientCusromCell" owner:self options:nil];
            cell=[data objectAtIndex:0];
        }
        NSMutableDictionary * CurrentDic=[responseArr objectAtIndex:indexPath.section];
        NSArray *allKeys=CurrentDic.allKeys;
        
        if (CurrentDic==nil && CurrentDic.count==0) {
            cell.lbl3.text=@"No reminders!";
            cell.lbl1.hidden = YES;
            cell.lab2.hidden = YES;
        }
        else {
            cell.lbl1.adjustsFontSizeToFitWidth = YES;
            cell.lab2.adjustsFontSizeToFitWidth = YES;
            if (allKeys.count%2!=0 && allKeys.count/2==indexPath.row) {
                cell.lbl1.text=[Globals DictonaryValuesForKeys:[allKeys objectAtIndex:allKeys.count-1]];
                cell.lab2.text=@"";
                return cell;
            }
            cell.lbl1.text=[Globals DictonaryValuesForKeys:[allKeys objectAtIndex:indexPath.row]];
            cell.lab2.text=[Globals DictonaryValuesForKeys:[allKeys objectAtIndex:indexPath.row+allKeys.count/2]];
            cell.lbl3.hidden=YES;
        }
        return cell;
    }
    static NSString *simpleTable=@"simpleTableCell1";
    static NSString *simpleCell=@"simpleTableCell2";
    static NSString *tableCell=@"simpleTableCell3";
    if (clientData.count==0) {
        aboutGoals *cell=[tableView dequeueReusableCellWithIdentifier:simpleCell];
        if (cell==nil) {
            NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"aboutGoals" owner:self options:nil];
            cell=[data objectAtIndex:0];
        }
        return cell;
    }
    
    if (indexPath.row==0) {
        aboutHeader *cell=[tableView dequeueReusableCellWithIdentifier:simpleTable];
        if (cell==nil) {
            NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"aboutHeader" owner:self options:nil];
            cell=[data objectAtIndex:0];
        }
        cell.lbl1.layer.masksToBounds = YES;
        cell.lbl1.layer.cornerRadius=cell.lbl1.bounds.size.height/2;
        cell.lbl2.layer.masksToBounds = YES;
        cell.lbl2.layer.cornerRadius=cell.lbl2.bounds.size.height/2;
        cell.lbl3.layer.masksToBounds = YES;
        cell.lbl3.layer.cornerRadius=cell.lbl3.bounds.size.height/2;
        
        cell.lblName.text=[clientData valueForKey:@"name"];
        cell.lblAge.text=[clientData valueForKey:@"age"];
        cell.lblEmail.text=[clientData valueForKey:@"email"];
        if ([[clientData valueForKey:@"gender"] isEqualToString:@"m" ] || [[clientData valueForKey:@"gender"] isEqualToString:@"M"]) {
            cell.lblSex.text=@"M";
        }
        if ([[clientData valueForKey:@"gender"] isEqualToString:@"f"] || [[clientData valueForKey:@"gender"] isEqualToString:@"F"]) {
            cell.lblSex.text=@"F";
        }
        return cell;
    }
    else if (indexPath.row==1) {
        aboutGoals *cell=[tableView dequeueReusableCellWithIdentifier:simpleCell];
        if (cell==nil) {
            NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"aboutGoals" owner:self options:nil];
            cell=[data objectAtIndex:0];
        }

        if (clientGoal.count==0) {
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(60, 25, 205, 21)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:@"No information available yet!"];
            [cell addSubview:goal1];
        }
        int yAxis=10;
        int XAxis=29;
        for (int i=0; i<clientGoal.count; i++) {
            if (i%2==0) {
                yAxis=yAxis+25;
                XAxis=16;
            }
            else {
                XAxis=159;
            }
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(XAxis, yAxis, 120, 21)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Regular" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:[NSString stringWithFormat:@"%@",[clientGoal objectAtIndex:i]]];
            [cell addSubview:goal1];
        }
        return cell;

    }
    else {
        aboutFooter *cell=[tableView dequeueReusableCellWithIdentifier:tableCell];
        if (cell==nil) {
            NSArray *data=[[NSBundle mainBundle]loadNibNamed:@"aboutFooter" owner:self options:nil];
            cell=[data objectAtIndex:0];
        }
        
        UILabel *height=[[UILabel alloc]initWithFrame:CGRectMake(239, 10, 47, 21)];
        [height setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [height setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [height setText:[NSString stringWithFormat:@"%@",[clientData valueForKey:@"height"]]];
        
        UILabel *weight=[[UILabel alloc]initWithFrame:CGRectMake(239, 47, 47, 21)];
        [weight setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [weight setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [weight setText:[NSString stringWithFormat:@"%@",[clientData valueForKey:@"weight"]]];
        
        //injuries
        UILabel *injuries=[[UILabel alloc]initWithFrame:CGRectMake(16, 92+5, 47, 21)];
        [injuries setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [injuries setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [injuries setText:@"Injuries:"];
        
        CGSize temp = [[clientData valueForKey:@"injuries"] sizeWithAttributes:
                       @{NSFontAttributeName:
                             [UIFont fontWithName:@"Lato-Regular" size:14]}];
        
        UILabel *injuriesTxt = [[UILabel alloc]initWithFrame:CGRectMake(16, injuries.frame.origin.y+18+10, 289, temp.height+10)];
        injuriesTxt.text = [NSString stringWithFormat:@"%@",[clientData valueForKey:@"injuries"]];
        [injuriesTxt setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        injuriesTxt.lineBreakMode = NSLineBreakByWordWrapping;
        injuriesTxt.numberOfLines = 0;
        injuriesTxt.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
        injuriesTxt.adjustsFontSizeToFitWidth = YES;
        injuriesTxt.adjustsLetterSpacingToFitWidth = YES;
        injuriesTxt.minimumScaleFactor = 10.0f/12.0f;
        injuriesTxt.clipsToBounds = YES;
        injuriesTxt.textColor = [UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0];
        [injuriesTxt sizeToFit];
        injuriesTxt.textAlignment = NSTextAlignmentLeft;
        
        //cando
        UILabel *canDo=[[UILabel alloc]initWithFrame:CGRectMake(16, injuriesTxt.frame.origin.y+injuriesTxt.frame.size.height+10+18, 55, 21)];
        [canDo setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [canDo setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [canDo setText:@"Can Do:"];
        temp = [[clientData valueForKey:@"can_do"] sizeWithAttributes:
                @{NSFontAttributeName:
                      [UIFont fontWithName:@"Lato-Regular" size:14]}];
        
        UILabel *canDoTxt=[[UILabel alloc]initWithFrame:CGRectMake(12, canDo.frame.origin.y+18+10, 289, temp.height+10)];
        [canDoTxt setUserInteractionEnabled:NO];
        canDoTxt.lineBreakMode = NSLineBreakByWordWrapping;
        canDoTxt.numberOfLines = 0;
        [canDoTxt setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [canDoTxt setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [canDoTxt setText:[NSString stringWithFormat:@"%@",[clientData valueForKey:@"can_do"]]];
        [canDoTxt sizeToFit];
        
        //cantDo
        UILabel *cantDo=[[UILabel alloc]initWithFrame:CGRectMake(16, canDoTxt.frame.origin.y+canDoTxt.frame.size.height+15+15, 55, 21)];
        [cantDo setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [cantDo setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [cantDo setText:@"Can't Do:"];
        temp = [[clientData valueForKey:@"cannot_do"] sizeWithAttributes:
                @{NSFontAttributeName:
                      [UIFont fontWithName:@"Lato-Regular" size:14]}];
        
        UILabel *cantDoTxt=[[UILabel alloc]initWithFrame:CGRectMake(12, cantDo.frame.origin.y+18+10, 289, temp.height+10)];
        [cantDoTxt setUserInteractionEnabled:NO];
        [cantDoTxt setUserInteractionEnabled:NO];
        cantDoTxt.lineBreakMode = NSLineBreakByWordWrapping;
        cantDoTxt.numberOfLines = 0;
        [cantDoTxt setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
        [cantDoTxt setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        [cantDoTxt setText:[NSString stringWithFormat:@"%@",[clientData valueForKey:@"cannot_do"]]];
        [cantDoTxt sizeToFit];

        if ([[clientData valueForKey:@"injuries"] isEqualToString:@"0"] || [[clientData valueForKey:@"injuries"] isEqual:[NSNull null]]) {
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(34, injuries.frame.origin.y+18+5, 215, temp.height+10)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:@"No information available yet!"];
            [cell addSubview:goal1];
        }
        else {
            
            [cell addSubview:injuriesTxt];
        }
        if ([[clientData valueForKey:@"cannot_do"] isEqualToString:@"0"] || [[clientData valueForKey:@"cannot_do"] isEqual:[NSNull null]]) {
            [cantDoTxt setFrame:CGRectMake(34, canDoTxt.frame.origin.y+canDoTxt.frame.size.height+10, 55, 21)];
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(34, cantDo.frame.origin.y+18, 215, temp.height+10)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:@"No information available yet!"];
            [cell addSubview:goal1];
        
        }
        else {
            [cell addSubview:cantDoTxt];
        }
        if ([[clientData valueForKey:@"can_do"] isEqualToString:@"0"] || [[clientData valueForKey:@"can_do"] isEqual:[NSNull null]]) {
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(34, canDo.frame.origin.y+18, 215, temp.height+10)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:@"No information available yet!"];
            [cell addSubview:goal1];
        }
        else {
            [cell addSubview:canDoTxt];
        }
        if ([[clientData valueForKey:@"height"] isEqualToString:@"0"] || [[clientData valueForKey:@"height"] isEqual:[NSNull null]]) {
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(34, canDo.frame.origin.y+18, 215, temp.height+10)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:@"No information available yet!"];
            [cell addSubview:goal1];
        }
        else {
            [cell addSubview:height];
        }
        if ([[clientData valueForKey:@"weight"] isEqualToString:@"0"] || [[clientData valueForKey:@"weight"] isEqual:[NSNull null]]) {
            UILabel *goal1=[[UILabel alloc]initWithFrame:CGRectMake(34, canDo.frame.origin.y+18, 215, temp.height+10)];
            [goal1 setFont:[UIFont fontWithName:@"Lato-Italic" size:14]];
            [goal1 setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
            [goal1 setText:@"No information available yet!"];
            [cell addSubview:goal1];
        }
        else {
            [cell addSubview:weight];
        }
        [cell addSubview:injuries];
        [cell addSubview:canDo];
        [cell addSubview:cantDo];
        [cell sizeToFit];
        return cell;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tblReminder== tableView){
        UIView *views1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tblReminder.frame.size.width,21)];
        [views1 setBackgroundColor: [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(26,10, tblReminder.frame.size.width,21)];
        label.text=[dataArray objectAtIndex:section];
        label.textColor=[UIColor colorWithRed:16.0/255.0 green:48.0/255.0 blue:65.0/255.0 alpha:1.0];
        label.font=[UIFont fontWithName:@"Lato-Italic" size:18.0];

        
        [views1 addSubview:label];
        return views1;
    }
    else{
        return nil;
    }
    
}

#pragma mark - IBActions
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)TopBtns:(UIButton *)sender {
    if (sender.tag==10) {
        btnFolatSwitchVal=0;
        sender.backgroundColor=[UIColor whiteColor];
        UIButton *secondBtn=(UIButton *)[self.view viewWithTag:11];
        secondBtn.backgroundColor=[UIColor colorWithRed:228/255.0  green:228/255.0  blue:228/255.0  alpha:1.0];
        pageControl.currentPage=0;
       // [self callDataFormServer];
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollVIew.contentOffset=CGPointMake(0, 0);
        }];
    }
    else
    {   btnFolatSwitchVal=1;
        sender.backgroundColor=[UIColor whiteColor];
        UIButton *secondBtn=(UIButton *)[self.view viewWithTag:10];
        secondBtn.backgroundColor=[UIColor colorWithRed:228/255.0  green:228/255.0  blue:228/255.0  alpha:1.0];
        if (loopCount==1) {
       // [self reminderData];
        }
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollVIew.contentOffset=CGPointMake(320, 0);
        }];
        
        
    }
    
}
-(NSMutableDictionary *)remove0Values :(NSDictionary *)dic {
    NSLog(@"start for");
    NSMutableDictionary *currentDic=[dic mutableCopy];
    NSArray *keys=currentDic.allKeys;
    NSArray *values=currentDic.allValues;
    for (int i=0; i<keys.count; i++) {
        if ([[values objectAtIndex:i] intValue]==0) {
            [currentDic removeObjectForKey:[keys objectAtIndex:i]];
        }
    }
    return currentDic;
}
- (IBAction)btnCancel:(id)sender {
    
    bluredView.hidden=YES;
    viewToHide.hidden=YES;
    
}
int btnFolatSwitchVal;
- (IBAction)floatingButton:(id)sender {
    if (btnFolatSwitchVal==1 || pageControl.currentPage==1) {
    viewToHide.hidden=NO;
    bluredView.hidden=NO;
    }
    else{
        tempDict=[[NSMutableDictionary alloc]init];
        
        aboutClientInfoUpdationViewController *update=[[aboutClientInfoUpdationViewController alloc]init];
        update.basicInfo=[clientData mutableCopy];
        [self.navigationController pushViewController:update animated:YES];
    }
}
- (IBAction)daily:(id)sender {
    SetReminderController *rem1=[[SetReminderController alloc]init];
    [self.navigationController pushViewController:rem1 animated:YES];
    
}

- (IBAction)weekly:(id)sender {
    SetReminderController2 *rem1=[[SetReminderController2 alloc]init];
    [self.navigationController pushViewController:rem1 animated:YES];
}

- (IBAction)monthly:(id)sender {
    SetReminderController3 *rem1=[[SetReminderController3 alloc]init];
    [self.navigationController pushViewController:rem1 animated:YES];
}

@end
