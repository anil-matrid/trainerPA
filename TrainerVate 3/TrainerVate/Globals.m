//
//  Globals.m
//  Artii
//
//  Created by Gagan Arora on 6/5/14.
//  Copyright (c) 2014 Gagandeep Arora. All rights reserved.
//

#import "Globals.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "AFHTTPRequestOperationManager.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
static Globals *sharedSettings = nil;

@implementation Globals
+ (Globals*)sharedInstance
{
    @synchronized(self) {
        if (sharedSettings == nil) {
            sharedSettings = [[self alloc] init];
		}
    }
    return sharedSettings;
}

+(NSString *)apiKey{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"apiKey"];
}
+(void) alert:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Alert" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(BOOL)validate:(NSString *)string
{
    NSError *error             = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:
                                  @"[A-Z0-9a-z\\._ ]" options:0 error:&error];
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
   
    
    return numberOfMatches == string.length;
}


+(NSString *)urlCombile:(NSString *)DomainName ClassUrl:(NSString *)ClassUrl apiKey:(NSString *)apiKey{
    NSString *makeUrl=[NSString stringWithFormat:@"%@%@",DomainName,ClassUrl];
    //[DomainName stringByAppendingString:ClassUrl];
    return[NSString stringWithFormat:@"%@%@",makeUrl,apiKey];// [makeUrl stringByAppendingString:apiKey];
}
+(NSString *)urlCombileHash:(NSString *)DomainName ClassUrl:(NSString *)ClassUrl apiKey:(NSString *)apiKey {
    NSString *hash=[[NSUserDefaults standardUserDefaults]objectForKey:@"hash"];
    NSString *makeGetUserUrl=[DomainName stringByAppendingString:ClassUrl];
    makeGetUserUrl= [makeGetUserUrl stringByAppendingString:apiKey];
    return [makeGetUserUrl stringByAppendingString:[NSString stringWithFormat:@"/%@",hash]];
}
+(int)arrayContainIndexPath:(NSMutableArray *)TempArray currentIndex:(NSIndexPath *)indexPath
{
    for (int i=0; i<TempArray.count; i++) {
        NSIndexPath *preIndexPath=[TempArray objectAtIndex:i];
        if (preIndexPath.row==indexPath.row && preIndexPath.section==indexPath.section) {
            return i;
        }
    }
    return 0;
}

+ (BOOL)NetworkStatus
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        [Globals alert:@"Unable to connect to internet."];
        return NO;
    }
    else
        return YES;
}
+ (BOOL)NetworkStatusBackground
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable)
    {
       //[Globals alert:@"Alert" :@"Unable to connect to internet."];
        return NO;
    }
    else
        return YES;
}
+(NSString *)DictonaryValuesForKeys :(NSString *) CurrentValue
{
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"weight" forKey:@"weight"];
    [dict setObject:@"waist size" forKey:@"waist_size"];
    [dict setObject:@"body fat %" forKey:@"body_fat"];
    [dict setObject:@"arm size" forKey:@"arm_size"];
    [dict setObject:@"leg size" forKey:@"leg_size"];
    [dict setObject:@"water %" forKey:@"water"];
    [dict setObject:@"chest size" forKey:@"chest_size"];
    [dict setObject:@"physical rating" forKey:@"physical_rating"];
    [dict setObject:@"bone mass" forKey:@"bone_mass"];
   
    return [dict objectForKey:CurrentValue];
}
#pragma mark -Cache Methods
+(void) saveUserImagesIntoCache:(NSMutableArray*)ResponseArray
{
    //Save images in chache
    for (int i=0; i<[ResponseArray count]; i++) {
        
        
        
        NSString *str=[ResponseArray objectAtIndex:i];
        
        NSMutableDictionary *dicAttachmentDetails = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"SenderImg",@"",@"folder", nil];
        if ([str isEqual:[NSNull null]]) {
        }
        else{
            [dicAttachmentDetails setObject:[NSURL URLWithString:str] forKey:@"imageUrl"];
            
        }
        [dicAttachmentDetails setObject:kCachedImagesFolder forKey:@"folder"];
        
        [NSThread detachNewThreadSelector:@selector(callMethodToCacheImage:) toTarget:self withObject:dicAttachmentDetails];
        
    }
}


+(void)callMethodToCacheImage:(NSMutableDictionary *)dict
{
    [tVateApi createImageCache:dict :@""];
}

