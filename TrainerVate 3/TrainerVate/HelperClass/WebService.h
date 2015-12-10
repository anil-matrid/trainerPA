//
//  WebService.h
//  TrainerVate
//
//  Created by Pankaj Khatri on 12/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface WebService : NSObject
+(void)POSTAFNetworkign:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure;
@end
