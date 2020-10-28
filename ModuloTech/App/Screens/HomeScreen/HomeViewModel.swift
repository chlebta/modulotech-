//
//  HomeViewModel.swift
//  ModuloTech
//
//  Created by Ahmed K. on 28/10/2020.
//

import Foundation

class HomeViewModel {
    private let apiClient: RequestableProtocol
    private let url = "http://storage42.com/modulotest/data.json"
    init(_ apiClient: RequestableProtocol = NetworkConnector()) {
        self.apiClient = apiClient
    }

    func getData() {
        self.apiClient.request(url)  { (response: RequestResult<HomeResponse>) in
            print(response.value)
        }
    }
}
