//
//  Thread.h
//  CodeRED
//
//  Created by Tyler Stromberg on 11/3/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Thread : NSObject

@property (copy, nonatomic) NSString *threadId;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *threadStarter;
@property (copy, nonatomic, readonly) NSMutableArray *posts;

// Designated initializer
- (id)initWithId:(NSString *)threadId title:(NSString *)threadTitle;

@end
