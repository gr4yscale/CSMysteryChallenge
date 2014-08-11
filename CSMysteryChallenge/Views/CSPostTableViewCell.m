//
//  CSPostTableViewCell.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSPostTableViewCell.h"

NSString *const CSPostTableViewCellReuseIdentifier = @"CSPostTableViewCellReuseIdentifier";
NSString *const CSPostTableViewCellNibName = @"CSPostTableViewCell";


@implementation CSPostTableViewCell

- (void)addShadow {
    self.imgView.layer.masksToBounds = NO;
    self.imgView.layer.shadowOffset = CGSizeZero;
    self.imgView.layer.shadowRadius = 2.0;
    self.imgView.layer.shadowOpacity = 0.6;
    self.imgView.layer.shouldRasterize = YES;
    self.imgView.layer.rasterizationScale = 2.0;
}

@end
