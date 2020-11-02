//
//  DevicesListViewModel.swift
//  ModuloTech
//
//  Created by Ahmed K. on 28/10/2020.
//

import Foundation
import RxSwift
import RxCocoa

class DevicesListViewModel {

    private let apiRequest: DeviceRequest

    lazy var dataSource = {
        self.apiRequest
            .devices
            .asObservable()
    }()

    init(_ apiRequest: DeviceRequest = HomeRequest()) {
        self.apiRequest = apiRequest
    }

    func didSelectItem(_ indexPath: IndexPath) {
        print("NAVIGATE to deviceDetailsViewController")
    }
}
