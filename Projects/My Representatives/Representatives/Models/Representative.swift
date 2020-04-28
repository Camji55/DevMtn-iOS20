//
//  Representative.swift
//  Representatives
//
//  Created by Cameron Ingham on 7/19/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation

struct topLevelDictionary: Codable {
    let results: [Representative]
}

struct Representative: Codable {
    let name: String
    let party: String
    let state: String
    let district: String
    let phone: String
    let office: String
    let link: String
}
