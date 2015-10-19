//
//  Article.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Article : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *date;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSString *author;
@property (nonatomic, readonly) NSString *link;
@property (nonatomic, readonly) NSString *thumbnailUrl;
@property (nonatomic, readonly) UIImage *thumbnail;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
