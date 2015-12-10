//
//  messagesController.m
//  TrainerVate
//
//  Created by Matrid on 29/08/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "messagesController.h"
#import "Constants.h"

@interface messagesController (){
     NSMutableArray *clientData;
     NSMutableArray *clientId;
     NSMutableArray *userImage;
    NSString *clientImage ;
     NSString *selectedUsr;
     UIView *views1;
     UITableView *tblClientList;
  }

@end

@implementation messagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (IS_IPHONE_5_OR_MORE) {
        tblClientList=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 482)];
    }
    else {
        tblClientList=[[UITableView alloc]initWithFrame:CGRectMake(0, 86, 320, 394)];
    }
    tblClientList.delegate=self;
    tblClientList.dataSource=self;
    tblClientList.rowHeight=80;
    [tblClientList setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tblClientList];
    [self.view bringSubviewToFront:tblClientList];
    // Do any additional setup after loading the view from its nib.
     [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
   [self callDataFormServer];
}
#pragma tableView***********************************************************************

- (NSInteger)tableView :(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return clientData.count;
}
- (CGFloat)tableView :(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //custom Cell for row
    static NSString *cellSimple=@"SimpleTableCell";
    clientListViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellSimple];
    if (cell==nil) {
        NSArray *tempData=[[NSBundle mainBundle]loadNibNamed:@"clientListViewCell" owner:self options:nil];
        cell=[tempData objectAtIndex:0];
    }
    cell.imgUserPic.layer.cornerRadius=cell.imgUserPic.bounds.size.width/2;
    cell.imgUserPic.clipsToBounds=YES;
    
    
    if ([userImage objectAtIndex:indexPath.row]==nil || [[userImage objectAtIndex:indexPath.row] isEqual:[NSNull null] ] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@"NULL"] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@""] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@"null"]) {
        cell.imgUserPic.image=[UIImage imageNamed:@"default8.png"];
    }
    else {
        clientImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[userImage objectAtIndex:indexPath.row]];
        cell.imgUserPic.image=[Globals getImagesFromCache:clientImage];

    }
    cell.lblClientName.text=[[clientData objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.lblLatestMessage.text=[[clientData objectAtIndex:indexPath.row] valueForKey:@"last_message"];
    if ([cell.lblLatestMessage.text isEqualToString:@"null"]) {
        cell.lblLatestMessage.text=@"No message from client.";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedUsr=[clientId objectAtIndex:indexPath.row];
    [[SingletonClass singleton].clientInfo setObject:[selectedUsr mutableCopy] forKey:@"uidMessage"];
    messagesMainChatController *chat=[[messagesMainChatController alloc]init];

        if ([userImage objectAtIndex:indexPath.row]==nil || [[userImage objectAtIndex:indexPath.row] isEqual:[NSNull null] ] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@"NULL"] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@""] || [[userImage objectAtIndex:indexPath.row] isEqualToString:@"null"]) {
        
    }
        else {
            NSString *clientImages = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[userImage objectAtIndex:indexPath.row]];
            chat.clientImage=clientImages;
        }
    [self.navigationController pushViewController:chat animated:YES];
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
                clientData=[json objectForKey:@"returnset"];
                clientId=[clientData valueForKey:@"id"];
                if (userImage==nil) {
                    userImage=[[NSMutableArray alloc]init];
                }
                userImage =[[clientData valueForKey:@"avatar"] mutableCopy];
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
                [tblClientList reloadData];
                [hudFirst hide:YES];
                
            }
            else if ([[json objectForKey:@"status_code"] isEqualToString:@"EMPTY"]) {
                tblClientList.hidden=YES;
                [hudFirst hide:YES];
            }
            else{
                
                [hudFirst hide:YES];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hudFirst hide:YES];
    }];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
