//
//  CJIPersonController.h
//  ContactsC
//
//  Created by Cameron Ingham on 7/25/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJIPerson;

@interface CJIPersonController : NSObject

+ (instancetype) sharedController;

@property (nonatomic, retain, readonly) NSArray *people;

- (void) addPerson:(CJIPerson *)person;
- (void) deletePerson:(CJIPerson *)person;

@end
