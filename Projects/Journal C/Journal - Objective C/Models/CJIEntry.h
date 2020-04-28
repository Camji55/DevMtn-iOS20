//
//  Entry.h
//  Journal - Objective C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJIEntry : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSDate* timeStamp;
@property (nonatomic, copy) NSString* bodyText;

- (instancetype) initWithTitle:(NSString *)title timeStamp:(NSDate *)timeStamp bodyText:(NSString *)bodyText;

- (NSString *) getDateString;

@end
