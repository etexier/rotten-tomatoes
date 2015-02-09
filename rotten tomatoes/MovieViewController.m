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
@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSMutableArray *filteredMovies;
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchAction:)];
    self.navigationItem.leftBarButtonItem = searchButton;
}

-(void)searchAction:(id)sender {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor blackColor];
    
    // search bar
//    self.searchBar.backgroundImage = [UIImage new]; // transparent
    self.searchBar.tintColor = [UIColor orangeColor]; // set cursor color
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor orangeColor]]; // set text color
    self.filteredMovies = [NSMutableArray arrayWithCapacity:[self.movies count]];
    // refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // register movie cell and table view layout
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // register movie cell for search result table view and layout
    [self.searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"MovieCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor blackColor];

    self.searchDisplayController.searchResultsTableView.rowHeight = 100;
    NSLog(@"Loading....");
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.filteredMovies.count;
    } else {
        return self.movies.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RTMovie *movie;
    MovieCellTableViewCell * cell = (MovieCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell" ];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        movie = (RTMovie *) self.filteredMovies[indexPath.row];
    } else {
        movie = (RTMovie *) self.movies[indexPath.row];
    }

    
    cell.backgroundColor = [UIColor blackColor];

    cell.titleLabel.text = movie.title;
    cell.titleLabel.backgroundColor = [UIColor blackColor];
    cell.titleLabel.textColor = [UIColor orangeColor];
    cell.synopsisLabel.text = movie.synopsis;
    cell.synopsisLabel.backgroundColor = [UIColor blackColor];
    cell.synopsisLabel.textColor = [UIColor whiteColor];
    [Helper fadeInImage:cell.thumbnail url:[NSURL URLWithString:movie.posters.thumbnail]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailsViewController * detailsVc = [[MovieDetailsViewController alloc] init];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        detailsVc.movie = self.filteredMovies[indexPath.row];
    } else {
        detailsVc.movie = self.movies[indexPath.row];
    }
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:detailsVc animated:YES];
    
}

#pragma mark - Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredMovies removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[c] %@",searchText];
    self.filteredMovies = [NSMutableArray arrayWithArray:[self.movies filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    //  YES => result table view  reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // YES =>search result table view  reloaded.
    return YES;
}


#pragma mark - private

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
