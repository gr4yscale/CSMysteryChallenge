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

@property (nonatomic, strong) CSPostTableViewCell *templateCell;

- (void)configurePostTableViewCell:(CSPostTableViewCell *)cell withPost:(CSPost *)post fetchImages:(BOOL)fetchImages;

@end
