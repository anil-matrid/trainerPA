//
//  UpdateTrainnerController.m
//  TrainerVate
//
//  Created by Matrid on 11/07/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "UpdateTrainnerController.h"
#import "Constants.h"

@interface UpdateTrainnerController ()

@end

@implementation UpdateTrainnerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- UipickerViewDelegate
-(IBAction)pickImage:(id)sender
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
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    
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
    if (IS_IPAD) {
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        NSArray *mediaTypesAllowed = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        imagePicker.delegate =self;
        [imagePicker setMediaTypes:mediaTypesAllowed];
        imagePicker.allowsEditing = NO;
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        
        if ([popoverController isPopoverVisible]) {
            [popoverController dismissPopoverAnimated:YES];
        }
        [actionSheet removeFromSuperview];
        
        popoverController=[[UIPopoverController alloc] initWithContentViewController:imagePicker];
        popoverController.delegate=self;
        
        [popoverController presentPopoverFromRect:self.imagbtn.frame  inView:self.view permittedArrowDirections:0 animated:YES];
    } else {
        
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
        imagePicker.sourceType =UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes =[NSArray arrayWithObject:(NSString *)kUTTypeImage];
        imagePicker.delegate =self;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _userImage.image = image;
        
    }];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    NSData *pictureData= UIImageJPEGRepresentation(image,0.5);
    
    NSString *encodedString = [pictureData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    encodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    return encodedString;
}


- (IBAction)PostData:(id)sender {
    
    
    NSString *imageStr=[self encodeToBase64String:_userImage.image];
    NSString *urlString=[Globals urlCombileHash:kApiDomin ClassUrl:kUrlUpadteTrannerProfile apiKey:[Globals apiKey]];
    NSDictionary *inputDic=[NSDictionary dictionaryWithObjectsAndKeys:imageStr,@"avatar",@"abc",@"description",@"dev@wellbeingnetwork.com",@"paypal", nil];
    
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:inputDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions error:&error];
        if (json !=nil && json.allKeys.count!=0) {
            
            if ([[json objectForKey:@"status_code"] isEqualToString:@"SUCCESS"]) {
                [[NSUserDefaults standardUserDefaults]setValue:[[[json objectForKey:@"returnset"]objectForKey:@"user"] objectForKey:@"name"] forKey:@"username"];
              //  [self pushWhenLoginSecuss];
                
            }
            else{
                [Globals alert:@"Something went wrong. Please try again later"];
            }
            
            
        }
        //[hudFirst hide:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // [hudFirst hide:YES];
        [Globals alert:@"Something went wrong. Please try again later"];
    }];
    

}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
