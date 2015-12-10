//
//  MyClientController.m
//  TrainerVate
//
//  Created by Matrid on 30/06/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "MyClientController.h"
#import "workoutController.h"


@interface MyClientController () {
    
        NSArray *MenuItems;
        NSArray *imaGes;
        int selectedUser;   // store the value of selected user
        NSString *name;
        NSUserDefaults *defaults;
        NSString *str;
        UIView *views1;
        NSArray *clientsName;
        NSString *currentClientName;
    NSMutableArray *userImage;
    NSString *clientImage;
 }

@end

@implementation MyClientController
@synthesize client;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"MyClientController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"MyClientController" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"MyClientController_4" bundle:nibBundleOrNil];
    }
    return self;
}
int std;

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"My Client Controller"];
    // Do any additional setup after loading the view from its nib.
     [rightMenuBtn addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

    selectedUser=-1;

    defaults=[[NSUserDefaults alloc]init];
    MenuItems=[NSArray arrayWithObjects:@"WORKOUT_PLANS",@"DIET_PLANS",@"STATICS",@"RECOMMEND_UPPLIMENTS",@"APPOINTMENTS",@"ABOUT_CLIENTS", nil];
    
        imaGes=[NSArray arrayWithObjects:@"newicon1.png",@"newicon2.png",@"newicon3.png",@"newicon4.png",@"newicon5.png",@"newicon6.png",nil];
    client.hidden=YES;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self callDataFormServer];
    _errorView.hidden=YES;
   
}
#pragma mark- table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
_ret:
    if (section==selectedUser) {
        return 6;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    CustomCellMyClient *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        NSArray *mArray=[[NSBundle mainBundle]loadNibNamed:@"CustomCellMyClient" owner:self options:nil];
        cell=[mArray objectAtIndex:0];
    }
    
    cell.cellLabel.text=[MenuItems objectAtIndex:indexPath.row];//[[NSBundle mainBundle] localizedStringForKey:[MenuItems objectAtIndex:indexPath.row] value:@"" table:nil];
    cell.cellImage.image=[UIImage imageNamed:[imaGes objectAtIndex:indexPath.row]];
    UILabel *lbl=[[UILabel alloc]init];
    [cell addSubview:lbl];
   return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [SingletonClass singleton].MyClientDetail.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 81;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==selectedUser) {
        return 0.1;
    }
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==1) {
    DietPlanController *diet=[[DietPlanController alloc]init];
    [self.navigationController pushViewController:diet animated:YES];
    }
    if (indexPath.row==2) {
        MyStats *stats=[[MyStats alloc]init];
        [self.navigationController pushViewController:stats animated:YES];
    }
    if (indexPath.row==5) {
        AboutClintController *clientInfo=[[AboutClintController alloc]init];
        [self.navigationController pushViewController:clientInfo animated:YES];
    }
    if (indexPath.row==3) {
        recommend *reco=[[recommend alloc]init];
        [self.navigationController pushViewController:reco animated:YES];
    }
    if (indexPath.row==0) {
        workoutController *reco=[[workoutController alloc]init];
        reco.headerName=currentClientName;
        [self.navigationController pushViewController:reco animated:YES];
    }
    if (indexPath.row==4) {
        calenderViewController *reco=[[calenderViewController alloc]init];
        
        NSString *string =[clientsName objectAtIndex:indexPath.section];
        
        [[NSUserDefaults standardUserDefaults]setObject:string forKey:@"name"];
        //reco.headerName=currentClientName;
        [self.navigationController pushViewController:reco animated:YES];
    }



}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    [client setEditing:editing animated:animated];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
     views1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,2)];
    [views1 setBackgroundColor: [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1.0f]];
    return views1;
   
}
int Drop=0;
- (void)userSelclected:(UIButton *)senderBtn {
 
    currentClientName=[clientsName objectAtIndex:(int)senderBtn.tag];
    
    if (selectedUser==(int)senderBtn.tag) {
        selectedUser=-1;
         Drop=0;
        [client reloadData];
        return;
    }
    if (Drop==0 || selectedUser!= senderBtn.tag) {
        selectedUser=(int)senderBtn.tag;
        [UIView transitionWithView:client duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [client reloadData];
        } completion:nil];
        
        std=(int)senderBtn.tag;
        NSString * ID=[[[SingletonClass singleton].MyClientDetail objectAtIndex:std]objectForKey:@"id"];
        [[NSUserDefaults standardUserDefaults]setObject:ID forKey:@"uid"];
        Drop++;
        [client scrollRectToVisible:[client convertRect:client.tableFooterView.bounds fromView:client.tableFooterView] animated:YES];
        }
    else {
        
            [UIView transitionWithView:client duration:0.25f options:UIViewAnimationOptionTransitionNone animations:^{
            [client reloadData];
            } completion:nil];
        Drop=0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
        UIView *views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 80)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(83, 29, 156, 21)];
        [label setFont:[UIFont fontWithName:@"Lato-Bold" size:17]];
        [label setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
        NSString *string =[clientsName objectAtIndex:section];
        /* Section header is in 0th index... */
        [label setText:string];
        UIImageView *circle=[[UIImageView alloc]initWithFrame:CGRectMake(5, 9, 62, 62)];
        circle.image=[UIImage imageNamed:@"sign_circle.png"];
        [views addSubview:circle];
        
        UIImageView *userImages=[[UIImageView alloc]initWithFrame:CGRectMake(8, 12, 56, 56)];
    //NULL
        if ([userImage objectAtIndex:section]==nil || [[userImage objectAtIndex:section] isEqual:[NSNull null] ] || [[userImage objectAtIndex:section] isEqualToString:@"NULL"] || [[userImage objectAtIndex:section] isEqualToString:@""] || [[userImage objectAtIndex:section] isEqualToString:@"null"]) {
            userImages.image=[UIImage imageNamed:@"default8.png"];
        }
        else {
            clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[userImage objectAtIndex:section]];
            userImages.image=[Globals getImagesFromCache:clientImage];
        }
        userImages.layer.cornerRadius = userImages.frame.size.width / 2;
        userImages.clipsToBounds = YES;
        UIImageView *senderBtn=[[UIImageView alloc]initWithFrame:CGRectMake(280,25,24,9)];
        UIImage * buttonImage = [UIImage imageNamed:@"sign_arrow_down.png"];
        senderBtn.image=buttonImage;
        senderBtn.frame = CGRectMake(280, 30, 24, 9);
            // Button with aciton
        
        UIButton *senderBtnAction=[[UIButton alloc]initWithFrame:CGRectMake(280,25,24,30)];
        senderBtnAction.backgroundColor=[UIColor clearColor];
        senderBtnAction.tag=section;
        senderBtnAction.frame = CGRectMake(0, 0,views.frame.size.width, views.frame.size.height);
        [senderBtnAction addTarget:self action:@selector(userSelclected:) forControlEvents:UIControlEventTouchUpInside];
    
        [views addSubview:senderBtn];
        [views addSubview:userImages];
        [views addSubview:label];
        [views addSubview:senderBtnAction];
        [views setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]]; //your background color...
    
    return views;
}

