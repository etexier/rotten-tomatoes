//
//  MovieCellTableViewCell.h
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/4/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@end