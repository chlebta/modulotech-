//
//  String+Extensions.swift
//  ModuloTech
//
//  Created by Ahmed K. on 30/10/2020.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
