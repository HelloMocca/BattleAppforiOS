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
    UILabel     *raceView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        thumbnailView = [[UIImageView alloc] init];
        teamView = [[UILabel alloc] init];
        titleView = [[UILabel alloc] init];
        raceView = [[UILabel alloc] init];
        [self.contentView addSubview:raceView];
        [self.contentView addSubview:thumbnailView];
        [self.contentView addSubview:teamView];
        [self.contentView addSubview:titleView];
    }
    return self;
}

- (void)setupWithPlayer:(Player *)player {
    CGSize size = self.contentView.frame.size;
    [thumbnailView setFrame:CGRectMake(5, 5, ((size.height-10) * (5 / 6.0f)), size.height-10)];
    [teamView setFrame:CGRectMake(thumbnailView.bounds.size.width+10, 35, size.width-(thumbnailView.bounds.size.width+20), 15)];
    [teamView setText:[player team]];
    [teamView setTextColor:[UIColor silverColor]];
    [teamView setFont:[UIFont systemFontOfSize:13]];
    [titleView setFrame:CGRectMake(thumbnailView.bounds.size.width+10, 10, size.width-(thumbnailView.bounds.size.width+20), 25)];
    [titleView setTextColor:[UIColor cloudColor]];
    [titleView setFont:[UIFont boldSystemFontOfSize:20]];
    [thumbnailView setImage:[player thumbnail]];
    [titleView setText:[player playId]];
    [raceView setFrame:CGRectMake(thumbnailView.bounds.size.width+10, 50, size.width-(thumbnailView.bounds.size.width+20), 15)];
    [raceView setText:[player race]];
    [raceView setTextColor:[UIColor silverColor]];
    [raceView setFont:[UIFont systemFontOfSize:13]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
