//
//  BAHttpTask.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAHttpTask : NSObject

+ (void)requestJSONObjectFromURL:(NSURL *)url compeleteHandler:(void (^)(NSURLResponse* response, NSDictionary* jsonObject, NSError* connectionError)) handler asynchronous:(BOOL)async;

@end
