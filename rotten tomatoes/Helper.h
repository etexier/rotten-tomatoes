//
//  Helper.h
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/7/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Helper : NSObject
+ (UIColor *) darkPurpleColor;
+ (UIColor *) brightPurpleColor;
+ (void) fadeInImage:(UIImageView *)imageView url:(NSURL *) url;
+ (void) setNavigationStyle:(UINavigationController *)controller;
+ (void) setTabStyle:(UITabBarController *)controller;


@end
