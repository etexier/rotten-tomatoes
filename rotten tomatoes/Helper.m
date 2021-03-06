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

+ (UIColor *) brightPurpleColor {
    return [UIColor colorWithRed:0.7 green:0.0 blue:0.7 alpha:1];

}

+ (UIColor *) darkPurpleColor {
    return [UIColor colorWithRed:0.4 green:0.0 blue:0.4 alpha:1];
    
}

+ (void)fadeInImage:(UIImageView *)imageView url:(NSURL *)url {
    imageView.alpha = 0;
    [imageView setImageWithURL:url];
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.0];
    imageView.alpha = 1;
    [UIView commitAnimations];
}


+ (void) setNavigationStyle:(UINavigationController *)controller {
    controller.navigationBar.tintColor = [Helper brightPurpleColor];
    [controller.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName :controller.navigationBar.tintColor}];
    controller.navigationBar.backgroundColor = [UIColor clearColor];
    controller.navigationBar.barStyle = UIBarStyleBlack;
    controller.navigationBar.translucent = YES;
    controller.navigationBar.alpha = 0.3f;
//    [controller.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [controller.navigationBar setShadowImage:[UIImage new]];
//    [controller setNavigationBarHidden:NO animated:YES];

}
+ (void) setTabStyle:(UITabBarController *)controller {
    controller.tabBar.barTintColor = [UIColor blackColor];
    controller.tabBar.tintColor = [Helper brightPurpleColor];
    
}

@end
