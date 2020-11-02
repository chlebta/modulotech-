//
//  User.swift
//  ModuloTech
//
//  Created by Ahmed K. on 30/10/2020.
//

import Foundation

//    "birthDate": 813766371000

struct User: Codable {
    let firstName: String
    let lastName: String
    let birthDate: Date
    let address: Address
}

struct Address: Codable {
    let city: String
    let postalCode: Int
    let street: String
    let streetCode: String
    let country: String
}


