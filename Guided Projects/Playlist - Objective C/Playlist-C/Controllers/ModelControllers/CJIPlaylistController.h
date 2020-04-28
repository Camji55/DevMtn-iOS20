//
//  CJIPlaylistController.h
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJIPlaylist.h"
#import "CJISong.h"

@interface CJIPlaylistController : NSObject

@property (nonatomic, strong, readonly) NSArray* playlists;

+ (CJIPlaylistController *) sharedController;

- (void) createPlaylistWithName:(NSString *)name;
- (void) addSongWithTitle:(NSString *)title andArtist:(NSString *)artist toPlaylist:(CJIPlaylist *)playlist;
- (void) deletePlaylist:(CJIPlaylist *)playlist;
- (void) deleteSong:(CJISong *)song from:(CJIPlaylist *)playlist;

@end
