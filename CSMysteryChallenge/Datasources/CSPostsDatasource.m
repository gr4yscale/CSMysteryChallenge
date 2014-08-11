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
#import "CSPostsPresenter.h"

@interface CSPostsDatasource ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) CSPostsPresenter *postsPresenter;

@end

@implementation CSPostsDatasource

objection_requires_sel(@selector(managedObjectContext),
                       @selector(postsPresenter))

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
    self.fetchedResultsController.delegate = self;
    
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
    [self.postsPresenter configurePostTableViewCell:cell withPost:post fetchImages:YES];
    return cell;
}


#pragma UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSPost *post = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CSPostTableViewCell *templateCell = self.postsPresenter.templateCell;
    [self.postsPresenter configurePostTableViewCell:templateCell withPost:post fetchImages:NO];
    
    // unable to get a non-zero value out of [templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    // so...resorting to hacks :(
    
    CGSize captionLabelSize = [templateCell.captionLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize tagLabelSize = [templateCell.tagsLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    CGFloat dynamicHeights = captionLabelSize.height + tagLabelSize.height + templateCell.imgViewHeightConstraint.constant;
    return dynamicHeights + 97;
}


#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
