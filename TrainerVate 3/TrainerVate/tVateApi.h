//
//  CourseApi.h
//  Golfie
//
//  Created by Pankaj Khatri on 06/04/15.
//  Copyright (c) 2015 cogniter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Globals.h"
#import "UIImageView+WebCache.h"
@interface tVateApi : NSObject{
    //    UIImage *ReturnImage;
    NSMutableData *responseData ;
    NSDictionary* response;
}
+ (NSString *)domain;
+ (NSString *)baseUrl;


// + (CourseApi*)GetTypeWebService_Values :(NSDictionary *)Dict ;

+(void)createImageCache:(NSDictionary *)dicDetails :(NSString *)ImagePath;
+(UIImage *)checkForImagesFromCaching:(NSURL *)imageUrl andFolder:(NSString *)folderName;
+(UIImage*)getImagesFromCache :(NSString*)imageUrl;
//+ (id)upload:(NSString*)endpoint parameters:(NSMutableString*)parameters method:(NSString*)method error:(NSError**)error;
//+(void)createImageCache:(NSDictionary *)dicDetails :(NSString *)ImagePath;
//+(UIImage *)checkForImagesFromCaching:(NSURL *)imageUrl andFolder:(NSString *)folderName;
//+ (CourseApi *) callWebServiceToCahceImagesForSearch;
//+(UIImage*)getImagesFromCache :(NSString*)imageUrl;


@end
