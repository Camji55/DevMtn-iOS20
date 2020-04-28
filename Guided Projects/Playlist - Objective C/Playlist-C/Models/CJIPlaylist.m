//
//  CJIPlaylist.m
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPlaylist.h"

@interface CJIPlaylist()

@property (nonatomic, strong) NSMutableArray* internalSongs;

@end

@implementation CJIPlaylist

- (instancetype)initWithName:(NSString *)name songs:(NSArray *)songs
{
    self = [super init];
    
    if(self){
        _name = name;
        _internalSongs = [songs mutableCopy];
    }
    
    return self;
}

- (void)addSongsObject:(CJISong *)song
{
    [self.internalSongs addObject:song];
}

- (void)removeSongsObject:(CJISong *)song
{
    [self.internalSongs removeObject:song];
}

- (NSArray *) songs { return self.internalSongs; }

@end
