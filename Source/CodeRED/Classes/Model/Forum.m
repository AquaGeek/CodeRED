//
//  Forum.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "Forum.h"

#import "AFHTTPClient.h"

@interface Forum()

- (void)parseContentData:(NSData *)data;

@end


#pragma mark -

@implementation Forum

@synthesize forumId = _forumId;
@synthesize title = _title;
@synthesize childForums = _childForums;
@synthesize threads = _threads;
@synthesize totalThreads = _totalThreads;
@synthesize currentPage = _currentPage;

#pragma mark -

+ (Forum *)rootForum
{
    static Forum *rootForum;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Initialize the root forum
        rootForum = [[Forum alloc] initWithTitle:@"REDUSER"];
        
        // Parse the forum plist
        NSString *forumPlistPath = [[NSBundle mainBundle] pathForResource:@"ForumStructure" ofType:@"plist"];
        NSArray *forumStructure = [NSArray arrayWithContentsOfFile:forumPlistPath];
        
        for (NSDictionary *topLevelForum in forumStructure)
        {
            // Add the top-level forum
            NSString *titleKey = [topLevelForum valueForKey:@"title"];
            Forum *newForum = [[Forum alloc] initWithTitle:NSLocalizedString(titleKey, @"")];
            
            // Loop through the forum's child forums
            for(NSDictionary *childForumDict in [topLevelForum valueForKey:@"children"])
            {
                NSString *childTitleKey = [childForumDict valueForKey:@"title"];
                Forum *childForum = [[Forum alloc] initWithTitle:NSLocalizedString(childTitleKey, @"")];
                childForum.forumId = [childForumDict valueForKey:@"id"];
                
                [newForum.childForums addObject:childForum];
            }
            
            [rootForum.childForums addObject:newForum];
        }
    });
    
    return rootForum;
}

- (id)init
{
    return [self initWithTitle:@""];
}

- (id)initWithTitle:(NSString *)title
{
    if ((self = [super init]))
    {
        _title = [title copy];
        _childForums = [[NSMutableArray alloc] init];
        _threads = [[NSMutableArray alloc] init];
    }
    
    return self;
}


#pragma mark -

- (void)loadPage:(NSInteger)pageNumber withHandler:(void (^)(NSError *error))completionHandler
{
    NSParameterAssert(completionHandler != NULL);
    NSParameterAssert(pageNumber > 0);
    
    // Load the page from RedUser.net
    // TODO: Use new URL format
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://reduser.net/forum/"]];
    [client getPath:@"forumdisplay.php"
         parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.forumId, @"f", @"desc", @"order",
                     [NSString stringWithFormat:@"%d", pageNumber], @"page", nil]
            success:^(id object)
     {
         // Success! Off to the races...
         [self parseContentData:object];
         
         self.currentPage = pageNumber;
         completionHandler(nil);
     }
            failure:^(NSHTTPURLResponse *response, NSError *error)
     {
         completionHandler(error);
     }];
}

- (void)parseContentData:(NSData *)data
{
    // TODO: Set up a bunch of RegExps to pull out the threads
    NSLog(@"Data: %@", data);
}

- (void)clearContents
{
    [_threads removeAllObjects];
    _totalThreads = 0;
    _currentPage = 0;
}

@end
