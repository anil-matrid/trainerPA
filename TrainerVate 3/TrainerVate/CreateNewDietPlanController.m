//
//  CreateNewDietPlanController.m
//  TrainerVate
//
//  Created by Matrid on 18/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "CreateNewDietPlanController.h"
#import "Constants.h"

@interface CreateNewDietPlanController ()

@end

@implementation CreateNewDietPlanController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"CreateNewDietPlanController_ipad" bundle:nibBundleOrNil];
    }
    else if(IS_IPHONE_5_OR_MORE) {
        
        self = [super initWithNibName:@"CreateNewDietPlanController" bundle:nibBundleOrNil];
    }
    else
    {
        self = [super initWithNibName:@"CreateNewDietPlanController_4" bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [Globals GoogleAnalyticsScreenName:@"Create New Diet Plan Controller"];
    _scroll.contentSize = CGSizeMake(_scroll.frame.size.width,480);
    _viewTextBg.layer.cornerRadius=_viewTextBg.bounds.size.height/2;
    // Do any additional setup after loading the view from its nib.
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [SingletonClass singleton].breakfastdietPlanBundelFood=nil;
    [SingletonClass singleton].breakfastdietPlanBundelSuppliment=nil;
    [SingletonClass singleton].lunchdietPlanBundelArray=nil;
    [SingletonClass singleton].lunchdietPlanBundelSuppliment=nil;
    [SingletonClass singleton].snaksdietPlanBundelArray=nil;
    [SingletonClass singleton].snaksdietPlanBundelSuppliment=nil;
    [SingletonClass singleton].dinnerdietPlanBundelArray=nil;
    [SingletonClass singleton].dinnerdietPlanBundelSuppliment=nil;
    
    [[SingletonClass singleton].breakfastdietPlanBundelFood removeAllObjects];
    [[SingletonClass singleton].breakfastdietPlanBundelSuppliment removeAllObjects];
    [[SingletonClass singleton].lunchdietPlanBundelArray removeAllObjects];
    [[SingletonClass singleton].lunchdietPlanBundelSuppliment removeAllObjects];
    [[SingletonClass singleton].snaksdietPlanBundelArray removeAllObjects];
    [[SingletonClass singleton].snaksdietPlanBundelSuppliment removeAllObjects];
    [[SingletonClass singleton].dinnerdietPlanBundelArray removeAllObjects];
    [[SingletonClass singleton].dinnerdietPlanBundelSuppliment removeAllObjects];
     
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"snacksDay"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"lunchDay"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"breakDay"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)next:(id)sender {
    //[SingletonClass singleton].Workout = _txtDietName.text;
    NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
    NSString *trimmedString = [_txtDietName.text stringByTrimmingCharactersInSet:charSet];
    _txtDietName.text = trimmedString;
    if ([trimmedString isEqualToString:@""]) {
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Diet plan name can not be empty!";
        return;
    }
    [self callDataFormServer];
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ok:(id)sender {
    
    _errorView.hidden=YES;
    _bluredView.hidden=YES;
}

-(void)callDataFormServer {
    
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    [hudFirst show:YES];
    
    NSString *clientID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *dietName=_txtDietName.text;
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:dietName,@"name",clientID,@"trainer_id",nil];
    NSString *urlString =[Globals urlCombileHash:kApiDominStage ClassUrl:@"DetectDietPlan/" apiKey:[Globals apiKey]];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        [hudFirst hide:YES];
        if (json !=nil && json.allKeys.count!=0) {
            if ([[json objectForKey:@"status_code"]isEqualToString:@"SUCCESS"]) {
                _errorView.hidden=YES;
                _bluredView.hidden=YES;
                CreateDietPlan *diet=[[CreateDietPlan alloc]init];
                [[NSUserDefaults standardUserDefaults]setObject:_txtDietName.text forKey:@"customDietID"];
                [self.navigationController pushViewController:diet animated:YES];
            }
            else {
                [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
                _errorView.hidden=NO;
                _bluredView.hidden=NO;
                _lblMessage.text=@"Diet plan name already exist's!";
            }
        }
        else {
            _errorView.hidden=NO;
            _bluredView.hidden=NO;
            _lblMessage.text=@"Sorry! Internal Server Error.";
            [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
        _errorView.hidden=NO;
        _bluredView.hidden=NO;
        _lblMessage.text=@"Sorry! Internal Server Error.";
        [Globals showBounceAnimatedView:self.errorView completionBlock:nil];
    }];
}

@end
