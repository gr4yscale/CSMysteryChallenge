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
#import "NSAttributedString+HTMLStyle.h"

@implementation CSPostsPresenter

- (void)configurePostTableViewCell:(CSPostTableViewCell *)cell withPost:(CSPost *)post {
    cell.tagsLabel.text = [self tagsStringForTags:post.tags];
    cell.notesCountLabel.text = [NSString stringWithFormat:@"%@ notes", [post.noteCount stringValue]];
    cell.timeAgoLabel.text = @"3 min ago";
    
    [cell.imgView sd_setImageWithURL:[post firstImageURL]
                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
    
    UIFont *font = [UIFont fontWithName:@"EuphemiaUCAS" size:16.0];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes addAttributes:@{NSFontAttributeName:font} forHTMLAttribute:QRHTMLAttributeParagraph flatten:YES];
    
    NSData *captionData = [post.caption dataUsingEncoding:NSUTF8StringEncoding];
    cell.captionLabel.attributedText = [NSAttributedString attributedStringFromHTMLData:captionData attributes:attributes];
    cell.captionLabel.alpha = 0.6;
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
