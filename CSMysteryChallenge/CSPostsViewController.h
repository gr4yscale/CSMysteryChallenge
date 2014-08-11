//
//  CSViewController.h
//  CSMysteryChallenge
//
//  Created by Gemma Barlow on 1/9/13.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPostsView.h"

@interface CSPostsViewController : UIViewController

@property (weak, nonatomic) IBOutlet CSPostsView *postsView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
