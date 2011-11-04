//
//  ForumViewController.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "ForumViewController.h"

#import "Forum.h"
#import "Thread.h"
#import "SlideUpProgressView.h"

@interface ForumViewController()

- (void)loadForumContentsWithPageNumber:(NSInteger)pageNumber;

@end


#pragma mark -

@implementation ForumViewController

@synthesize forum = _forum;

#pragma mark Object Lifecycle

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = _forum.title;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Load the forum contents if necessary
    // TODO: Better way to check for loaded
    if (self.forum.currentPage == 0)
    {
        [self loadForumContentsWithPageNumber:1];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UITableView DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: Split sticky/subforums/threads into separate sections?
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = _forum.threads.count;
    
    if(_forum.threads.count < _forum.totalThreads)
    {
        count++;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ThreadCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // TODO: Configure the cell
    
    return cell;
}


#pragma mark -

- (void)loadForumContentsWithPageNumber:(NSInteger)pageNumber
{
    NSParameterAssert(pageNumber > 0);
    
    // Show progress indicator
    NSLog(@"Loading...");
    SlideUpProgressView *progressView = [[SlideUpProgressView alloc] initWithFrame:CGRectZero];
    [progressView slideUpIntoView:self.view];
    
    // Disable refreshing until we're done
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    // Load the contents
    [self.forum loadPage:pageNumber withHandler:^(NSError *error) {
        NSLog(@"Loaded");
        
        // Update the table view
        [self.tableView reloadData];
        
        // Hide progress indicator
        [progressView slideOut];
        
        if (error != nil)
        {
            NSLog(@"An error occurred: %@", [error localizedDescription]);
        }
        
        // Re-enable refresh button
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (IBAction)refreshTapped:(id)sender
{
    [self.forum clearContents];
    [self.tableView reloadData];
    
    [self loadForumContentsWithPageNumber:1];
}

@end
