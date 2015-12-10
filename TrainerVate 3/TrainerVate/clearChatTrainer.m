//
//  clearChatTrainer.m
//  TrainerVate
//
//  Created by Matrid on 10/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "clearChatTrainer.h"
#import "AFNetworking.h"
#import "Globals.h"
#import "Constants.h"
#import "removeCustomCell.h"

@interface clearChatTrainer ()
{
    NSString *deleteOption;
    NSArray *json2;
}

@end

@implementation clearChatTrainer
@synthesize todayBtn,monthBtn,allBtn,view2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (IS_IPAD) {
        self = [super initWithNibName:@"clearChatTrainer_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"clearChatTrainer" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"clearChatTrainer_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Clear Chat Trainer"];
    // Do any additional setup after loading the view from its nib.
    _view4.hidden=YES;
    todayBtn.layer.cornerRadius=todayBtn.frame.size.height/2;
    monthBtn.layer.cornerRadius=monthBtn.frame.size.height/2;
    allBtn.layer.cornerRadius=allBtn.frame.size.height/2;
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    todayBtn.layer.cornerRadius=todayBtn.frame.size.height/2;
    monthBtn.layer.cornerRadius=monthBtn.frame.size.height/2;
    allBtn.layer.cornerRadius=allBtn.frame.size.height/2;
    _yes.layer.cornerRadius=_yes.frame.size.height/2;
    _no.layer.cornerRadius=_no.frame.size.height/2;
    view2.hidden=YES;
    _errorView.hidden=YES;
    _warningView.hidden=YES;
    _blurredView.hidden=YES;
    [self callData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return json2.count;
    
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
   
    cell.nameLbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.descLbl.text = [[json2 objectAtIndex:indexPath.row]valueForKey:@"status"];
        //    cell.dpImg.image = [UIImage imageNamed:[json2 objectAtIndex:indexPath.row]]
    cell.dpImg.layer.cornerRadius=cell.dpImg.bounds.size.height/2.0;
    cell.dpImg.layer.cornerRadius=cell.dpImg.bounds.size.width/2.0;
    cell.dpImg.clipsToBounds=YES;
    NSString *clientImage=[[json2 objectAtIndex:indexPath.row]valueForKey:@"avatar"];
    
    
    if (clientImage==nil || [clientImage isEqual:[NSNull null] ] || [clientImage isEqualToString:@"NULL"] || [clientImage isEqualToString:@""] || [clientImage isEqualToString:@"null"]) {
        cell.dpImg.image=[UIImage imageNamed:@"default8.png"];
    }
    else {
        NSString *clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[[json2 objectAtIndex:indexPath.row] valueForKey:@"avatar"]];
        cell.dpImg.image=[Globals getImagesFromCache:clientImage];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _blurredView.hidden=NO;
    view2.hidden=NO;
}


-(void)callData{
    
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
                [_tableVIew3 reloadData];
            }
            else{
                _view4.hidden=NO;
                _tableVIew3.hidden=YES;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _blurredView.hidden=NO;
        _errorView.hidden=NO;
        _warningView.hidden=YES;
        _lblError.text=@"Sorry internal server error! Please try again later.";
        _tableVIew3.hidden=YES;

        
    }];
    
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)todayBtn:(id)sender {
    deleteOption=@"day";
    view2.hidden=YES;
    _warningView.hidden=NO;


}

- (IBAction)monthBtn:(id)sender {
    deleteOption=@"day";
    view2.hidden=YES;
    _warningView.hidden=NO;
    deleteOption=@"month";
}

- (IBAction)allBtn:(id)sender {
    deleteOption=@"day";
    view2.hidden=YES;
    _warningView.hidden=NO;
    deleteOption=@"all";
}
- (IBAction)crossBtn:(id)sender {
    _blurredView.hidden=YES;
    view2.hidden=YES;
    _warningView.hidden=YES;
    
}
- (IBAction)yes:(id)sender {
    
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"ClearChat/" apiKey:[Globals apiKey]];
    NSString *isTrainer=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientID,@"uid",deleteOption,@"interval_type",isTrainer,@"is_trainer",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                            options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                _blurredView.hidden=YES;
                view2.hidden=YES;
                _warningView.hidden=YES;
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                _blurredView.hidden=NO;
                _errorView.hidden=NO;
                _warningView.hidden=YES;
                _lblError.text=@"No chat available!";
            }
            
        }
        else {
            _blurredView.hidden=NO;
            _errorView.hidden=NO;
            _warningView.hidden=YES;
            _lblError.text=@"Sorry internal server error! Please try again later.";
        }
            [hudFirst hide:YES];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            _blurredView.hidden=NO;
            _errorView.hidden=NO;
            _warningView.hidden=YES;
            _lblError.text=@"Sorry internal server error! Please try again later.";
            [hudFirst hide:YES];
        }];
    
}

- (IBAction)okError:(id)sender {
    _errorView.hidden=YES;
    _blurredView.hidden=YES;
}
@end
