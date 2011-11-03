//
//  AboutViewController.h
//  CodeRED
//
//  Created by Tyler Stromberg on 11/2/11.
//  Copyright (c) 2011 Lab 42 Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)glyphishTapped:(id)sender;

@end
