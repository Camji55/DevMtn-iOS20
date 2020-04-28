//
//  CJIPerson.m
//  ContactsC
//
//  Created by Cameron Ingham on 7/25/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPerson.h"

@implementation CJIPerson

- (instancetype)initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber
{
    self = [super init];
    if(self){
        _name = [name copy];
        _phoneNumber = [phoneNumber copy];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_phoneNumber release];
    [super dealloc];
}

@end
