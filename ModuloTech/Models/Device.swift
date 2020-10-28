//
//  Device.swift
//  ModuloTech
//
//  Created by Ahmed K. on 28/10/2020.
//

import Foundation

protocol Device: Codable {
    var id: Int { get }
    var productType: String { get }
    var deviceName: String { get set }
}
