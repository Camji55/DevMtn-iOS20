//
//  CJICardController.m
//  DeckOfOneCardObjectiveC
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJICardController.h"
#import "CJICard.h"

@implementation CJICardController

+ (void)fetchNewCardWithCompletion:(void (^)(CJICard *))completion
{
    NSURL *url = [NSURL URLWithString:@"https://deckofcardsapi.com/api/deck/new/draw"];
    
    NSMutableURLRequest *requestURL = [NSMutableURLRequest requestWithURL:url];
    [requestURL setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error || !data){
            NSLog(@"There was an error loading the data: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSDictionary *cardDictionary = [jsonDictionary[@"cards"] firstObject];
        
        CJICard *card = [[CJICard alloc] initWithDictionary:cardDictionary];
        completion(card);
        
    }];
    [dataTask resume];
    
}

+ (void)cardImageFromCard:(CJICard *)card completion:(void (^)(UIImage *))completion
{
    NSURL *url = [NSURL URLWithString:card.imageURLString];
    
    NSMutableURLRequest *requestURL = [NSMutableURLRequest requestWithURL:url];
    [requestURL setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:requestURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error || !data){
            NSLog(@"There was an error loading the image: %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        UIImage *cardImage = [UIImage imageWithData:data];
        
        completion(cardImage);
        
    }];
    [dataTask resume];
}

@end
