//
//  DisconnectTrainer.m
//  Settings
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "DisconnectTrainer.h"
#import "Constants.h"

@interface DisconnectTrainer ()

@end

@implementation DisconnectTrainer
//-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    if (IS_IPAD) {
//        self = [super initWithNibName:@"DisconnectTrainer_ipad" bundle:nibBundleOrNil];
//    }
//    else if(IS_IPHONE_5_OR_MORE) {
//        
//        self = [super initWithNibName:@"DisconnectTrainer" bundle:nibBundleOrNil];
//    }
//    else
//    {
//        self = [super initWithNibName:@"DisconnectTrainer_4" bundle:nibBundleOrNil];
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _disconnect.layer.cornerRadius=11;
    
    //implimenting navigation bar
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    _okBtn.layer.cornerRadius = _okBtn.bounds.size.height/2;
    _cancelBtn.layer.cornerRadius=_cancelBtn.bounds.size.height/2;
    _blurredView.hidden=YES;
    _view2.hidden=YES;

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)disconnect:(id)sender {
    _blurredView.hidden=NO;
    _view2.hidden=NO;
   }

- (IBAction)cancelBtn:(id)sender {
    _blurredView.hidden=YES;
    _view2.hidden=YES;

}

- (IBAction)okBtn:(id)sender {
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];

    NSString *trainerID =[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *clientid =[[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    NSString *urlString=[Globals urlCombileHash:kApiDominStage ClassUrl:@"DeleteUsers/" apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:trainerID,@"trainer_id",clientid,@"user_id",nil];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"userId"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                
            }
        }
        [hudFirst hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
    }];

}
@end
