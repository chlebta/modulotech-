//
//  HomeResponse.swift
//  ModuloTech
//
//  Created by Ahmed K. on 28/10/2020.
//

import Foundation

struct HomeResponse: Codable {
    let devices: [Device]
    let user: User

    private enum CodingKeys: String, CodingKey {
        case devices, user
    }

    func encode(to encoder: Encoder) throws { }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let wrappers = try container.decode([DeviceWrapper].self, forKey: .devices)
        self.user = try container.decode(User.self, forKey: .user)
        self.devices = wrappers.map { $0.device }
    }
}

fileprivate struct DeviceWrapper: Codable {
    let device: Device

    private enum CodingKeys: String, CodingKey {
        case productType
    }

    private enum ProductType: String, Codable {
        case light = "Light"
        case heater = "Heater"
        case rollerShutter = "RollerShutter"
    }

    init(_ device: Device) {
        self.device = device
    }

    public func encode(to encoder: Encoder) throws { }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(ProductType.self, forKey: .productType)

        switch base {
        case .light:
            self.device = try Light(from: decoder)
        case .heater:
            self.device = try Heater(from: decoder)
        case .rollerShutter:
            self.device = try RollerShutter(from: decoder)
        }
    }
}
