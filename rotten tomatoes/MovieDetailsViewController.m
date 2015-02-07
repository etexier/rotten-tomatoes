//
//  MovieDetailsViewController.m
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/6/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;

@property (weak, nonatomic) IBOutlet UIScrollView *movieDetails;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    NSString *url = [self.movie valueForKeyPath:@"posters.detailed"];
    url = [url stringByReplacingOccurrencesOfString:@"_tmb.jpg" withString:@"_det.jpg"];
    
    [self.moviePoster setImageWithURL:[NSURL URLWithString:url]];
    self.title = self.movie[@"title"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
