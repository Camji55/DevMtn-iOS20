//
//  CJIPokemon.h
//  Pokedex - Hybrid
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJIPokemon : NSObject

- (instancetype) initWithName:(NSString *)name number:(NSInteger)number ablilites:(NSArray<NSString *> *)ablilites NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) NSInteger number;
@property (nonatomic, copy, readonly) NSArray<NSString *> *abilities;

@end

@interface CJIPokemon (JSONConvertable)

- (instancetype) initWithDictionary:(NSDictionary <NSString *, id> *)dictionary;

@end
