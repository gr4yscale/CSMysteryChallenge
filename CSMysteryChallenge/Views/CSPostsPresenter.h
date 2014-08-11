//
//  CSPostsPresenter.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/11/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

@class CSPostTableViewCell;
@class CSPost;

@interface CSPostsPresenter : NSObject

- (void)configurePostTableViewCell:(CSPostTableViewCell *)cell withPost:(CSPost *)post;

@end
