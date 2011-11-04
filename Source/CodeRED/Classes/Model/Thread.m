//
//  Thread.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/3/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "Thread.h"

@implementation Thread

@synthesize threadId = _threadId;
@synthesize title = _title;
@synthesize threadStarter = _threadStarter;
@synthesize posts = _posts;

- (id)init
{
    return [self initWithId:nil title:nil];
}

- (id)initWithId:(NSString *)threadId title:(NSString *)threadTitle
{
    if ((self = [super init]))
    {
        _threadId = [threadId copy];
        _title = [threadTitle copy];
        _posts = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
