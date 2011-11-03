//
//  SectionHeaderView.h
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UIView

@property (strong, nonatomic) NSString *title;

- (id)initWithTitle:(NSString *)title;

@end
