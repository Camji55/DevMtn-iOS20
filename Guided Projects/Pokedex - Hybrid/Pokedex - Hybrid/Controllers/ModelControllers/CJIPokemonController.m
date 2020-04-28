//
//  CJIPokemonController.m
//  Pokedex - Hybrid
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPokemonController.h"
#import "Pokedex___Hybrid-Swift.h"
#import "CJIPokemon.h"

static NSString *const baseURLString = @"http://pokeapi.co/api/v2/pokemon";

@implementation CJIPokemonController

+ (void)fetchPokemonForSearchTerm:(NSString *)searchTerm completion:(void (^)(CJIPokemon *))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:searchTerm];
    //NSLog(@"%@", searchURL);
 
    [NetworkController performRequestFor:searchURL httpMethod:@"GET" urlParameters:nil body:nil completion:^(NSData *data, NSError *error) {
        if(error || !data){
            NSLog(@"Error getting pokemon for search term: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        CJIPokemon *pokemon = [[CJIPokemon alloc] initWithDictionary:jsonDictionary];
        completion(pokemon);
    }];
    
}

@end
