//
//  PlayerTableViewCell.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "PlayerTableViewCell.h"

@implementation PlayerTableViewCell

{
    UIImageView *thumbnailView;
    UILabel     *titleView;
    UILabel     *teamView;
    UIColor     *oddColor;
    UIColor     *evenColor;
}

@synthesize oddColor = oddColor;
@synthesize evenColor = evenColor;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        thumbnailView = [[UIImageView alloc] init];
        teamView = [[UILabel alloc] init];
        titleView = [[UILabel alloc] init];
        [self.contentView addSubview:thumbnailView];
        [self.contentView addSubview:teamView];
        [self.contentView addSubview:titleView];
        oddColor = [UIColor colorWithWhite:14/255.0f alpha:.6f];
        evenColor = [UIColor colorWithWhite:25/255.0f alpha:.6f];
    }
    return self;
}

- (void)setupWithPlayer:(Player *)player {
    CGSize size = self.contentView.frame.size;
    [thumbnailView setFrame:CGRectMake(5, 5, ((size.height-10) * (5 / 6.0f)), size.height-10)];
    [teamView setFrame:CGRectMake(thumbnailView.bounds.size.width+10, 5, size.width-(thumbnailView.bounds.size.width+20), 13)];
    [teamView setText:[player team]];
    [teamView setTextColor:[UIColor colorWithRed:0.141f green:0.592f blue:0.847f alpha:1.00f]];
    [teamView setFont:[UIFont systemFontOfSize:13]];
    [titleView setFrame:CGRectMake(thumbnailView.bounds.size.width+10, 15, size.width-(thumbnailView.bounds.size.width+20), 25)];
    [titleView setTextColor:[UIColor colorWithWhite:198/255.0f alpha:1]];
    [titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [thumbnailView setImage:[player thumbnail]];
    [titleView setText:[player playId]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
