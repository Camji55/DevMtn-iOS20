//
//  Journal.m
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIJournal.h"

@interface CJIJournal()

@property (nonatomic, strong) NSMutableArray* internalEntries;

@end

@implementation CJIJournal

- (instancetype)initWithName:(NSString *)name entries:(NSArray *)entries
{
    self = [super init];
    if(self){
        _name = name;
        _internalEntries = [entries mutableCopy];
    }
    return self;
}

- (void) addEntryObject:(CJIEntry *)entry
{
    [self.internalEntries addObject:entry];
}

- (void) removeEntryObject:(CJIEntry *)entry
{
    [self.internalEntries removeObject:entry];
}

- (NSArray *) entries { return self.internalEntries; }

@end
