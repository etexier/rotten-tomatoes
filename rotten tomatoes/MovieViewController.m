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
#import "Helper.h"


// implement UITableViewDataSource: self will provide the data and be its own delegate
@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) RTMoviesController *restController;
@property (nonatomic, assign) BOOL isBoxOffice;

@end

@implementation MovieViewController


- (id)initAsBoxOffice {
    if ( self = [super init] ) {
        self.restController = [[RTMoviesController alloc]init];
        self.isBoxOffice = YES;
        //    UIImage* anImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Box Office" image:[UIImage imageNamed:@"concert1.png"] tag:0];
        self.title = @"Box Office";
        return self;
    }
    return nil;
}
- (id)initAsTopRentals {
    if ( self = [super init] ) {
        self.restController = [[RTMoviesController alloc]init];
        self.isBoxOffice = NO;
        //    UIImage* anImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Top Rentals" image:[UIImage imageNamed:@"cd13.png"] tag:1];
        self.title = @"Top Rentals";
        
        return self;
    }
    return nil;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    // refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // register movie cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSLog(@"Loading....");
    [self loadData];
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
    cell.backgroundColor = [UIColor blackColor];
    cell.tintColor = [UIColor purpleColor];
    cell.titleLabel.text = movie.title;
    cell.titleLabel.backgroundColor = [UIColor blackColor];
    cell.titleLabel.textColor = [UIColor orangeColor];
    cell.synopsisLabel.text = movie.synopsis;
    cell.synopsisLabel.backgroundColor = [UIColor blackColor];
    cell.synopsisLabel.textColor = [UIColor whiteColor];
    [cell.thumbnail setImage:[UIImage imageNamed:@"film14.png"]];
    [Helper fadeInImage:cell.thumbnail url:[NSURL URLWithString:movie.posters.thumbnail]];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[Helper darkPurpleColor] ForCell:cell];  //highlight color
}
- (void) tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor blackColor] ForCell:cell];  // normal color
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieDetailsViewController * detailsVc = [[MovieDetailsViewController alloc] init];
    detailsVc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:detailsVc animated:YES];
}

#pragma mark - private

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

-(void) loadData {
    
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeBlack];
    if (self.isBoxOffice) {
        
        [self.restController getBoxOffice:@"10" country:@"us" apikey:kApiKey success:^(RTBoxOfficeResult *response) {
            NSLog(@"Response = %@", response);
            self.movies = response.movies;
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"Couldn't get Movies. Check your connection"];
        }];
    } else {
        
        [self.restController getTopRentals:@"10" country:@"us" apikey:kApiKey success:^(RTTopRentalsResult *response) {
            self.movies = response.movies;
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"Couldn't get Movies. Check your connection"];
        }];
        
    }
}

- (void)onRefresh {
    [self loadData];
    [self.refreshControl endRefreshing];
}


@end
