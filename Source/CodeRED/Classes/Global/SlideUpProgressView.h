//
//  SlideUpProgressView.h
//  CodeRED
//
//  Created by Tyler Stromberg on 11/03/11.
//  Copyright 2011 Lab 42 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideUpProgressView : UIView

@property (strong, nonatomic, readonly) UILabel *statusLabel;
@property (strong, nonatomic, readonly) UIButton *stopButton;
@property (strong, nonatomic, readonly) UIProgressView *progressView;

- (void)slideUpIntoView:(UIView *)parentView;
- (void)slideOut;

@end
