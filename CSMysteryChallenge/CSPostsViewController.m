//
//  CSPostsViewController.m
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSPostsViewController.h"
#import "CSDataAccess.h"
#import "CSPostsDataSource.h"
#import "CSPostTableViewCell.h"

@interface CSPostsViewController ()

@property (nonatomic, strong) CSDataAccess *dataAccess;
@property (nonatomic, strong) CSPostsDatasource *postsDatasource;

@property (nonatomic, assign) NSUInteger postsPageOffset;
@property (nonatomic, assign) BOOL fetchingMorePosts;

@end

@implementation CSPostsViewController

objection_requires_sel(@selector(dataAccess),
                       @selector(postsDatasource))

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [[JSObjection defaultInjector] injectDependencies:self];
    
    [self setupTableView];
    
    [self fetchMorePosts];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (NSString *)nibName {
    return @"CSPostsViewController";
}


#pragma mark - Private

- (void)setupTableView {
    self.tableView.delegate = self;
    self.postsDatasource.tableView = self.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self.postsDatasource;
    [self.tableView registerNib:[UINib nibWithNibName:CSPostTableViewCellNibName bundle:nil] forCellReuseIdentifier:CSPostTableViewCellReuseIdentifier];
    [self.tableView reloadData];
}


- (void)fetchMorePosts {
    if (self.fetchingMorePosts) return;
    self.fetchingMorePosts = YES;
    @weakify(self);
    [self.dataAccess fetchPostsAtOffset:self.postsPageOffset pageSize:20 completion:^(id response, NSError *error) {
        @strongify(self);
        NSLog(@"fetched posts at offset: %@", @(self.postsPageOffset));
        self.fetchingMorePosts = NO;
        self.postsPageOffset += 1;
    }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.postsDatasource tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
