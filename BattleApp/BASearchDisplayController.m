//
//  BASearchDisplayController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BASearchDisplayController.h"

@implementation BASearchDisplayController

- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive: visible animated: animated];
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
}

@end