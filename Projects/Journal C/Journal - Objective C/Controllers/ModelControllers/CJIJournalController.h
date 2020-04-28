//
//  CJIJournalController.h
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJIJournal.h"
#import "CJIEntry.h"

@interface CJIJournalController : NSObject

@property (nonatomic, strong, readonly) NSArray* journals;

+ (CJIJournalController *) sharedController;

- (void) createJournalWithName:(NSString *)name;
- (void) addEntryWithTitle:(NSString *)title timeStamp:(NSDate *)timeStamp bodyText:(NSString *)bodyText toJournal:(CJIJournal *)journal;
- (void) deleteJournal:(CJIJournal *)journal;
- (void) deleteEntry:(CJIEntry *)entry from:(CJIJournal *)journal;

@end
