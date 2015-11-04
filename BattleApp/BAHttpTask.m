//
//  BAHttpTask.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAHttpTask.h"

@implementation BAHttpTask

+ (id)requestJSONObjectFromURL:(NSURL *)url {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
