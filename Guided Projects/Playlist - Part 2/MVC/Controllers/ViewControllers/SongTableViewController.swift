//
//  SongTableViewController.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {

    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    
    var playlist = Playlist()
    
    override func viewDidLoad() {
        title = playlist.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        let song = playlist.songs[indexPath.row]
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let song = playlist.songs[indexPath.row]
            SongController.deleteSong(song: song, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    @IBAction func addSong(_ sender: Any) {
        guard let song = songTextField.text, !song.isEmpty, let artist = artistTextField.text, !artist.isEmpty else{
            return
        }
        
        songTextField.text = ""
        artistTextField.text = ""
        
        SongController.createSong(name: song, artist: artist, playlist: playlist)
        tableView.reloadData()
    }
}
