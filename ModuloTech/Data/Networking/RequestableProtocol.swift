//
//  Heater.swift
//  ModuloTech
//
//  Created by Ahmed K. on 11/10/2020.
//

import Foundation

typealias RequestReponse<T: Decodable> = (RequestResult<T>) -> Void

protocol RequestableProtocol {
    func request(_ url: URL, key: String?, method: HTTPMethod, headers: [String: String]?, params: [String: Any]?)

    func request<T: Decodable>(_ url: URL, key: String?, method: HTTPMethod, headers: [String: String]?, params: [String: Any]?, completionBlock: RequestReponse<T>?)

    func cancelRequest(_ key: String)
}

extension RequestableProtocol {

    func request(_ url: URL) {
        self.request(url, key: nil, method: .get, headers: nil, params: nil)
    }

    func request<T: Decodable>(_ url: URL, completionBlock: RequestReponse<T>? = nil) {
        self.request(url, key: nil, method: .get, headers: nil, params: nil, completionBlock: completionBlock)
    }

    func request<T: Decodable>(_ string: String, completionBlock: RequestReponse<T>?) {
        guard let url = URL(string: string) else {
            return
        }

        self.request(url, key: nil, method: .get, headers: nil, params: nil, completionBlock: completionBlock)
    }

    func request<T: Decodable>(_ url: URL, key: String, completionBlock: RequestReponse<T>?) {
        self.request(url, key: key, method: .get, headers: nil, params: nil, completionBlock: completionBlock)
    }

    func request<T: Decodable>(_ string: String, key: String, completionBlock: RequestReponse<T>?) {
        guard let url = URL(string: string) else {
            return
        }

        self.request(url, key: key, method: .get, headers: nil, params: nil, completionBlock: completionBlock)
    }
}

enum RequestResult<T: Decodable> {
    case success(T)
    case failure(NetworkError)

    var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    var error: NetworkError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}
