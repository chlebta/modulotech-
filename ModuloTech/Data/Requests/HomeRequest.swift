//
//  HomeRequest.swift
//  ModuloTech
//
//  Created by Ahmed K. on 30/10/2020.
//

import Foundation
import RxSwift
import RxCocoa

protocol DeviceRequest {
    var devices: BehaviorRelay<[Device]> { get set }
}

protocol UserRequest {
    var user: BehaviorRelay<User?> { get set }
}

final class HomeRequest: DeviceRequest, UserRequest {

    private let apiClient: RequestableProtocol
    private let url = "http://storage42.com/modulotest/data.json"

    var devices = BehaviorRelay<[Device]>(value: [])
    var user = BehaviorRelay<User?>(value: nil)

    private let disposeBag = DisposeBag()

    init(_ client: RequestableProtocol = NetworkConnector()) {
        self.apiClient = client
        self.getData()
    }

    private func getData() {
        self.apiClient.request(url)  { (response: RequestResult<HomeResponse>) in

            if let devices = response.value?.devices {
                self.devices.accept(devices)
            }

            if let user = response.value?.user {
                self.user.accept(user)
            }
        }
    }
}
