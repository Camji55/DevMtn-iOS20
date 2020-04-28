//
//  CJIViewEntryViewController.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIViewEntryViewController.h"

@interface CJIViewEntryViewController ()

@end

@implementation CJIViewEntryViewController


- (void)viewWillAppear:(BOOL)animated
{
    self.titleLabel.text = self.entry.title;
    self.timeStampLabel.text = self.entry.getDateString;
    self.bodyTextLabel.text = self.entry.bodyText;
}

- (IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
