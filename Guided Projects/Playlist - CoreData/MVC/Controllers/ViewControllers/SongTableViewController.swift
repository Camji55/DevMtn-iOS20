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
    
    var playlist: Playlist?
    
    override func viewDidLoad() {
        title = playlist!.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist!.songs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
        guard let songs = playlist!.songs?.allObjects as? [Song] else { return UITableViewCell() }
        cell.textLabel?.text = songs[indexPath.row].name
        cell.detailTextLabel?.text = songs[indexPath.row].artist
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            guard let songs = playlist!.songs?.allObjects as? [Song] else { return }
            SongController.deleteSong(songs[indexPath.row])
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
        
        SongController.createSong(name: song, artist: artist, playlist: playlist!)
        tableView.reloadData()
    }
}
