//
//  PlanetModel.swift
//  Solar System
//
//  Created by Cameron Ingham on 7/3/18.
//  Copyright © 2018 Cameron Ingham. All rights reserved.
//

import Foundation
import UIKit

struct Planet {
    var name: String
    var image: UIImage
    var description: String
    var distanceFromSun: String
    var distanceFromEarth: String
}

let mercury = Planet(name: "Mercury", image: UIImage(named: "Mercury")!, description: "Mercury is the smallest and innermost planet in the Solar System. Its orbital period around the Sun of 87.97 days is the shortest of all the planets in the Solar System. It is named after the Roman deity Mercury, the messenger of the gods.", distanceFromSun: "35.98 million miles", distanceFromEarth: "48 million miles")
let venus = Planet(name: "Venus", image: UIImage(named: "Venus")!, description: "Venus is the second planet from the Sun, orbiting it every 224.7 Earth days.[12] It has the longest rotation period (243 days) of any planet in the Solar System and rotates in the opposite direction to most other planets (meaning the Sun would rise in the west and set in the east). It does not have any natural satellites. It is named after the Roman goddess of love and beauty.", distanceFromSun: "67.24 million miles", distanceFromEarth: "162 million miles")
let earth = Planet(name: "Earth", image: UIImage(named: "Earth")!, description: "Earth is the third planet from the Sun and the only astronomical object known to harbor life. According to radiometric dating and other sources of evidence, Earth formed over 4.5 billion years ago. Earth's gravity interacts with other objects in space, especially the Sun and the Moon, Earth's only natural satellite. Earth revolves around the Sun in 365.26 days, a period known as an Earth year. During this time, Earth rotates about its axis about 366.26 times.", distanceFromSun: "92.96 million miles", distanceFromEarth: "0 miles")
let mars = Planet(name: "Mars", image: UIImage(named: "Mars")!, description: "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System after Mercury. In English, Mars carries a name of the Roman god of war, and is often referred to as the 'Red Planet' because the reddish iron oxide prevalent on its surface gives it a reddish appearance that is distinctive among the astronomical bodies visible to the naked eye.[16] Mars is a terrestrial planet with a thin atmosphere, having surface features reminiscent both of the impact craters of the Moon and the valleys, deserts, and polar ice caps of Earth.", distanceFromSun: "141.6 million miles", distanceFromEarth: "33.93 million milles")
let jupiter = Planet(name: "Jupiter", image: UIImage(named: "Jupiter")!, description: "Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a giant planet with a mass one-thousandth that of the Sun, but two-and-a-half times that of all the other planets in the Solar System combined. Jupiter and Saturn are gas giants; the other two giant planets, Uranus and Neptune are ice giants. Jupiter has been known to astronomers since antiquity. The Romans named it after their god Jupiter. When viewed from Earth, Jupiter can reach an apparent magnitude of −2.94, bright enough for its reflected light to cast shadows, and making it on average the third-brightest object in the night sky after the Moon and Venus.", distanceFromSun: "483.8 million miles", distanceFromEarth: "365.37 million miles")
let saturn = Planet(name: "Saturn", image: UIImage(named: "Saturn")!, description: "Saturn is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter. It is a gas giant with an average radius about nine times that of Earth. It has only one-eighth the average density of Earth, but with its larger volume Saturn is over 95 times more massive. Saturn is named after the Roman god of agriculture; its astronomical symbol (♄) represents the god's sickle.", distanceFromSun: "890.7 million miles", distanceFromEarth: "745.65 million miles")
let uranus = Planet(name: "Uranus", image: UIImage(named: "Uranus")!, description: "Uranus is the seventh planet from the Sun. It has the third-largest planetary radius and fourth-largest planetary mass in the Solar System. Uranus is similar in composition to Neptune, and both have different bulk chemical composition from that of the larger gas giants Jupiter and Saturn. For this reason, scientists often classify Uranus and Neptune as 'ice giants' to distinguish them from the gas giants. Uranus's atmosphere is similar to Jupiter's and Saturn's in its primary composition of hydrogen and helium, but it contains more 'ices' such as water, ammonia, and methane, along with traces of other hydrocarbons. It is the coldest planetary atmosphere in the Solar System, with a minimum temperature of 49 K (−224 °C; −371 °F), and has a complex, layered cloud structure with water thought to make up the lowest clouds and methane the uppermost layer of clouds. The interior of Uranus is mainly composed of ices and rock.", distanceFromSun: "1.78 billion miles", distanceFromEarth: "1.62 billion miles")
let neptune = Planet(name: "Neptune", image: UIImage(named: "Neptune")!, description: "Neptune is the eighth and farthest known planet from the Sun in the Solar System. In the Solar System, it is the fourth-largest planet by diameter, the third-most-massive planet, and the densest giant planet. Neptune is 17 times the mass of Earth and is slightly more massive than its near-twin Uranus, which is 15 times the mass of Earth and slightly larger than Neptune. Neptune orbits the Sun once every 164.8 years at an average distance of 30.1 AU (4.5 billion km). It is named after the Roman god of the sea and has the astronomical symbol ♆, a stylised version of the god Neptune's trident.", distanceFromSun: "2.79 billion miles", distanceFromEarth: "2.7 billion miles")

let planets: [Planet] = [mercury, venus, earth, mars, jupiter, saturn, uranus, neptune]
