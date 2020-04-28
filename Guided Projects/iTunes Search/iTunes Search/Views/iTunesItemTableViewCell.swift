//
//  iTunesItemTableViewCell.swift
//  iTunes Search
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class iTunesItemTableViewCell: UITableViewCell {

    var itunesItem: iTunesItem? {
        didSet{
            updateViews()
        }
    }

    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    
    func updateViews(){
        guard let itunesItem = itunesItem else {return}
        self.songName.text = itunesItem.song
        self.artistName.text = itunesItem.artist
        self.albumName.text = itunesItem.album
        iTunesItemController.getAlbumCover(for: itunesItem) { (albumCoverImage) in
            DispatchQueue.main.async {
                guard let albumCoverImage = albumCoverImage else {return}
                self.albumCover.image = albumCoverImage
            }
        }
    }
    
}
