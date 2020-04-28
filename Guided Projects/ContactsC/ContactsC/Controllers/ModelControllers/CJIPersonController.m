//
//  CJIPersonController.m
//  ContactsC
//
//  Created by Cameron Ingham on 7/25/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPersonController.h"

@interface CJIPersonController()

@property (nonatomic, retain) NSMutableArray *internalPeople;

@end

@implementation CJIPersonController

+ (instancetype)sharedController
{
    static CJIPersonController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self class] new];
    });
    return sharedController;
}

- (instancetype) init
{
    self = [super init];
    if(self){
        _internalPeople = [NSMutableArray new];
    }
    return self;
}

- (NSArray *)people { return [[self.internalPeople copy] autorelease];}

- (void)addPerson:(CJIPerson *)person
{
    [[self internalPeople] addObject:person];
}

- (void)deletePerson:(CJIPerson *)person
{
    [[self internalPeople] removeObject:person];
}

- (void)dealloc
{
    [_internalPeople release];
    [super dealloc];
}

@end
