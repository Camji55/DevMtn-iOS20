//
//  CJIPlaylistController.m
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPlaylistController.h"

@interface CJIPlaylistController()

@property (nonatomic, strong) NSMutableArray* internalPlatlists;

@end

@implementation CJIPlaylistController

- (NSArray *)playlists { return self.internalPlatlists; }

+ (CJIPlaylistController *)sharedController
{
    static CJIPlaylistController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [CJIPlaylistController new];
    });
    return sharedController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalPlatlists = [NSMutableArray new];
    }
    return self;
}

- (void)addSongWithTitle:(NSString *)title andArtist:(NSString *)artist toPlaylist:(CJIPlaylist *)playlist
{
    CJISong *mySong = [[CJISong alloc] initWithTitle:title artist:artist];
    [playlist addSongsObject:mySong];
}

- (void)createPlaylistWithName:(NSString *)name
{
    CJIPlaylist *myPlaylist = [[CJIPlaylist alloc] initWithName:name songs:[NSMutableArray new]];
    [self.internalPlatlists addObject:myPlaylist];
}

- (void)deleteSong:(CJISong *)song from:(CJIPlaylist *)playlist
{
    [playlist removeSongsObject:song];
}

- (void)deletePlaylist:(CJIPlaylist *)playlist
{
    [self.internalPlatlists removeObject:playlist];
}

@end
