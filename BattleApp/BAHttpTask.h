//
//  BAHttpTask.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAHttpTask : NSObject

+ (id)requestJSONObjectFromURL:(NSURL *)url;

@end
