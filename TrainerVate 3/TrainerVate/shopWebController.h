//
//  shopWebController.h
//  TrainerVate
//
//  Created by Pankaj Khatri on 26/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface shopWebController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>

- (IBAction)BackBtn:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UIWebView *webVIews;
@end
