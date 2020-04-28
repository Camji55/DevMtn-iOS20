//
//  PlaylistTableViewController.swift
//  MVC
//
//  Created by Cameron Ingham on 7/4/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
    
    @IBOutlet weak var playlistTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        guard let songCount = playlist.songs?.allObjects.count else {return UITableViewCell()}
        cell.detailTextLabel?.text = String(songCount)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToSonglistVC"){
            guard let destinationVC = segue.destination as? SongTableViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            destinationVC.playlist = PlaylistController.shared.playlists[indexPath.row]
        }
    }
    
    @IBAction func addPlaylist(_ sender: Any) {
        guard let playlist = playlistTextField.text, !playlist.isEmpty else{
            return
        }
        
        playlistTextField.text = ""
        
        PlaylistController.shared.createPlaylist(name: playlist)
        tableView.reloadData()
    }
    
}
