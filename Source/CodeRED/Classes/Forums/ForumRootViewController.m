//
//  ForumRootViewController.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "ForumRootViewController.h"

#import "Forum.h"
#import "ForumViewController.h"
#import "SectionHeaderView.h"

@interface ForumRootViewController()

- (Forum *)childForumAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@implementation ForumRootViewController

@synthesize footerView = _footerView;


#pragma mark - Object Lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = _footerView;
}

- (void)viewDidUnload
{
    self.footerView = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -

- (Forum *)childForumAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Sanity check
    Forum *parentForum = [[Forum rootForum].childForums objectAtIndex:indexPath.section];
    Forum *childForum = [parentForum.childForums objectAtIndex:indexPath.row];
    
    return childForum;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ForumDetail"])
    {
        Forum *selectedForum = [self childForumAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        if (selectedForum != nil)
        {
            // Pass the selected forum to the next view controller
            ForumViewController *forumVC = segue.destinationViewController;
            forumVC.forum = selectedForum;
        }
    }
}


#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [Forum rootForum].childForums.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    Forum *currentForum = [[Forum rootForum].childForums objectAtIndex:section];
    SectionHeaderView *headerView = [[SectionHeaderView alloc] initWithTitle:currentForum.title];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Forum *childForum = [[Forum rootForum].childForums objectAtIndex:section];
    return childForum.childForums.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ForumCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Forum *childForum = [self childForumAtIndexPath:indexPath];
    cell.textLabel.text = childForum.title;
    
    return cell;
}

@end
