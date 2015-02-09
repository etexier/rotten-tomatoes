//
//  MovieSearchDisplayController.m
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/8/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import "MovieSearchDisplayController.h"

@implementation MovieSearchDisplayController


- (void)setActive:(BOOL)visible animated:(BOOL)animated
{
    [super setActive: visible animated: animated];
    self.displaysSearchBarInNavigationBar = NO;
    [self.searchContentsController.navigationController setNavigationBarHidden: NO animated: NO];
}

- (UINavigationController *)navigationController {
    return nil;
}

@end
