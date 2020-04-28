//
//  CJICard.h
//  DeckOfOneCardObjectiveC
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJICard : NSObject

@property (nonatomic, copy, readonly) NSString *imageURLString;
@property (nonatomic, copy, readonly) NSString *value;
@property (nonatomic, copy, readonly) NSString *suit;

- (instancetype) initWithImageURLString:(NSString *)imageURLString value:(NSString *)value suit:(NSString *)suit NS_DESIGNATED_INITIALIZER;

@end

@interface CJICard (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary <NSString *, id> *)dictionary;

@end
