//
//  Light.swift
//  ModuloTech
//
//  Created by Ahmed K. on 28/10/2020.
//

import Foundation

struct Light: Device {
    let id: Int
    let productType: String
    var deviceName: String

    private(set) var intensity: Int
    private(set) var mode: String

//    mutating func setMode(_ mode: Bool) {
//        self.mode = mode
//    }

    mutating func setIntensity(intensity value: Int) {
        self.intensity = value
    }
    
}
