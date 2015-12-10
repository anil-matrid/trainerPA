//
//  clearChatClient.m
//  TrainerVate
//
//  Created by Matrid on 16/10/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "clearChatClient.h"
#import "AFNetworking.h"
#import "Globals.h"
#import "Constants.h"


@interface clearChatClient ()
{
    NSString *deleteOption;
    BOOL flag;
}

@end

@implementation clearChatClient
@synthesize todayBtn,monthBtn,allBtn,view2,blurredView,yesBtn,noBtn,view3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    flag=NO;
    todayBtn.layer.cornerRadius=todayBtn.frame.size.height/2;
    monthBtn.layer.cornerRadius=monthBtn.frame.size.height/2;
    allBtn.layer.cornerRadius=allBtn.frame.size.height/2;
    yesBtn.layer.cornerRadius=allBtn.frame.size.height/2;
    noBtn.layer.cornerRadius=allBtn.frame.size.height/2;

    view2.hidden=YES;
    blurredView.hidden=YES;
    view3.hidden=YES;
}
    /*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)noBtn:(id)sender {
    view2.hidden=YES;
    blurredView.hidden=YES;
}

- (IBAction)navBtn:(id)sender {
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)todayBtn:(id)sender {
    deleteOption=@"day";
    view2.hidden=NO;
    blurredView.hidden=NO;
    
    
}

- (IBAction)monthBtn:(id)sender {
    deleteOption=@"day";
    view2.hidden=NO;
    blurredView.hidden=NO;

    deleteOption=@"month";
}

- (IBAction)allBtn:(id)sender {
    deleteOption=@"day";
    view2.hidden=NO;
    blurredView.hidden=NO;

    deleteOption=@"all";
}

- (IBAction)yes:(id)sender {
    
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    
    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientid =[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];

    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"ClearChat/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientid,@"uid",deleteOption,@"interval_type",@"0",@"is_trainer",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                blurredView.hidden=YES;
                view2.hidden=YES;
                view3.hidden=NO;
            }
            else{
                view2.hidden=YES;
                view3.hidden=NO;
                flag=YES;
                _lbl.text=@"Chat already empty";
            }
            
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        view2.hidden=YES;
        view3.hidden=NO;
        flag=YES;
        _lbl.text=@"Internal Server error. Please Try Again";
        [hudFirst hide:YES];
    }];
    
}



- (IBAction)okBtn:(id)sender {
    if (flag==YES) {
        view3.hidden=YES;
        blurredView.hidden=YES;
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
