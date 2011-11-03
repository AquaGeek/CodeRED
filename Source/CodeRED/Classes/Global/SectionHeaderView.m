//
//  SectionHeaderView.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

@synthesize title = _title;

- (id)initWithTitle:(NSString *)title
{
    if ((self = [self initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 22.0f)]))
    {
        _title = [title copy];
        self.backgroundColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGRect bounds = self.bounds;
    
    [[UIColor whiteColor] set];
    [_title drawInRect:CGRectInset(bounds, 10.0f, 0.0f)
              withFont:[UIFont boldSystemFontOfSize:16.0f]];
}

@end
