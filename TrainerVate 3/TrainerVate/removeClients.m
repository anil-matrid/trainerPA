//
//  removeClients.m
//  TrainerVate
//
//  Created by Matrid on 08/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "removeClients.h"
#import "removeCustomCell.h"
#import "AFNetworking.h"
#import "Constants.h"

@interface removeClients (){
    NSArray *json2;
    int selectedBtn;
    NSArray *json3;
}

@end

@implementation removeClients

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Remove Clients"];
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    _view2.hidden=YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self callData];
    selectedBtn=1;
    [_connectBtn setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    [_disconnectBtn  setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0]];
    _disconnectBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Regular" size:16];
    _connectBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Bold" size:18];
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (selectedBtn==1) {
        return json2.count;
    }
    else{
        return json3.count;
    
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *defaultCell = @"default";
    removeCustomCell *cell = (removeCustomCell *)[tableView dequeueReusableCellWithIdentifier:defaultCell];
    
    if (cell==NULL) {
        NSArray *fArray = [[NSBundle mainBundle]loadNibNamed:@"removeCustomCell" owner:self options:nil];
        cell = [fArray objectAtIndex:0];
    }
    NSString *clientImage;
    if (selectedBtn==1) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(283,0,37,36)];
        btn.frame = CGRectMake(284,0,36,30);
        [btn addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"cross.png"] forState:normal];
        btn.tag=indexPath.row;
        [cell addSubview:btn];
        
        cell.nameLbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"name"];
        cell.descLbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"status"];
        clientImage=[[json2 objectAtIndex:indexPath.row]valueForKey:@"avatar"];
    }
    else {
        cell.nameLbl.text = [[json3 objectAtIndex:indexPath.row]valueForKey:@"name"];
        cell.descLbl.text = [[json3 objectAtIndex:indexPath.row]valueForKey:@"status"];
        clientImage=[[json3 objectAtIndex:indexPath.row]valueForKey:@"avatar"];
    }
    cell.dpImg.layer.cornerRadius=cell.dpImg.bounds.size.height/2.0;
    cell.dpImg.layer.cornerRadius=cell.dpImg.bounds.size.width/2.0;
    cell.dpImg.clipsToBounds=YES;
    
    
    
    
    if (clientImage==nil || [clientImage isEqual:[NSNull null] ] || [clientImage isEqualToString:@"NULL"] || [clientImage isEqualToString:@""] || [clientImage isEqualToString:@"null"]) {
        cell.dpImg.image=[UIImage imageNamed:@"default8.png"];
    }
    else {
        NSString *clientImage;
        if (selectedBtn==1) {
            clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[[json2 objectAtIndex:indexPath.row] valueForKey:@"avatar"]];
        }
        else {
            clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[[json3 objectAtIndex:indexPath.row] valueForKey:@"avatar"]];
        }
        cell.dpImg.image=[Globals getImagesFromCache:clientImage];
    }
    return cell;
}
- (IBAction)optionsBtn:(id)sender {
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)navBtn:(id)sender {
}

- (IBAction)connectBtn:(id)sender {
    _view2.hidden=YES;
    [_connectBtn setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    [_disconnectBtn  setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0]];
    _disconnectBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Regular" size:16];
    _connectBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Bold" size:18];
    [self callData];
    selectedBtn=1;
    [_tableView2 reloadData];
}

-(void)callData{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
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
                json2 = [json valueForKey:@"returnset"];
                [Globals saveUserImagesIntoCache:[json2 valueForKey:@"avatar"]];
                _view2.hidden=YES;
                _tableView2.hidden=NO;
                [_tableView2 reloadData];
            }
            else{
                _view2.hidden=NO;
                _tableView2.hidden=YES;
                            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
    }];
}

-(IBAction)cellSelected:(UIButton *)sender{
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"DeleteUsers/" apiKey:[Globals apiKey]];
NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",[[json2 objectAtIndex:sender.tag] valueForKey:@"id"],@"user_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                 json2 = [json valueForKey:@"returnset"];
                [self callData];
            }
            else{
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
  
}

-(void)calldatafromserver{
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"GetUnMappedUsers/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                json3 = [json valueForKey:@"returnset"];
                [Globals saveUserImagesIntoCache:[json3 valueForKey:@"avatar"]];
                _view2.hidden=YES;
                _tableView2.hidden=NO;
                [_tableView2 reloadData];

            }
            else{
                _view2.hidden=NO;
                _tableView2.hidden=YES;
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
    }];
}

- (IBAction)disconnectBtn:(id)sender {
    _view2.hidden=YES;
    [_disconnectBtn setBackgroundColor:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0]];
    [_connectBtn  setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0]];
    _connectBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Regular" size:16];
    _disconnectBtn.titleLabel.font=[UIFont fontWithName:@"Lato-Bold" size:18];
    selectedBtn=2;
    [self calldatafromserver];
    [_tableView2 reloadData];
    
}
@end
