//
//  BAHttpTask.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAHttpTask.h"

@implementation BAHttpTask

+ (void)requestJSONObjectFromURL:(NSURL *)url compeleteHandler:(void (^)(NSURLResponse* response, NSDictionary* jsonObject, NSError* connectionError)) handler {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [BAHttpTask didRequestCompleteWithData:data withHandler:handler];
    }];
    [task resume];
}

+ (void)didRequestCompleteWithData:(NSData *)data withHandler:(void (^)(NSURLResponse* response, NSDictionary* jsonObject, NSError* connectionError))handler {
    NSDictionary *jsonObject;
    if (data != nil) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NO error:nil];
    }
    handler(nil, jsonObject, nil);
}

@end
