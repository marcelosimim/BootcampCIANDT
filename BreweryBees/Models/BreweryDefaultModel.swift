//
//  BreweryDefaultModel.swift
//  BreweryBees
//
//  Created by FELIPE AUGUSTO SILVA on 16/02/22.
//

import Foundation

struct BreweryTopTenModel: Decodable{
    var topTen: [BreweryDefaultModel]?
    //var topTen: [String:[BreweryDefaultModel]]?
}

struct BreweryDefaultModel: Decodable, Equatable {
    var id: String?
    var name: String?
    var website_url: String?
    var street: String?
    var photos: [String]?
    var average: Double?
    var size_evaluations: Int?
    var brewery_type: String?
    var city: String?
    var state: String?
    var country: String?
    var latitude: Double?
    var longitude: Double?
    var postal_code: String?
    var phone: String?
    var isFavorite: Bool?
}




