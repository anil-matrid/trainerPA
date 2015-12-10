//
//  Globals.m
//  Artii
//
//  Created by Gagan Arora on 6/5/14.
//  Copyright (c) 2014 Gagandeep Arora. All rights reserved.
//
//rosterware.uimis.net/wcf
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Globals : NSObject

+(Globals*) sharedInstance;
+ (BOOL)NetworkStatus;
+ (BOOL)NetworkStatusBackground;
+(void) alert:(NSString *) message;

@property (nonatomic,retain)NSMutableDictionary *addStatsValues;
+(void)GoogleAnalyticsScreenName:(NSString *)ScreenName;
+(BOOL)validateEmailWithString:(NSString*)email;
+(BOOL)validate:(NSString *)string;
+(NSString *)urlCombile:(NSString *)DomainName ClassUrl:(NSString *)ClassUrl apiKey:(NSString *)apiKey;
+(NSString *)apiKey;
+(NSString *)urlCombileHash:(NSString *)DomainName ClassUrl:(NSString *)ClassUrl apiKey:(NSString *)apiKey ;
+(int)arrayContainIndexPath:(NSMutableArray *)TempArray currentIndex:(NSIndexPath *)indexPath;
+(NSString *)DictonaryValuesForKeys :(NSString *) CurrentValue;
+(void) saveUserImagesIntoCache:(NSMutableArray*)ResponseArray;
+(void)callMethodToCacheImage:(NSMutableDictionary *)dict;
+(UIImage*)getImagesFromCache :(NSString*)imageUrl;
+ (void)showBounceAnimatedView:(UIView *)popUp completionBlock:(void (^)())completion;
+(NSMutableDictionary *)dietSendingDictonary :(NSArray *)SupplimentDic foodDic:(NSArray *)foodDic;
+(void)PostApiURL:(NSString *)url data:(NSDictionary *)dataDIC   success:(void (^)( id responseObject))success failure:(void (^)(NSError *error))failure;
+(void)GetApiURL:(NSString *)url data:(NSDictionary *)dataDIC   success:(void (^)( id responseObject))success
         failure:(void (^)(NSError *error))failure;
+(NSMutableDictionary *)dietCustomiseSendingDictonary :(NSArray *)SupplimentDic foodDic:(NSArray *)foodDic :(NSMutableDictionary *)sendingDic;
+(NSMutableArray *)getDaysIntoInteger:(NSDictionary *)reviceDic;
+(NSMutableArray *)updateQuantityTo1:(NSMutableArray *)sendArray;
+(NSString *)CalculateTotalCalDietPlan:(NSArray *)dietFood keyValue:(NSString *)value;
+(NSMutableDictionary *)removeNullFormDictionary:(NSMutableDictionary *)dictionary;
+(NSMutableDictionary *)dietSendingDictonary :(NSArray *)SupplimentDic foodDic:(NSArray *)foodDic mainDataDic:(NSMutableDictionary *)sendingDic;
+(NSMutableDictionary *)DictionayFormInt:(NSArray *)currentArray;
+(NSMutableDictionary *)DictionayFormDictionary:(NSArray *)currentArray  currentDic:(NSMutableDictionary *)currentDic;
@end
