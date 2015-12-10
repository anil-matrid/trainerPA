//
//  WebService.m
//  TrainerVate
//
//  Created by Pankaj Khatri on 12/09/15.
//  Copyright (c) 2015 Matrid. All rights reserved.
//

#import "WebService.h"

@implementation WebService
+(void)POSTAFNetworkign:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)( NSError *error))failure{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end

