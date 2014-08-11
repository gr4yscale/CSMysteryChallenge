//
//  CSPostsViewController.m
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSPostsViewController.h"
#import "CSDataAccess.h"

@interface CSPostsViewController ()
@property (nonatomic, strong) CSDataAccess *dataAccess;

@end

@implementation CSPostsViewController

objection_requires_sel(@selector(dataAccess))

- (void)viewDidLoad {
	[super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [[JSObjection defaultInjector] injectDependencies:self];
    
    [self.dataAccess fetchPostsAtOffset:0 pageSize:20 completion:^(id response, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
