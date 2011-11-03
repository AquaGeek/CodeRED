//
//  AboutViewController.m
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

@synthesize versionLabel = _versionLabel;

#pragma mark Object Lifecycle

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Populate the version label
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict valueForKey:@"CFBundleShortVersionString"];
    NSString *build = [infoDict valueForKey:(id)kCFBundleVersionKey];
    
    self.versionLabel.text = [NSString stringWithFormat:@"v%@ (build %@)", version, build];
}

- (void)viewDidUnload
{
    self.versionLabel = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
