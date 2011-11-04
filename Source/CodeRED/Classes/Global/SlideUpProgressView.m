//
//  SlideUpProgressView.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/03/11.
//  Copyright 2011 Lab 42 Development. All rights reserved.
//

#import "SlideUpProgressView.h"

@implementation SlideUpProgressView

@synthesize statusLabel = _statusLabel;
@synthesize stopButton = _stopButton;
@synthesize progressView = _progressView;

#pragma mark Object Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)])
    {
        // Set default view properties
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.85f];
        
        // Initialize the various subviews
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        _statusLabel.text = @"Loading...";
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.opaque = NO;
        [self addSubview:_statusLabel];
        
        _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stopButton setImage:[UIImage imageNamed:@"StopLoadingButton.png"] forState:UIControlStateNormal];
        _stopButton.showsTouchWhenHighlighted = YES;
        [self addSubview:_stopButton];
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectZero];
        [self addSubview:_progressView];
    }
    
    return self;
}

#pragma mark UIView Overrides

- (void)layoutSubviews
{
    // The view is laid out as such:
    // Status
    // >>>>>>>------ (x)
    
    CGRect fullRect = self.bounds;
    CGRect topRect = CGRectZero;
    CGRect bottomRect = CGRectZero;
    
    CGRectDivide(fullRect, &topRect, &bottomRect, fullRect.size.height / 2, CGRectMinYEdge);
    
    [_statusLabel sizeToFit];
    CGRect textFrame = _statusLabel.frame;
    textFrame.origin.x = 10.0f;
    textFrame.origin.y = (topRect.size.height - textFrame.size.height) / 2 + 5.0f;
    _statusLabel.frame = textFrame;
    
    [_stopButton sizeToFit];
    CGRect buttonFrame = _stopButton.frame;
    buttonFrame.origin.x = CGRectGetMaxX(bottomRect) - buttonFrame.size.width - 10.0f;
    buttonFrame.origin.y = bottomRect.origin.y + (bottomRect.size.height - buttonFrame.size.height) / 2 - 5.0f;
    _stopButton.frame = buttonFrame;
    
    [_progressView sizeToFit];
    CGRect progressFrame = _progressView.frame;
    progressFrame.origin.x = 10.0f;
    progressFrame.origin.y = bottomRect.origin.y + (bottomRect.size.height - progressFrame.size.height) / 2 - 5.0f;
    progressFrame.size.width = CGRectGetMinX(buttonFrame) - 10.0f - progressFrame.origin.x;
    _progressView.frame = progressFrame;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    // TODO: Calculate the proper size, based on amount of text
    return CGSizeMake(320.0f, 60.0f);
}


#pragma mark -

- (void)slideUpIntoView:(UIView *)parentView
{
    // Position ourself just below the bottom edge of parentView
    CGRect startFrame = self.bounds;
    startFrame.origin.y = CGRectGetMaxY(parentView.bounds);
    self.frame = startFrame;
    
    CGRect endFrame = startFrame;
    endFrame.origin.y = CGRectGetMinY(startFrame) - startFrame.size.height;
    
    // Add ourself to parentView and animate the slide up
    [parentView addSubview:self];
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frame = endFrame;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)slideOut
{
    // Move the view to the bottom of the superview
    CGRect endFrame = self.frame;
    endFrame.origin.y = CGRectGetMaxY(self.superview.frame);
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.frame = endFrame;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

@end
