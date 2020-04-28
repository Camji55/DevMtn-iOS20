//
//  CJICardController.h
//  DeckOfOneCardObjectiveC
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJICard;

@interface CJICardController : NSObject

+ (void) fetchNewCardWithCompletion:(void (^) (CJICard *))completion;
+ (void) cardImageFromCard:(CJICard *)card completion:(void (^) (UIImage *))completion;

@end
