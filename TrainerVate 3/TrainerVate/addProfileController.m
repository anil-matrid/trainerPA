//
//  addProfileController.m
//  Settings
//
//  Created by Matrid on 20/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "addProfileController.h"
#import "Constants.h"


@interface addProfileController ()
{
    UIImagePickerController *imagePicker;
}
@end

@implementation addProfileController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (IS_IPAD) {
        self = [super initWithNibName:@"addProfileController_ipad" bundle:nibBundleOrNil];
    }
    else{
        
        self = [super initWithNibName:@"addProfileController" bundle:nibBundleOrNil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _userImage.contentMode=UIViewContentModeScaleAspectFit;
    _userImage.layer.cornerRadius=_userImage.bounds.size.height/2;
    _userImage.layer.cornerRadius=_userImage.bounds.size.width/2;
    _userImage.clipsToBounds=YES;
    NSString *userPic=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userPic"] ];
    if (userPic==nil || [userPic isEqual:[NSNull null] ] || [userPic isEqualToString:@"NULL"] || [userPic isEqualToString:@""] || [userPic isEqualToString:@"null"]) {
       _userImage.image=[UIImage imageNamed:@"default8.png"];
        
    }
    else{
        NSString *usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",userPic];
        _userImage.image=[Globals getImagesFromCache:usrImage];
    }
    //implimenting navigation bar
    [_navigationBar addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- UipickerViewDelegate
-(IBAction)addProfilePicture:(id)sender
{
    actionSheet=[[UIActionSheet alloc]initWithTitle:@"Upload image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"From Library",@"From Camera", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self photoLibraryAccess];
            break;
        case 1:
            [self cameraAccess];
            break;
        default:
            break;
    }
}
-(void)cameraAccess
{
    imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setAllowsEditing:YES];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes =[NSArray arrayWithObject:(NSString *)kUTTypeImage];
        imagePicker.delegate =self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        [Globals alert:@"Device does not support Camera."];
    }
}


-(void)photoLibraryAccess
{
    imagePicker=[[UIImagePickerController alloc]init];
    [imagePicker setAllowsEditing:YES];
    imagePicker.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
    imagePicker.delegate=self;
    
    if (IS_IPAD) {
//        UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        NSArray *mediaTypesAllowed = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        imagePicker.delegate =self;
        [imagePicker setMediaTypes:mediaTypesAllowed];
        imagePicker.allowsEditing = NO;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        
        if ([popoverController isPopoverVisible]) {
            [popoverController dismissPopoverAnimated:YES];
        }
        [actionSheet removeFromSuperview];
        
        popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePicker];
        popoverController.delegate=self;
        
        
        [popoverController presentPopoverFromRect:self.imgBtn.frame  inView:self.view permittedArrowDirections:0 animated:YES];
    } else {
        
       
//        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes =[NSArray arrayWithObject:(NSString *)kUTTypeImage];
     //   imagePicker.delegate =self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        _userImage.image = image;
        _userImage.contentMode = UIViewContentModeScaleAspectFit;
        [self uploadJPEGImage:image];
    }];
}

- (void)uploadJPEGImage:(UIImage*)image {
    MBProgressHUD *hudFirst = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   // hudFirst.delegate =self;
    hudFirst.labelText=@"Please wait";
    hudFirst.center=self.view.center;
    hudFirst.dimBackground=YES;
    hudFirst.removeFromSuperViewOnHide = YES;
    [hudFirst show:YES];
    NSString *userID;
    //userEmail
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"] isEqualToString:@"0"]) {
        userID =[[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
    }
    else {
        userID =[[NSUserDefaults standardUserDefaults]objectForKey:@"userId"];
    }
    NSString *userEmail =[[NSUserDefaults standardUserDefaults]objectForKey:@"email"];
    
    // Determine output size
    CGFloat maxSize = 1024.0f;
    CGFloat width = self.userImage.image.size.width;
    CGFloat height = self.userImage.image.size.height;
    CGFloat newWidth = width;
    CGFloat newHeight = height;
    
    // If any side exceeds the maximun size, reduce the greater side to 1200px and proportionately the other one
    if (width > maxSize || height > maxSize) {
        if (width > height) {
            newWidth = maxSize;
            newHeight = (height*maxSize)/width;
        } else {
            newHeight = maxSize;
            newWidth = (width*maxSize)/height;
        }
    }
    
    // Resize the image
    CGSize newSize = CGSizeMake(newWidth, newHeight);
//    for better reso...
//    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    UIGraphicsBeginImageContext(newSize);
    [self.userImage.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Set maximun compression in order to decrease file size and enable faster uploads & downloads
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.0f);
    UIImage *processedImage = [UIImage imageWithData:imageData];
   
    NSDictionary *sendingDic=[NSDictionary dictionaryWithObjectsAndKeys:[self encodeToBase64String:processedImage],@"ImageCode",userEmail,@"email",userID,@"user_id",nil];
    NSString *urlString = [Globals urlCombileHash:kApiDominStage ClassUrl:@"UpdatePic/" apiKey:[Globals apiKey]];
    [Globals PostApiURL:urlString data:sendingDic success:^(id responseObject) {
        [hudFirst hide:YES];
        [[NSUserDefaults standardUserDefaults]setValue:[responseObject objectForKey:@"image"] forKey:@"userPic"];
        NSString *usrImage = [NSString stringWithFormat:@"http://dev.wellbeingnetwork.com/trainervat_staging/getimage.php?image=%@",[responseObject objectForKey:@"image"]];
        [Globals saveUserImagesIntoCache:[NSMutableArray arrayWithObject:usrImage]];
    } failure:^(NSError *error) {
        [hudFirst hide:YES];
    }];
  }
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)encodeToBase64String:(UIImage *)image {
    
    NSData *pictureData= UIImageJPEGRepresentation(image,0.5);
    NSString *encodedString = [pictureData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedString;
}
@end
