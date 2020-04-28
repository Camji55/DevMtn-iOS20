//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Cameron Ingham on 7/17/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeWeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text?.trimmingCharacters(in: .whitespaces).lowercased(), !search.isEmpty else {return}
        PokemonController.getPokemon(search) { (pokemon) in
            guard let pokemon = pokemon else {return}
            DispatchQueue.main.async {
                self.pokeID.text = String(pokemon.id)
                self.pokeName.text = pokemon.name.capitalized
                self.pokeWeight.text = String(pokemon.weight)
            }
            PokemonController.getImage(for: pokemon, completion: { (image) in
                guard let image = image else {return}
                DispatchQueue.main.async {
                    self.pokeImage.image = image
                }
            })
        }
    }
}