+(UIImage*)getImagesFromCache :(NSString*)imageUrl
{
    UIImage *ReturnImage;
    
    NSString *ImageUrL = imageUrl;
    
    if ([ImageUrL isEqual:[NSNull null]])
    {
        ReturnImage=[UIImage imageNamed:@"noimage.png"];
        return ReturnImage;
        
    }
    else
    {
        UIImage *image = [tVateApi checkForImagesFromCaching:[NSURL URLWithString:ImageUrL] andFolder:kCachedImagesFolder];
        
        if (image == nil)
        {
            ReturnImage=[UIImage imageNamed:@"noimage.png"];
            
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
                     ReturnImage=imageCached;
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
#pragma mark- animations
+ (void)showBounceAnimatedView:(UIView *)popUp completionBlock:(void (^)())completion {
    popUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:0.3/1.5 animations:^{
        popUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            popUp.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                popUp.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if(completion)
                {
                    completion();
                }
            }];
        }];
    }];
}
+(NSMutableDictionary *)dietSendingDictonary :(NSArray *)SupplimentDic foodDic:(NSArray *)foodDic{
    NSMutableArray *    MainArray=[[NSMutableArray alloc]init];
    if ((SupplimentDic.count !=0 && SupplimentDic!=nil ) || ( foodDic.count !=0 && foodDic!=nil)) {
        for (int i=0;i<SupplimentDic.count+foodDic.count;i++) {
            
            if (i<SupplimentDic.count) {
                ProductRecommend *product = [SupplimentDic objectAtIndex:i];
                NSMutableDictionary *currentDic = [NSMutableDictionary dictionary];
                [currentDic setObject:[NSString stringWithFormat:@"%d",product.quantity] forKey:@"Qty"];
                [currentDic setObject:[NSString stringWithFormat:@"%i",product.uid] forKey:@"product_id"];
                [currentDic setObject:@"1" forKey:@"supplements"];
                [MainArray addObject:currentDic];
            }
            else{
                NSDictionary *currentDic = [foodDic objectAtIndex:i-SupplimentDic.count];
                NSMutableDictionary *currentDicNew = [NSMutableDictionary dictionary];
                if ([currentDic objectForKey:@"Qty"]) {
                    [currentDicNew setObject:[currentDic objectForKey:@"Qty"] forKey:@"Qty"];
                }
                else{
                    [currentDicNew setObject:@"1" forKey:@"Qty"];
                }
                
                [currentDicNew setObject:[currentDic objectForKey:@"NDB_No"] forKey:@"product_id"];
                [currentDicNew setObject:@"0" forKey:@"supplements"];

               // [currentDicNew setObject:@"1" forKey:@"supplements"];
                [MainArray addObject:currentDicNew];
            }
            
        }
      
        NSMutableDictionary *sendingDic=[NSMutableDictionary dictionary];
       [sendingDic setObject:MainArray forKey:@"Items"];
        [sendingDic setObject:@"0" forKey:@"sunday"];
        [sendingDic setObject:@"1" forKey:@"monday"];
        [sendingDic setObject:@"0" forKey:@"tuesday"];
        [sendingDic setObject:@"0" forKey:@"wednesday"];
        [sendingDic setObject:@"1" forKey:@"thursday"];
        [sendingDic setObject:@"1" forKey:@"friday"];
        [sendingDic setObject:@"0" forKey:@"saturday"];
        return sendingDic;
}
    return nil;
}
+(NSMutableDictionary *)dietCustomiseSendingDictonary :(NSArray *)SupplimentDic foodDic:(NSArray *)foodDic :(NSMutableDictionary *)sendingDic{
    NSMutableArray *    MainArray=[[NSMutableArray alloc]init];
    if ((SupplimentDic.count !=0 && SupplimentDic!=nil ) || ( foodDic.count !=0 && foodDic!=nil)) {
        for (int i=0;i<SupplimentDic.count+foodDic.count;i++) {
            
            if (i<SupplimentDic.count) {
                NSDictionary *currentDic = [SupplimentDic objectAtIndex:i];
                NSMutableDictionary *currentDicNew = [NSMutableDictionary dictionary];
                if ([currentDic objectForKey:@"quantity"]) {
                    [currentDicNew setObject:[currentDic objectForKey:@"quantity"] forKey:@"Qty"];
                }
                else{
                    [currentDicNew setObject:@"1" forKey:@"Qty"];
                }
                
                [currentDicNew setObject:[currentDic objectForKey:@"item_id"] forKey:@"product_id"];
                [currentDicNew setObject:@"1" forKey:@"supplements"];
                
                // [currentDicNew setObject:@"1" forKey:@"supplements"];
                [MainArray addObject:currentDicNew];
            }
            else{
                NSDictionary *currentDic = [foodDic objectAtIndex:i-SupplimentDic.count];
                NSMutableDictionary *currentDicNew = [NSMutableDictionary dictionary];
                if ([currentDic objectForKey:@"quantity"]) {
                    [currentDicNew setObject:[currentDic objectForKey:@"quantity"] forKey:@"Qty"];
                }
                else{
                    [currentDicNew setObject:@"1" forKey:@"Qty"];
                }
                if ([currentDic objectForKey:@"item_id"]) {
                    [currentDicNew setObject:[currentDic objectForKey:@"item_id"] forKey:@"product_id"];
                }
                else if ([currentDic objectForKey:@"NDB_No"]){
                [currentDicNew setObject:[currentDic objectForKey:@"NDB_No"] forKey:@"product_id"];
                }
                if ([currentDic objectForKey:@"kcal"]) {
                    [currentDicNew setObject:[currentDic objectForKey:@"kcal"] forKey:@"kcal"];
                }
                
                [currentDicNew setObject:@"0" forKey:@"supplements"];
                
                // [currentDicNew setObject:@"1" forKey:@"supplements"];
                [MainArray addObject:currentDicNew];
            }
            
        }
        
     
        NSMutableDictionary *sendInfoDic=[NSMutableDictionary dictionary];
        
       
        [sendInfoDic setObject:MainArray forKey:@"Items"];
        
        if ([sendingDic objectForKey:@"sunday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"sunday"] forKey:@"sunday"];
        }
        if ([sendingDic objectForKey:@"monday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"monday"] forKey:@"monday"];
        }
        if ([sendingDic objectForKey:@"tuesday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"tuesday"] forKey:@"tuesday"];
        }
        if ([sendingDic objectForKey:@"wednesday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"wednesday"] forKey:@"wednesday"];
        }
        if ([sendingDic objectForKey:@"thursday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"thursday"] forKey:@"thursday"];
        }
        if ([sendingDic objectForKey:@"friday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"friday"] forKey:@"friday"];
        }
        if ([sendingDic objectForKey:@"saturday"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"saturday"] forKey:@"saturday"];
        }
        
        if ([sendingDic objectForKey:@"weekly"]) {
            [sendInfoDic setObject:[sendingDic objectForKey:@"weekly"] forKey:@"weekly"];
        }
        
        return sendInfoDic;
    }
    return nil;
}

+(void)GetApiURL:(NSString *)url data:(NSDictionary *)dataDIC   success:(void (^)( id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   [manager GET:url parameters:dataDIC success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
       NSError *error = nil;
       NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];

       
       if (success) {
           success(json);
       }
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       if (failure) {
           failure(error);
       }
   }];
        
}
+(void)PostApiURL:(NSString *)url data:(NSDictionary *)dataDIC   success:(void (^)( id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dataDIC success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError *error = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        
        
        if (success) {
            success(json);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
+(NSMutableArray *)getDaysIntoInteger:(NSDictionary *)reviceDic{
    NSMutableArray *selectedArray=[NSMutableArray array];
    
    if ([reviceDic objectForKey:@"monday"] && [[reviceDic objectForKey:@"monday"]isEqualToString:@"1"] ) {
        [selectedArray addObject:[NSNumber numberWithInt:0]];
    }
    if ([reviceDic objectForKey:@"tuesday"] && [[reviceDic objectForKey:@"tuesday"]isEqualToString:@"1"]) {
        [selectedArray addObject:[NSNumber numberWithInt:1]];
    }
    if ([reviceDic objectForKey:@"wednesday"] && [[reviceDic objectForKey:@"wednesday"]isEqualToString:@"1"]) {
        [selectedArray addObject:[NSNumber numberWithInt:2]];
    }
    if ([reviceDic objectForKey:@"thursday"] && [[reviceDic objectForKey:@"thursday"]isEqualToString:@"1"]) {
        [selectedArray addObject:[NSNumber numberWithInt:3]];
    }
    if ([reviceDic objectForKey:@"friday"] && [[reviceDic objectForKey:@"friday"]isEqualToString:@"1"]) {
        [selectedArray addObject:[NSNumber numberWithInt:4]];
    }
    if ([reviceDic objectForKey:@"saturday"] && [[reviceDic objectForKey:@"saturday"]isEqualToString:@"1"]) {
        [selectedArray addObject:[NSNumber numberWithInt:5]];
    }
    if ([reviceDic objectForKey:@"sunday"] && [[reviceDic objectForKey:@"sunday"]isEqualToString:@"1"]) {
        [selectedArray addObject:[NSNumber numberWithInt:6]];
    }
    return selectedArray;
}
+(NSMutableArray *)updateQuantityTo1:(NSMutableArray *)sendArray{
    for (int i=0; i<sendArray.count; i++) {
        NSMutableDictionary *dic=[[sendArray objectAtIndex:i] mutableCopy];
        if ([[dic objectForKey:@"Qty"]isEqualToString:@""] || ![dic objectForKey:@"Qty"]) {
            [dic setObject:@"1" forKey:@"Qty"];
        }
        [sendArray replaceObjectAtIndex:i withObject:dic];
    }
    
    return sendArray;
}
+(NSString *)CalculateTotalCalDietPlan:(NSArray *)dietFood keyValue:(NSString *)value{
    float totalValue=0;
    for (int i=0; i<dietFood.count; i++) {
        NSDictionary *currentDic=[dietFood objectAtIndex:i];
        if( [currentDic objectForKey:value] != nil && ![[currentDic objectForKey:value] isEqual:[NSNull null]] && [currentDic objectForKey:value] != [NSNull null] && [currentDic objectForKey:value]) {
            totalValue = totalValue + [[currentDic objectForKey:value] floatValue];
        }
    }
    return [NSString stringWithFormat:@"%.2f",totalValue];
}
+(NSMutableDictionary *)removeNullFormDictionary:(NSMutableDictionary *)dictionary{
    
    NSArray *keysForNullValues = [dictionary allKeysForObject:[NSNull null]];
    for ( int i=0; i<keysForNullValues.count; i++) {
        [dictionary setObject:@"" forKey:[keysForNullValues objectAtIndex:i]];
    }
    return dictionary;
}
+(NSMutableDictionary *)dietSendingDictonary :(NSArray *)SupplimentDic foodDic:(NSArray *)foodDic mainDataDic:(NSMutableDictionary *)sendingDic{
    NSMutableArray *    MainArray=[[NSMutableArray alloc]init];
    if ((SupplimentDic.count !=0 && SupplimentDic!=nil ) || ( foodDic.count !=0 && foodDic!=nil)) {
        for (int i=0;i<SupplimentDic.count+foodDic.count;i++) {
            
            if (i<SupplimentDic.count) {
                ProductRecommend *product = [SupplimentDic objectAtIndex:i];
                NSMutableDictionary *currentDic = [NSMutableDictionary dictionary];
                [currentDic setObject:[NSString stringWithFormat:@"%d",product.quantity] forKey:@"Qty"];
                [currentDic setObject:[NSString stringWithFormat:@"%i",product.uid] forKey:@"product_id"];
                [currentDic setObject:@"0" forKey:@"kcal"];
                [currentDic setObject:@"1" forKey:@"supplements"];
                [MainArray addObject:currentDic];
            }
            else{
                NSDictionary *currentDic = [foodDic objectAtIndex:i-SupplimentDic.count];
                NSMutableDictionary *currentDicNew = [NSMutableDictionary dictionary];
                if ([currentDic objectForKey:@"Qty"]) {
                    [currentDicNew setObject:[currentDic objectForKey:@"Qty"] forKey:@"Qty"];
                }
                else{
                    [currentDicNew setObject:@"1" forKey:@"Qty"];
                }
                
                [currentDicNew setObject:[currentDic objectForKey:@"NDB_No"] forKey:@"product_id"];
                [currentDicNew setObject:@"0" forKey:@"supplements"];
                [currentDicNew setObject:[currentDic objectForKey:@"kcal"] forKey:@"kcal"];
                // [currentDicNew setObject:@"1" forKey:@"supplements"];
                [MainArray addObject:currentDicNew];
            }
            
        }
        if(sendingDic ==nil){
            sendingDic=[NSMutableDictionary dictionary];
        }
        // NSMutableDictionary *sendingDic=[NSMutableDictionary dictionary];
        [sendingDic setObject:MainArray forKey:@"Items"];
        
        if (![sendingDic objectForKey:@"sunday"]) {
            [sendingDic setObject:@"0" forKey:@"sunday"];
            
        }
        if (![sendingDic objectForKey:@"monday"]) {
            [sendingDic setObject:@"0" forKey:@"monday"];
            
        }
        if (![sendingDic objectForKey:@"tuesday"]) {
            [sendingDic setObject:@"0" forKey:@"tuesday"];
            
        }
        if (![sendingDic objectForKey:@"wednesday"]) {
            [sendingDic setObject:@"0" forKey:@"wednesday"];
            
        }
        if (![sendingDic objectForKey:@"thursday"]) {
            [sendingDic setObject:@"0" forKey:@"thursday"];
            
        }
        if (![sendingDic objectForKey:@"friday"]) {
            [sendingDic setObject:@"0" forKey:@"friday"];
            
        }
        if (![sendingDic objectForKey:@"saturday"]) {
            [sendingDic setObject:@"0" forKey:@"saturday"];
            
        }
        return sendingDic;
    }
    return nil;
}
+(NSMutableDictionary *)DictionayFormInt:(NSArray *)currentArray{
    
    NSMutableDictionary *sendingDic=[NSMutableDictionary dictionary];
    
    if ([currentArray containsObject:[NSNumber numberWithInt:0]]) {
        [sendingDic setObject:@"1" forKey:@"sunday"];
        
    }
     if ([currentArray containsObject:[NSNumber numberWithInt:1]]) {
        [sendingDic setObject:@"1" forKey:@"monday"];
        
    }
     if ([currentArray containsObject:[NSNumber numberWithInt:2]]) {
        [sendingDic setObject:@"1" forKey:@"tuesday"];
        
    }
     if ([currentArray containsObject:[NSNumber numberWithInt:3]]) {
         [sendingDic setObject:@"1" forKey:@"wednesday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:4]]) {
        [sendingDic setObject:@"1" forKey:@"thursday"];
        
    }
     if ([currentArray containsObject:[NSNumber numberWithInt:5]]) {
        [sendingDic setObject:@"1" forKey:@"friday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:6]]) {
        [sendingDic setObject:@"1" forKey:@"saturday"];
        
    }
    return sendingDic;

}
+(NSMutableDictionary *)DictionayFormDictionary:(NSArray *)currentArray  currentDic:(NSMutableDictionary *)currentDic{
    
    if (currentDic == nil) {
        currentDic=[NSMutableDictionary dictionary];
    }
   
    
    if ([currentArray containsObject:[NSNumber numberWithInt:0]]) {
        [currentDic setObject:@"1" forKey:@"sunday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:1]]) {
        [currentDic setObject:@"1" forKey:@"monday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:2]]) {
        [currentDic setObject:@"1" forKey:@"tuesday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:3]]) {
        [currentDic setObject:@"1" forKey:@"wednesday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:4]]) {
        [currentDic setObject:@"1" forKey:@"thursday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:5]]) {
        [currentDic setObject:@"1" forKey:@"friday"];
        
    }
    if ([currentArray containsObject:[NSNumber numberWithInt:6]]) {
        [currentDic setObject:@"1" forKey:@"saturday"];
        
    }
    return currentDic;
    
}

+(void)GoogleAnalyticsScreenName:(NSString *)ScreenName{

    [[GAI sharedInstance].defaultTracker send:
     [[GAIDictionaryBuilder createEventWithCategory:@"ui"
                                             action:@"open"
                                              label:@"settings"
                                              value:nil] build]];
    
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    // Set screen name on the tracker to be sent with all hits.
    [tracker set:kGAIScreenName
           value:ScreenName];
    
    // Send a screen view for "Home Screen".
    // [tracker send:[[GAIDictionaryBuilder createAppView] build]];   // Previous V3 SDK versions.
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];   // SDK Version 3.08 and up.
    
    // This event will also be sent with &cd=Home%20Screen.
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:@"menuButton"
                                                           value:nil] build]];
    
    // Clear the screen name field when we're done.
    [tracker set:kGAIScreenName
           value:nil];

}
@end
