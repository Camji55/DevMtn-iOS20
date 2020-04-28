//
//  Journal.h
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJIEntry;

@interface CJIJournal : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong, readonly) NSArray* entries;

- (void) addEntryObject:(CJIEntry *)object;
- (void) removeEntryObject:(CJIEntry *)object;

- (instancetype) initWithName:(NSString *)name entries:(NSArray *)entries;

@end
