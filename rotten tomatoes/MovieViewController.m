//
//  MovieViewController.m
//  rotten tomatoes
//
//  Created by Emmanuel Texier on 2/4/15.
//  Copyright (c) 2015 Emmanuel Texier. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCellTableViewCell.h"
#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Constants.h"
#import "RTHeader.h"



// implement UITableViewDataSource: self will provide the data and be its own delegate
@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) RTMoviesController *restController;

@end

@implementation MovieViewController

- (id)init {
    if ( self = [super init] ) {
        self.restController = [[RTMoviesController alloc]init];
        return self;
    }
    return nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
    // register movie cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 100;
    NSLog(@"Loading....");
    [self loadData];
    self.title = @"Movies";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    RTMovie *movie = (RTMovie *) self.movies[indexPath.row];
    cell.titleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.thumbnail.alpha = 0;
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:movie.posters.thumbnail]];
    [UIView beginAnimations:@"fade in" context:nil];
    [UIView setAnimationDuration:1.0];
    cell.thumbnail.alpha = 1;
    [UIView commitAnimations];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailsViewController * detailsVc = [[MovieDetailsViewController alloc] init];
    detailsVc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

#pragma mark - private

-(void) loadData {
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    [self.restController getBoxOffice:@"10" country:@"us" apikey:kApiKey success:^(RTBoxOfficeResult *response) {
       NSLog(@"Response = %@", response);
        self.movies = response.movies;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Couldn't get Movies. Check your connection"];
    }];
}

- (void)onRefresh {
    [self loadData];
    [self.refreshControl endRefreshing];
}


@end
