//
//  CSPostsPresenter.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/11/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSPostsPresenter.h"
#import "CSPost.h"
#import "CSPostTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CSPostsPresenter

- (void)configurePostTableViewCell:(CSPostTableViewCell *)cell withPost:(CSPost *)post {
    cell.captionLabel.text = post.caption;
    cell.tagsLabel.text = [self tagsStringForTags:post.tags];
    cell.notesCountLabel.text = [NSString stringWithFormat:@"%@ notes", [post.noteCount stringValue]];
    cell.timeAgoLabel.text = @"3 min ago";
    
    [cell.imgView sd_setImageWithURL:[post firstImageURL]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
}

- (NSString *)tagsStringForTags:(NSArray *)tags {
    NSString *string = @"";
    for (NSString *tag in tags) {
        string = [string stringByAppendingFormat:@"#%@", tag];
        if (tag != [tags lastObject]) {
            string = [string stringByAppendingString:@", "];
        }
    }
    return string;
}

@end
