//
//  CJISongsTableViewController.h
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJIPlaylist;

@interface CJISongsTableViewController : UITableViewController

@property (nonatomic, strong) CJIPlaylist* playlist;

@end
