//
//  BreweryDefaultRealm.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 21/02/22.
//
import RealmSwift

class BreweryDefaultRealm: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var average: Double = 0.0
    @objc dynamic var brewery_type: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
