//
//  CJICard.m
//  DeckOfOneCardObjectiveC
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJICard.h"

@implementation CJICard

- (instancetype) initWithImageURLString:(NSString *)imageURLString value:(NSString *)value suit:(NSString *)suit
{
    self = [super init];
    if(self){
        _imageURLString = [imageURLString copy];
        _value = [value copy];
        _suit = [suit copy];
    }
    return self;
}

- (instancetype) init
{
    return [self initWithImageURLString:@"" value:@"" suit:@""];
}

@end

@implementation CJICard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *imageURLString = dictionary[@"image"];
    NSString *value = dictionary[@"value"];
    NSString *suit = dictionary[@"suit"];
    
    return [self initWithImageURLString:imageURLString value:value suit:suit];
}

@end
