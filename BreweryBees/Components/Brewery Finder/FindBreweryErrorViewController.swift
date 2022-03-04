//
//  FindBreweryErrorViewController.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 01/02/22.
//

import UIKit

class FindBreweryErrorViewController: UIView {
    
    static let identifier = "FindBreweryErrorViewController"
    
    private enum Constants {
        static let titleNoBreweryTyped = "findBreweryError.title.noBreweryTyped"
        static let titleNotFoundBrewery = "findBreweryError.title.notFoundBrewery"
        static let descriptionBreweryError = "findBreweryError.description"
    }    

    @IBOutlet weak var titleErrorBrewery: UILabel!
    @IBOutlet weak var descriptionErrorBrewery: UILabel!
    
    
    func notBreweryTyped() {
        titleErrorBrewery.text = Constants.titleNoBreweryTyped.localized
        descriptionErrorBrewery.text = Constants.descriptionBreweryError.localized
    }

    func notBreweryFound() {
        titleErrorBrewery.text = Constants.titleNotFoundBrewery.localized
        descriptionErrorBrewery.text = Constants.descriptionBreweryError.localized
    }
    
    func breweryError(title: String, description: String) {
        titleErrorBrewery.text = title
        descriptionErrorBrewery.text = description
    }
}
