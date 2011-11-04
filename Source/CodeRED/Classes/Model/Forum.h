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
@property (assign, nonatomic) NSInteger currentPage;

+ (Forum *)rootForum;

// Designated initializer
- (id)initWithTitle:(NSString *)title;
- (void)loadPage:(NSInteger)pageNumber withHandler:(void (^)(NSError *error))completionHandler;
- (void)clearContents;

@end
