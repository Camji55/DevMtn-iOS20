//
//  CJIAddEntryViewController.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIAddEntryViewController.h"

@interface CJIAddEntryViewController ()

@end

@implementation CJIAddEntryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.entryTitle = @"";
    self.entryBody = @"";

    self.bodyTextView.text = @"Your journal entry goes here...";
    self.bodyTextView.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    
}

- (bool) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if(![self.titleTextField.text isEqualToString:@""] && ![self.bodyTextView.text isEqualToString:@""])
    {
        self.entryTitle = self.titleTextField.text;
        self.entryBody = self.bodyTextView.text;
        return YES;
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Uh oh" message:@"Are you need give this entry a title and a body" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
}

- (IBAction)cancelEntry:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cancel Entry" message:@"Are you sure you want to cancel this entry?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDestructive handler:nil];
    
    [alert addAction:action];
    [alert addAction:noAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
