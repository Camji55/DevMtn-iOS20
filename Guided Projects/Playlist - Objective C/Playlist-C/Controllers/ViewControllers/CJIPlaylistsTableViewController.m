//
//  CJIPlaylistsTableViewController.m
//  Playlist-C
//
//  Created by Cameron Ingham on 7/23/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

#import "CJIPlaylistsTableViewController.h"
#import "CJIPlaylistController.h"
#import "CJISongsTableViewController.h"

@interface CJIPlaylistsTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *playlistNameTextField;

- (IBAction)addPlaylist:(id)sender;

@end

@implementation CJIPlaylistsTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CJIPlaylistController sharedController] playlists] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaylistCell" forIndexPath:indexPath];
    CJIPlaylist *playlist = [[[CJIPlaylistController sharedController] playlists] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = playlist.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu songs", playlist.songs.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CJIPlaylist *playlist = [[[CJIPlaylistController sharedController] playlists] objectAtIndex:indexPath.row];
        [[CJIPlaylistController sharedController] deletePlaylist:playlist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)addPlaylist:(id)sender
{
    if(![self.playlistNameTextField.text isEqualToString:@""])
    {
        [[CJIPlaylistController sharedController] createPlaylistWithName: self.playlistNameTextField.text];
        self.playlistNameTextField.text = @"";
        [self.tableView reloadData];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toPlaylistDetail"]){
        NSIndexPath* indexPath = self.tableView.indexPathForSelectedRow;
        CJIPlaylist* playlist = [[[CJIPlaylistController sharedController] playlists] objectAtIndex:indexPath.row];
        CJISongsTableViewController* destinationVC = segue.destinationViewController;
        destinationVC.playlist = playlist;
    }
}

@end
