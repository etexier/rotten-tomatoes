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



// implement UITableViewDataSource: self will provide the data and be its own delegate
@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) SVProgressHUD *hud;

@end

static NSString *getMoviesString = kRottenTomatoesUrl;

@implementation MovieViewController



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
    
        NSString *url = getMoviesString;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
                             
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                               self.movies = json[@"movies"];
                               NSLog(@"response: %@", self.movies);
                               NSLog(@"count: %lu", self.movies.count);
        
                               // reload data
                               [self.tableView reloadData];
    }];
    
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

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSLog(@"# of sections: %lu", self.movies.count);
//    return self.movies.count;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.row];
    NSString *url = [movie valueForKeyPath:@"posters.thumbnail"];
    NSString *title = [movie valueForKey:@"title"];
    NSString *synopsis = [movie valueForKey:@"synopsis"];
    
    cell.titleLabel.text = title;
    cell.synopsisLabel.text = synopsis;
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:url]];

    NSLog(@"synopsis: %@", synopsis);
    NSLog(@"title: %@", title);
    NSLog(@"URL: %@", url);
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailsViewController * vc = [[MovieDetailsViewController alloc] init];
    vc.movie = self.movies[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - private

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:getMoviesString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        [self.refreshControl endRefreshing];
    }];
}


@end
