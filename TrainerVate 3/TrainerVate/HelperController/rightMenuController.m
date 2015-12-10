//
//  rightMenuController.m
//  TrainerVate
//
//  Created by Matrid on 10/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "rightMenuController.h"
#import "Constants.h"

@interface rightMenuController ()
{
    NSArray *rightMenue;
    UITableView *rightMenuList;
}

@end

@implementation rightMenuController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"rightMenuController_ipad" bundle:nibBundleOrNil];
    }
    else {
        self = [super initWithNibName:@"rightMenuController" bundle:nibBundleOrNil];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _profilePic.layer.cornerRadius=_profilePic.bounds.size.height/2;
    _profilePic.clipsToBounds=YES;
    
     [rightMenuList setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view from its nib.
    
    if (IS_IPHONE_5_OR_MORE) {
        rightMenuList=[[UITableView alloc]initWithFrame:CGRectMake(61, 164, 259, 404)];
    }
    else {
        rightMenuList=[[UITableView alloc]initWithFrame:CGRectMake(61, 164, 259, 306)];
    }
    rightMenuList.delegate=self;
    rightMenuList.dataSource=self;
    [rightMenuList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    rightMenuList.backgroundColor=[UIColor clearColor];
    [self.view addSubview:rightMenuList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutPerform) name:@"reload" object:nil];
    
}

- (void)logoutPerform {
    [rightMenuList reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        rightMenue=[NSArray arrayWithObjects:@"Home",@"Workouts",@"Dietplans",@"Stats",@"Recommend",@"Messages",@"Calendar",@"Shop",@"Settings",@"Sign Out",nil];
    }
    else {
        rightMenue=[NSArray arrayWithObjects:@"Home",@"My Clients",@"Recommend",@"Messages",@"Calendar",@"Shop",@"Settings",@"Sign Out",nil];
    }
    
    NSString *userPic=[[NSUserDefaults standardUserDefaults]objectForKey:@"userPic"];
    if (userPic==nil || [userPic isEqual:[NSNull null] ] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"null"]) {
        self.profilePic.image=[UIImage imageNamed:@"default8.png"];
    }
    else{
        NSString *usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",userPic];
        [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:usrImage]];
        self.profilePic.image=[Globals getImagesFromCache:usrImage];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        rightMenue=[NSArray arrayWithObjects:@"Home",@"Workouts",@"Dietplans",@"Stats",@"Recommend",@"Messages",@"Calendar",@"Shop",@"Settings",@"Sign Out",nil];
    }
    else {
        rightMenue=[NSArray arrayWithObjects:@"Home",@"My Clients",@"Recommend",@"Messages",@"Calendar",@"Shop",@"Settings",@"Sign Out",nil];
    }
    return rightMenue.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *defaults=@"defaultRows";
    UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:defaults];
    if (cell==NULL) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaults];
               }
   // UILabel *label=(UILabel *)[cell viewWithTag:101];;
    cell.textLabel.text=[rightMenue objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:[UIColor colorWithRed:15/255.0 green:47/255.0 blue:64/255.0 alpha:1.0]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    return cell;
       }
               
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
        if (indexPath.row==0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"homes" object:self];
        }
        else if (indexPath.row==1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"workouts" object:self];
        }
        else if (indexPath.row==2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dietplans" object:self];
        }
        else if (indexPath.row==3) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stats" object:self];
        }
        else if (indexPath.row==4) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"recomends" object:self];
        }
        else if (indexPath.row==5) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"messages" object:self];
        }
        else if (indexPath.row==6) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"calendars" object:self];
        }
        else if (indexPath.row==7) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shops" object:self];
        }
        else if (indexPath.row==8) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"settings" object:self];
        }
        else if (indexPath.row==9) {
            NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
            NSDictionary * dict = [defs dictionaryRepresentation];
            for (id key in dict) {
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            [AppDelegate generateTheAPiKey];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logouts" object:self];
        }
    
    }
    else {
        if (indexPath.row==0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"home" object:self];
        }
        if (indexPath.row==1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myClient" object:self];
        }
        if (indexPath.row==2) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"recomend" object:self];
        }
        if (indexPath.row==3) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"message" object:self];
        }
        if (indexPath.row==4) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"calendar" object:self];
        }
        if (indexPath.row==5) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shop" object:self];
        }
        if (indexPath.row==6) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setting" object:self];
        }
        else if (indexPath.row==7) {
            /*AccountTypeController *diet=[[AccountTypeController alloc]init];
             [self.navigationController pushViewController:diet animated:YES];*/
            
            NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
            NSDictionary * dict = [defs dictionaryRepresentation];
            for (id key in dict) {
                [defs removeObjectForKey:key];
            }
            [defs synchronize];
            [AppDelegate generateTheAPiKey];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self];
            
        }
    }
//    else if ([rightMenue objectAtIndex:indexPath.row] isequa)
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
