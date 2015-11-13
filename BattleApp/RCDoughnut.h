//
//  RCDoughnut.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 23..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCDoughnut : UIView

@property (nonatomic, readwrite) UILabel *titleLabel;
@property (nonatomic, readwrite) CGFloat doughnutWidth;
@property (nonatomic, getter=isNumericLabelVisible) BOOL numericLabelVisible;

- (void)setRatio:(float)ratioValue;

- (void)setTitle:(NSString *)title;

- (void)setTitleColor:(UIColor*)color;

- (void)setTitleFont:(UIFont *)font;

@end
