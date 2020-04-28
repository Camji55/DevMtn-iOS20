//
//  RepresentativeDetailViewController.swift
//  Representatives
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import UIKit
import MapKit

class RepresentativeDetailTableViewController: UITableViewController {

    var representative: Representative?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = representative?.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
        guard let representative = representative else {return UITableViewCell()}
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Party"
            cell.detailTextLabel?.text = representative.party
        case 1:
            cell.textLabel?.text = "State"
            cell.detailTextLabel?.text = representative.state
        case 2:
            cell.textLabel?.text = "District"
            cell.detailTextLabel?.text = representative.district
        case 3:
            cell.textLabel?.text = "Phone Number"
            cell.detailTextLabel?.text = representative.phone
            cell.accessoryType = .disclosureIndicator
        case 4:
            cell.textLabel?.text = "Office Address"
            cell.detailTextLabel?.text = representative.office
            cell.accessoryType = .disclosureIndicator
        case 5:
            cell.textLabel?.text = "Website"
            cell.detailTextLabel?.text = representative.link
            cell.accessoryType = .disclosureIndicator
        default:
            cell.textLabel?.text = "Unknown Error"
            cell.detailTextLabel?.text = "Try Again"
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let representative = representative else {return}
        
        switch indexPath.row {
        case 3:
            if let phoneCallURL = URL(string: "tel://\(representative.phone)") {
                let application:UIApplication = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                }
            }
        case 4:
            let address = representative.office.replacingOccurrences(of: " ", with: ",")
            guard let url = URL(string: "http://maps.apple.com/?address=\(address)") else {return}
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        case 5:
            guard let url = URL(string: representative.link) else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        default:
            return
        }
    }
    
}
