
//
//  CJIPokemon.m
//  Pokedex - Hybrid
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPokemon.h"

@implementation CJIPokemon

- (instancetype) initWithName:(NSString *)name number:(NSInteger)number ablilites:(NSArray<NSString *> *)ablilites
{
    self = [super init];
    if(self){
        _name = [name copy];
        _number = number;
        _abilities = [ablilites copy];
    }
    return self;
}

- (instancetype) init
{
    return [self initWithName:@"" number:0 ablilites:@[]];
}

@end

@implementation CJIPokemon (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    NSString *name = dictionary[@"name"];
    NSInteger number = [dictionary[@"id"] integerValue];
    NSArray *abilitiesDictionaryArray = dictionary[@"abilities"];
    
    NSMutableArray<NSString *> *abilities = [NSMutableArray new];
    
    for (NSDictionary *abilityDictionary in abilitiesDictionaryArray){
        NSDictionary *nestedDictionary= abilityDictionary[@"ability"];
        NSString *abilityName = nestedDictionary[@"name"];
        [abilities addObject:abilityName];
    }
    
    return [self initWithName:name number:number ablilites:abilities];
}

@end
