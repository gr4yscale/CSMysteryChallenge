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

- (instancetype)init {
    self = [super init];
    if (self) {
        self.templateCell = [[[UINib nibWithNibName:CSPostTableViewCellNibName bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    }
    return self;
}

- (void)configurePostTableViewCell:(CSPostTableViewCell *)cell withPost:(CSPost *)post fetchImages:(BOOL)fetchImages {
    cell.tagsLabel.text = [self tagsStringForTags:post.tags];
    cell.notesCountLabel.text = [NSString stringWithFormat:@"%@ notes", [post.noteCount stringValue]];
    cell.timeAgoLabel.text = @"3 min ago";
    
    if (fetchImages) {
        [cell.imgView sd_setImageWithURL:[post firstImageURL]
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {}];
    }
    
    CGFloat value = [self heightForImageViewWithPost:post withCell:cell];
    if (isnan(value)) {
        cell.imgViewHeightConstraint.constant = 0;
    } else {
        cell.imgViewHeightConstraint.constant = value;
    }
    [cell setNeedsUpdateConstraints];
    
    UIFont *font = [UIFont fontWithName:@"EuphemiaUCAS" size:16.0];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes addAttributes:@{NSFontAttributeName:font} forHTMLAttribute:QRHTMLAttributeParagraph flatten:YES];
    
    NSData *captionData = [post.caption dataUsingEncoding:NSUTF8StringEncoding];
    cell.captionLabel.attributedText = [NSAttributedString attributedStringFromHTMLData:captionData attributes:attributes];
    cell.captionLabel.alpha = 0.6;
    
    [cell addShadow];
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

- (CGFloat)heightForImageViewWithPost:(CSPost *)post withCell:(CSPostTableViewCell *)cell {
    CGSize originalSize = [post sizeForFirstImage];
    
    if (originalSize.height == 0) {
        return 0.0;
    }
    
    CGFloat height = 0;
    CGSize newSize = cell.imgView.frame.size;
    CGFloat scaleFactor = newSize.width / originalSize.width;
    
    if (originalSize.width > newSize.width) {
        height = originalSize.height * scaleFactor;
    } else {
        height = originalSize.height / scaleFactor;
    }
    return height;
}

@end
