//
//  CSPostTableViewCell.h
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString *const CSPostTableViewCellReuseIdentifier;
FOUNDATION_EXTERN NSString *const CSPostTableViewCellNibName;;

@interface CSPostTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;

@end
