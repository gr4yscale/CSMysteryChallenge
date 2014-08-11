//
//  CSPostsDatasource.m
//  CSMysteryChallenge
//
//  Created by Tyler Powers on 8/10/14.
//  Copyright (c) 2014 Couchsurfing. All rights reserved.
//

#import "CSPostsDatasource.h"
#import "CSPost.h"
#import "CSPostTableViewCell.h"

@interface CSPostsDatasource ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation CSPostsDatasource

objection_requires_sel(@selector(managedObjectContext))

- (void)awakeFromObjection {
    [self setupFetchedResultsController];
}


#pragma mark - Private

- (void)setupFetchedResultsController {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[CSPost entityName]];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:NO]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSError *fetchError;
    [self.fetchedResultsController performFetch:&fetchError];
    NSAssert(fetchError == nil, @"Error fetching posts: %@", fetchError);
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchedResultsController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSPostTableViewCellReuseIdentifier];
    CSPost *post = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.postCaptionLabel.text = post.caption;
    return cell;
}


@end
