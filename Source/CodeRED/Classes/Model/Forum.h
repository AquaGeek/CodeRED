//
//  Forum.h
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Forum : NSObject

@property (copy, nonatomic) NSString *forumId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic, readonly) NSMutableArray *childForums;
@property (copy, nonatomic, readonly) NSMutableArray *threads;
@property (assign, nonatomic) NSInteger totalThreads;

+ (Forum *)rootForum;

// Designated initializer
- (id)initWithTitle:(NSString *)title;

@end
