//
//  CJIPerson.h
//  ContactsC
//
//  Created by Cameron Ingham on 7/25/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJIPerson : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNumber;

- (instancetype) initWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber;

@end
