//
//  MovieCellTableViewCell.m
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/4/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import "MovieCellTableViewCell.h"
#import "Helper.h"

@implementation MovieCellTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[Helper darkPurpleColor]]; // set color here
    [self setSelectedBackgroundView:selectedBackgroundView];
}

@end
