//
//  BreweryBeesRealmConverter.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 21/02/22.
//
import RealmSwift

protocol BreweryBeesRealmConverterProtocol {
    func save(realm: Realm, breweryDefaultModel: BreweryDefaultModel, completion: @escaping (Bool) -> ())
    
    func list(realm: Realm) -> [BreweryDefaultModel]
    
    func delete(realm: Realm, id: String, completion: @escaping (Bool) -> ())
}

class BreweryBeesRealmConverter: BreweryBeesRealmConverterProtocol {
    private let breweryBeesRealmProtocol: BreweryBeesRealmProtocol
    
    init(breweryBeesRealmProtocol: BreweryBeesRealmProtocol) {
        self.breweryBeesRealmProtocol = breweryBeesRealmProtocol
    }
    
    public func save(realm: Realm, breweryDefaultModel: BreweryDefaultModel, completion: @escaping (Bool) -> ()) {
        let breweryDefaultRealm = BreweryDefaultRealm()
        
        breweryDefaultRealm.id = breweryDefaultModel.id!
        breweryDefaultRealm.name = breweryDefaultModel.name ?? ""
        breweryDefaultRealm.average = breweryDefaultModel.average ?? 0.0
        breweryDefaultRealm.brewery_type = breweryDefaultModel.brewery_type ?? ""
        breweryDefaultRealm.latitude = breweryDefaultModel.latitude ?? 0.0
        breweryDefaultRealm.longitude = breweryDefaultModel.longitude ?? 0.0
        breweryDefaultRealm.isFavorite = true
        
        breweryBeesRealmProtocol.save(realm: realm, brewery: breweryDefaultRealm, completion: completion)
    }
    
    public func list(realm: Realm) -> [BreweryDefaultModel] {
        var listBreweryDefaultModel: [BreweryDefaultModel] = []
        
        for result in breweryBeesRealmProtocol.list(realm: realm) {
            var breweryDefaultModel = BreweryDefaultModel()
            
            breweryDefaultModel.id = result.id
            breweryDefaultModel.name = result.name
            breweryDefaultModel.average = result.average
            breweryDefaultModel.brewery_type = result.brewery_type
            breweryDefaultModel.latitude = result.latitude
            breweryDefaultModel.longitude = result.longitude
            breweryDefaultModel.isFavorite = true
            listBreweryDefaultModel.append(breweryDefaultModel)
        }
        
        return listBreweryDefaultModel
    }
    
    public func delete(realm: Realm, id: String, completion: @escaping (Bool) -> ()) {
        breweryBeesRealmProtocol.delete(realm: realm, id: id, completion: completion)
    }
}
