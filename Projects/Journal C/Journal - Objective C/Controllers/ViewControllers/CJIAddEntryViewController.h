//
//  CJIAddEntryViewController.h
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJIAddEntryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;

@property (nonatomic) NSString* entryTitle;
@property (nonatomic) NSString* entryBody;

- (IBAction)cancelEntry:(id)sender;

@end
