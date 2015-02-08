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


+ (void) setNavigationStyle:(UINavigationController *)controller {
    controller.navigationBar.barTintColor = [UIColor blackColor];
    controller.navigationBar.tintColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.7 alpha:1] ;
    [controller.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName :controller.navigationBar.tintColor}];
    controller.navigationBar.translucent = YES;

}
+ (void) setTabStyle:(UITabBarController *)controller {
    controller.tabBar.barTintColor = [UIColor blackColor];
    controller.tabBar.tintColor = [UIColor colorWithRed:0.7 green:0.0 blue:0.7 alpha:1];
//    [controller.tabBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    controller.tabBar.translucent = YES;
    
}

@end
