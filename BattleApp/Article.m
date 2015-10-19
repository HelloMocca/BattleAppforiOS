
//
//  Article.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "Article.h"

@implementation Article

{
    NSString *title;
    NSString *date;
    NSString *time;
    NSString *author;
    NSString *link;
    NSString *thumbnailUrl;
    UIImage *thumbnail;
}

@synthesize title = title;
@synthesize date = date;
@synthesize time = time;
@synthesize author = author;
@synthesize link = link;
@synthesize thumbnailUrl = thumbnailUrl;
@synthesize thumbnail = thumbnail;

#pragma mark -Initialize methods
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        title = [dictionary valueForKey:@"title"];
        date = [dictionary valueForKey:@"date"];
        time = [dictionary valueForKey:@"time"];
        author = [dictionary valueForKey:@"author"];
        link = [dictionary valueForKey:@"link"];
        thumbnailUrl = [dictionary valueForKey:@"thumbnail"];
        thumbnail = nil;
    }
    return self;
}

- (UIImage *)thumbnail {
    if (thumbnail == nil) {
        thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:thumbnailUrl]]];
        if (thumbnail == nil) {
            UIImage *dummyImage;
            UIGraphicsBeginImageContext(CGSizeMake(1, 1));
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetRGBFillColor(context, 14/255.0f, 14/255.0f, 14/255.0f, 1);
            UIRectFill(CGRectMake(0, 0, 1, 1));
            dummyImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            thumbnail = dummyImage;
        }
    }
    return thumbnail;
}


@end
