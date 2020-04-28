//
//  CJISong.m
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJISong.h"

@implementation CJISong

- (instancetype)initWithTitle:(NSString *)title artist:(NSString *)artist
{
    self = [super init];
    if(self){
        _title = title;
        _artist = artist;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[CJISong class]]) { return NO; }
    
    CJISong *song = object;
    
    if(![song.title isEqual:self.title] && song.title != self.title) { return NO; }
    if(![song.artist isEqual:self.artist] && song.artist != self.artist) { return NO; }
    
    return YES;
}

@end
