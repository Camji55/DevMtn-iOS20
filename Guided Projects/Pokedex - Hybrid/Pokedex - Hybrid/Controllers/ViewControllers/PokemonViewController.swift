//
//  PokemonViewController.swift
//  Pokedex - Hybrid
//
//  Created by Cameron Ingham on 7/24/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!

}

extension PokemonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces).lowercased() else {return}
        searchBar.text = ""
        
        CJIPokemonController.fetchPokemon(forSearchTerm: text) { [weak self] (pokemon) in
            DispatchQueue.main.async {
                guard let pokemon = pokemon else {return}
                self?.nameLabel.text = pokemon.name
                self?.idLabel.text = "\(pokemon.number)"
                self?.movesLabel.text = pokemon.abilities.joined(separator: ", ")
            }
        }
    }
}
