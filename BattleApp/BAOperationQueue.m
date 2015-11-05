//
//  BAOperationQueue.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 5..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAOperationQueue.h"

@implementation BAOperationQueue

+ (NSOperationQueue *)getOperationQueue {
    static NSOperationQueue *operationQueue = nil;
    @synchronized(self) {
        if (operationQueue == nil) {
            NSLog(@"BAOperationQueue created.");
            operationQueue = [[NSOperationQueue alloc] init];
        }
    }
    return operationQueue;
}
@end
