//
//  BAHttpTask.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAHttpTask.h"

@implementation BAHttpTask

+ (void)requestJSONObjectFromURL:(NSURL *)url compeleteHandler:(void (^)(NSURLResponse* response, NSDictionary* jsonObject, NSError* connectionError)) handler asynchronous:(BOOL)async{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (async) {
        NSOperationQueue *queue = [BAOperationQueue getOperationQueue];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse* response, NSData* data, NSError* connectionError){
            [BAHttpTask didRequestCompleteWithData:data withHandler:handler];
        }];
    } else {
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        [BAHttpTask didRequestCompleteWithData:data withHandler:handler];
    }
}

+ (void)didRequestCompleteWithData:(NSData *)data withHandler:(void (^)(NSURLResponse* response, NSDictionary* jsonObject, NSError* connectionError))handler {
    NSDictionary *jsonObject;
    if (data != nil) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NO error:nil];
    }
    handler(nil, jsonObject, nil);
}

@end
