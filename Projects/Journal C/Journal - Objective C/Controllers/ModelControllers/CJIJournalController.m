//
//  CJIJournalController.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIJournalController.h"

@interface CJIJournalController()

@property (nonatomic, strong) NSMutableArray* internalJournals;

@end

@implementation CJIJournalController

- (NSArray *)journals { return self.internalJournals; }

+ (CJIJournalController *) sharedController
{
    static CJIJournalController * sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [CJIJournalController new];
    });
    return sharedController;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        _internalJournals = [NSMutableArray new];
    }
    return self;
}

- (void) addEntryWithTitle:(NSString *)title timeStamp:(NSDate *)timeStamp bodyText:(NSString *)bodyText toJournal:(CJIJournal *)journal
{
    CJIEntry *myEntry = [[CJIEntry alloc] initWithTitle:title timeStamp:timeStamp bodyText:bodyText];
    [journal addEntryObject:myEntry];
}

- (void) createJournalWithName:(NSString *)name
{
    CJIJournal *myJournal = [[CJIJournal alloc] initWithName:name entries:[NSMutableArray new]];
    [self.internalJournals addObject:myJournal];
}

- (void) deleteEntry:(CJIEntry *)entry from:(CJIJournal *)journal
{
    [journal removeEntryObject:entry];
}

- (void) deleteJournal:(CJIJournal *)journal
{
    [self.internalJournals removeObject:journal];
}

@end
