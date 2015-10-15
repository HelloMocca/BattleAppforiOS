//
//  League.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 14..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface League : NSObject

@property (nonatomic, readonly) NSString *title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