#pragma apli implimentation*************************************************************

- (void)callDataFormServer {
    MBProgressHUD *  hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
  
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:KUrlGetTrainersClient apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionary];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                NSArray *mys =[json objectForKey:@"returnset"];
                [SingletonClass singleton].MyClientDetail=[[json objectForKey:@"returnset"] mutableCopy];
                clientsName=[mys valueForKey:@"name"];
               _errorView.hidden=YES;
                client.hidden=NO;
                userImage =[[mys valueForKey:@"avatar"] mutableCopy];
                for (int i=0; i<userImage.count; i++) {
                    if ([[userImage objectAtIndex:i] isEqual:[NSNull null]]) {
                        [userImage replaceObjectAtIndex:i withObject:@"" ];
                    }
                }
                for (int i=0; i<userImage.count; i++) {
                    if (![[userImage objectAtIndex:i] isEqualToString:@""]) {
                        clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[userImage objectAtIndex:i]];
                        [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:clientImage]];
                    }
                }

              [client reloadData];
              [hudFirst hide:YES];
                
            }
            else{
               
                [hudFirst hide:YES];
                _errorView.hidden=NO;
                _errorLabel.text=@"No clients yet!";
                        }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _errorView.hidden=NO;
        _errorLabel.text=@"Something went wrong, Please try again later";
    }];

}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addNewClient:(id)sender {
    [[NSUserDefaults standardUserDefaults]setObject:@"Yes" forKey:@"loadUser"];
    ClientsInformationController *addClient=[[ClientsInformationController alloc]init];
    [self.navigationController pushViewController:addClient animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- slideNavigation delegate methods
- (BOOL)slideNavigationControllerShouldDisplayRightMenu {
    return YES;
}
#pragma textField validations*************************************
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                        options:0
                                                          range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;
    if(range.length + range.location > textField.text.length) {
        return NO;
    }
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 3;
    
}



@end
