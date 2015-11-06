//
//  Record.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 6..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Score.h"

@interface Record : NSObject

@property (nonatomic, readonly) Score *total;
@property (nonatomic, readonly) Score *recent5;
@property (nonatomic, readonly) Score *vsTerran;
@property (nonatomic, readonly) Score *vsZerg;
@property (nonatomic, readonly) Score *vsProtoss;
@property (nonatomic, readonly) NSArray *games;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
