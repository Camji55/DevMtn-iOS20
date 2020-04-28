//
//  CJISong.h
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJISong : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* artist;

- (instancetype) initWithTitle:(NSString *)title artist:(NSString *)artist;

@end
