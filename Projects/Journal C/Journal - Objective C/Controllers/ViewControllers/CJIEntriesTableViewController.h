//
//  CJIEntriesTableViewController.h
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJIJournal;

@interface CJIEntriesTableViewController : UITableViewController

@property (nonatomic, strong) CJIJournal* journal;

- (IBAction)unwindToEntryList:(UIStoryboardSegue *)sender;

@end
