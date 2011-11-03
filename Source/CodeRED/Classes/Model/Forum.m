//
//  Forum.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "Forum.h"

@implementation Forum

@synthesize forumId = _forumId;
@synthesize title = _title;
@synthesize childForums = _childForums;

+ (Forum *)rootForum
{
    static Forum *rootForum;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"Initializing forums...");
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
    }
    
    return self;
}

@end
