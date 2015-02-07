//
//  Helper.m
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/7/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import "Helper.h"
#import "UIImageView+AFNetworking.h"

@implementation Helper: NSObject
+ (void)fadeInImage:(UIImageView *)imageView url:(NSURL *)url {
    imageView.alpha = 0;
    [imageView setImageWithURL:url];
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.0];
    imageView.alpha = 1;
    [UIView commitAnimations];
}


@end
