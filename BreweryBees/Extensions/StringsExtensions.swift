//
//  StringsExtensions.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 01/02/22.
//

import Foundation

extension String {
  var localized: String {
        NSLocalizedString(self, comment: "MISSING KEY")
    }
}
