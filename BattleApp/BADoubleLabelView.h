//
//  BADoubleLabelView.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColorExtension.h"

@interface BADoubleLabelView : UIView

- (void)setLeftLabelText:(NSString *)text;

- (void)setRightLabelText:(NSString *)text;

- (void)setLeftLabelText:(NSString *)leftText rightLabelText:(NSString *)rightText;

@end
