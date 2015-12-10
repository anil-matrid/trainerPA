//
//  shopWebController.m
//  TrainerVate
//
//  Created by Pankaj Khatri on 26/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "shopWebController.h"

@interface shopWebController ()
{
    MBProgressHUD *  hudFirst ;
    UIWebView *webVIews;
}
@end

@implementation shopWebController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewNew];
    // Do any additional setup after loading the view from its nib.
    
}
-(void)loadViewNew
{
    hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hudFirst.delegate = self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *urlString;
    NSString *affId=[[NSUserDefaults standardUserDefaults] objectForKey:@"afId"];
    NSString *tokenId = [[NSUserDefaults standardUserDefaults]objectForKey:@"shopToken"] ;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"] isEqualToString:@"0"]) {
         urlString =[NSString stringWithFormat:@"http://wellbeingnetwork.com/store/mobilecheckout.php?locale=en&token=%@&aff=%@",tokenId,affId];
    }
    else {
         urlString =[NSString stringWithFormat:@"http://wellbeingnetwork.com/store/mobilecheckout.php?locale=en&token=%@",tokenId];
    }
    if (IS_IPHONE_5_OR_MORE) {
        webVIews=[[UIWebView alloc]initWithFrame:CGRectMake(0, 87, 320, 481)];
    }
    else {
        webVIews=[[UIWebView alloc]initWithFrame:CGRectMake(0, 87, 320, 393)];
    }
    webVIews.delegate=self;
    [webVIews loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self.view addSubview:webVIews];
    [self.view bringSubviewToFront:hudFirst];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark- web view delegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //Start the progressbar..
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [hudFirst hide:YES];
    //Stop or remove progressbar
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [hudFirst hide:YES];
    //Stop or remove progressbar and show error
}


- (IBAction)BackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
