//
//  BADoubleLabelView.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BADoubleLabelView.h"

@implementation BADoubleLabelView

{
    UILabel *leftLabel;
    UILabel *rightLabel;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    leftLabel = [[UILabel alloc] init];
    [self addSubview:leftLabel];
    rightLabel = [[UILabel alloc] init];
    [self addSubview:rightLabel];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [leftLabel setFrame:CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height)];
    [leftLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [leftLabel setTextColor:[UIColor baOrangeColor]];
    [rightLabel setFrame:CGRectMake(self.frame.size.width/2, 0, self.frame.size.width/2, self.frame.size.height)];
    [rightLabel setFont:[UIFont systemFontOfSize:12]];
    [rightLabel setTextColor:[UIColor cloudColor]];
}

- (void)setLeftLabelText:(NSString *)text {
    if (leftLabel == nil) return;
    [leftLabel setText:text];
}

- (void)setRightLabelText:(NSString *)text {
    if (rightLabel == nil) return;
    [rightLabel setText:text];
}

- (void)setLeftLabelText:(NSString *)leftText rightLabelText:(NSString *)rightText {
    [self setLeftLabelText:leftText];
    [self setRightLabelText:rightText];
}

@end
