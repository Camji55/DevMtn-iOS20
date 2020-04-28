//
//  CJIPlaylist.h
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CJISong;

@interface CJIPlaylist : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong, readonly) NSArray* songs;

- (void) addSongsObject:(CJISong *)object;
- (void) removeSongsObject:(CJISong *)object;

- (instancetype) initWithName:(NSString *)name songs:(NSArray *)songs;

@end
