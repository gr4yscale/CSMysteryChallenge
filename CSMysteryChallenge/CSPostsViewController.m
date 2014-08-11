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

@end

@implementation CSPostsViewController

objection_requires_sel(@selector(dataAccess),
                       @selector(postsDatasource))

- (void)viewDidLoad {
	[super viewDidLoad];
    
    [[JSObjection defaultInjector] injectDependencies:self];
    
    self.tableView.dataSource = self.postsDatasource;
    [self.tableView registerNib:[UINib nibWithNibName:CSPostTableViewCellNibName bundle:nil] forCellReuseIdentifier:CSPostTableViewCellReuseIdentifier];
    [self.tableView reloadData];
    
    [self.dataAccess fetchPostsAtOffset:0 pageSize:20 completion:^(id response, NSError *error) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (NSString *)nibName {
    return @"CSPostsViewController";
}

@end
