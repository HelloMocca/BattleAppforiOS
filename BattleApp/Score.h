//
//  Score.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 6..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property (nonatomic, readonly) int win;
@property (nonatomic, readonly) int lose;
@property (nonatomic, readonly) float rate;
@property (nonatomic, readonly) float percentage;

- (instancetype)initWithWin:(int)winCount lose:(int)loseCount;

+ (Score *)scoreWithScoreString:(NSString *)string;

@end
