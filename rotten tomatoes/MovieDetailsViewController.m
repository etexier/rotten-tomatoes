//
//  MovieDetailsViewController.m
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/6/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "Helper.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *moviePoster;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterDetailed;

@property (weak, nonatomic) IBOutlet UIScrollView *movieDetails;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *criticsRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceRatingLabel;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.synopsisLabel.text = self.movie.synopsis;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ (%u)", self.movie.title, self.movie.year];
    self.ratingLabel.text = self.movie.mpaa_rating;
    self.criticsRatingLabel.text = [NSString stringWithFormat:@"Critics: %u%%", self.movie.ratings.critics_score];
    self.audienceRatingLabel.text = [NSString stringWithFormat:@"Audience: %u%%", self.movie.ratings.audience_score];
    
    NSString *url = self.movie.posters.thumbnail;

    self.moviePoster.alpha = 1;
    [self.moviePoster setImageWithURL:[NSURL URLWithString:url]];
    
    url = [url stringByReplacingOccurrencesOfString:@"_tmb.jpg" withString:@"_det.jpg"];
    
    [Helper fadeInImage:self.moviePosterDetailed url:[NSURL URLWithString:url]];
    self.title = self.movie.title;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    self.navigationItem.rightBarButtonItem = shareButton;
}

-(void)shareAction:(id)sender {
    NSArray *items =[NSArray arrayWithObjects:self.movie.title,
                     [NSNumber  numberWithInt:self.movie.year],
                     self.movie.mpaa_rating,
                     [NSString stringWithFormat:@"Score: %u%%" , self.movie.ratings.audience_score],
                      self.movie.synopsis,
                      nil];
    
    UIActivityViewController *shareVc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:shareVc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
