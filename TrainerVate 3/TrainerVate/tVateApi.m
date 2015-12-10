//
//  CourseApi.m
//  Golfie
//
//  Created by Pankaj Khatri on 06/04/15.
//  Copyright (c) 2015 cogniter. All rights reserved.
//
#define kCachedImagesFolder @"Attachments"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#import "tVateApi.h"
#import "SingletonClass.h"

@implementation tVateApi

+ (NSString *)domain {
    
    // Online
    
    return @"http://104.238.92.1:81/api/";
    
    
    //Client
   // return @"http://202.164.57.203:8033/api/";
    
    //dev
  //  return @"http://202.164.57.203:8020/api/";
    
   
    
    //testing
   // return @"http://202.164.57.203:8026/api/";
}

+ (NSString *)baseUrl {
    NSMutableString *baseUrl = [[tVateApi domain] mutableCopy];
    //  [baseUrl appendString:@""];
    return baseUrl;
}

+(void)createImageCache:(NSDictionary *)dicDetails :(NSString *)ImagePath
{   NSURL *imageUrl;
    if (dicDetails) {
        imageUrl= [dicDetails objectForKey:@"imageUrl"];
    }
    else{
        NSMutableDictionary *dicDetails = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"Image",@"",@"folder", nil];
        [dicDetails setObject:kCachedImagesFolder forKey:@"folder"];
        imageUrl= [NSURL URLWithString:ImagePath];
    }
    
    NSString *folderName = [dicDetails objectForKey:@"folder"];
    
    NSData * data = [[NSData alloc]initWithContentsOfURL:imageUrl];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@",imageUrl];
    
    NSString *pngFileName= [strUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    //Get the docs directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    documentsPath = [documentsPath stringByAppendingPathComponent:folderName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
    {
        // Directory does not exist so create it
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    //Add the file name
    NSString *filePath = [documentsPath stringByAppendingPathComponent:pngFileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        //Write the file
        [data writeToFile:filePath atomically:YES];
    }
}

+(UIImage *)checkForImagesFromCaching:(NSURL *)imageUrl andFolder:(NSString *)folderName
{
    NSString *strUrl = [NSString stringWithFormat:@"%@",imageUrl];
    
    NSString *pngFileName= [strUrl stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    
    //Get the docs directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    documentsPath = [documentsPath stringByAppendingPathComponent:folderName];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:pngFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableDictionary *dicCacheImage = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"imageExist",@"",@"image", nil];
    
    if ([fileManager fileExistsAtPath: filePath])
    {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
       CGSize size = CGSizeMake(200, 200);
    
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        [dicCacheImage setObject:@"YES" forKey:@"imageExist"];
        
        if (destImage == nil)
        {
            [dicCacheImage setObject:@"" forKey:@"image"];
            
        }
        else
        {
            [dicCacheImage setObject:image forKey:@"image"];
        }
        
        return destImage;
    }
    else
    {
        
        [dicCacheImage setObject:@"YES" forKey:@"imageExist"];
        [dicCacheImage setObject:@"" forKey:@"image"];
        
        return nil;
    }
}
+(UIImage*)getImagesFromCache :(NSString*)imageUrl
{
    UIImage *ReturnImage;
    
    NSString *ImageUrL = imageUrl;
    
    if ([ImageUrL isEqual:[NSNull null]])
    {
        if (IS_IPAD) {
            ReturnImage=[UIImage imageNamed:@"imageCellgreen-ipad.png"];
            return ReturnImage;
        }else{
            ReturnImage=[UIImage imageNamed:@"imageCellgreen-ipad.png"];
            return ReturnImage;
        }
        
        
    }
    else
    {
        UIImage *image = [tVateApi checkForImagesFromCaching:[NSURL URLWithString:ImageUrL] andFolder:kCachedImagesFolder];
        
        
        if (image == nil)
        {
            
            
                    ReturnImage=[UIImage imageNamed:@"imageCellgreen-ipad.png"];
            
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            
            [manager downloadWithURL:[NSURL URLWithString:ImageUrL]
                             options:0
                            progress:^(NSInteger receivedSize, NSInteger expectedSize)
             {
                 
             }
                           completed:^(UIImage *imageCached, NSError *error, SDImageCacheType cacheType, BOOL finished)
             {
                 if (imageCached)
                 {
                     UIImage *ReturnImage;
                     
                     
                     CGSize size = CGSizeMake(200, 200);
                     UIGraphicsBeginImageContext(size);
                     [imageCached drawInRect:CGRectMake(0, 0, size.width, size.height)];
                     UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
                     UIGraphicsEndImageContext();
                     ReturnImage=destImage;
                     
                 }
                 
             }];
            
        }
        else
        {
            ReturnImage=image;
            return ReturnImage;
        }
        return ReturnImage;
    }
}

@end
