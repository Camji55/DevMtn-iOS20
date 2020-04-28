//
//  CJISongsTableViewController.m
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJISongsTableViewController.h"
#import "CJIPlaylistController.h"
#import "CJIPlaylist.h"
#import "CJISong.h"

@interface CJISongsTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *songTitleTextField;
@property (weak, nonatomic) IBOutlet UITextField *songArtistsTextField;

- (IBAction)addSong:(id)sender;

@end

@implementation CJISongsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [self.playlist name];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.playlist songs] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    CJISong* mySong = [[self.playlist songs] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [mySong title];
    cell.detailTextLabel.text = [mySong artist];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CJISong* mySong = [[self.playlist songs] objectAtIndex:indexPath.row];
        [[CJIPlaylistController sharedController] deleteSong:mySong from:self.playlist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (IBAction)addSong:(id)sender
{
    if(![self.songTitleTextField.text isEqualToString:@""] && ![self.songArtistsTextField.text isEqualToString:@""])
    {
        [[CJIPlaylistController sharedController] addSongWithTitle:self.songTitleTextField.text andArtist:self.songArtistsTextField.text toPlaylist:self.playlist];
        self.songTitleTextField.text = @"";
        self.songArtistsTextField.text = @"";
        [self.tableView reloadData];
    }
}

@end
