//
//  PlanetsTableViewController.swift
//  Solar System
//
//  Created by Cameron Ingham on 7/3/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit

class PlanetsTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Tap for details"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath) as? PlanetCellTableViewCell

        cell?.planetTitle.text = planets[indexPath.row].name
        cell?.planetImage.image = planets[indexPath.row].image

        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToDetailVC"){
            guard let destinationVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            destinationVC.planet = planets[indexPath.row]
        }
    }
}
