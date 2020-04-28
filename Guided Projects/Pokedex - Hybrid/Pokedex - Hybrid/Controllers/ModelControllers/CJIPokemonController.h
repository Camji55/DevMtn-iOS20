//
//  CJIPokemonController.h
//  Pokedex - Hybrid
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CJIPokemon;

@interface CJIPokemonController : NSObject

+ (void) fetchPokemonForSearchTerm:(NSString *)searchTerm completion:(void (^) (CJIPokemon * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
