//
//  NetworkConnector.swift
//  ModuloTech
//
//  Created by Ahmed K. on 11/10/2020.
//

import Foundation

final class NetworkConnector: RequestableProtocol {

    private let networkClient: NetworkClientProtocol
    private var networkTasks: [String: URLSessionDataTask]

    init(_ networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient
        self.networkTasks = [:]
    }

    func request(_ url: URL, key: String?, method: HTTPMethod, headers: [String: String]?, params: [String: Any]?) {

        let request = RequestInfo(url: url)
        let task = networkClient.perform(request, nil)
        self.networkTasks.updateValue(task, forKey: request.key)
    }

    func request<T: Decodable>(_ url: URL, key: String?, method: HTTPMethod, headers: [String: String]?, params: [String: Any]?, completionBlock: RequestReponse<T>?) {

        let request = RequestInfo(url: url)

        let task = networkClient.perform(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleReceivedReponse(response, completionBlock: completionBlock)
            case .failure(let error):
                completionBlock?(.failure(error))
            }
        }
        self.networkTasks.updateValue(task, forKey: request.key)
    }

    func cancelRequest(_ key: String) {
        self.networkTasks[key]?.cancel()
    }
}

// MARK: - Response handler
extension NetworkConnector {

    private func handleReceivedReponse<T: Decodable>(_ response: NetworkResponse, completionBlock: RequestReponse<T>?) {
        switch response.statusCode {
        case 200..<300:
            self.handle200Response(response.data, completionBlock: completionBlock)
        case 403: // Login wrong password / username
            self.handle200Response(response.data, completionBlock: completionBlock)
        case 404:
            print(NetworkError.notFound.description)
            completionBlock?(.failure(.notFound))
        default:
            print("Request failed")
            completionBlock?(.failure(.unknown))
        }
    }

    private func handle200Response<T: Decodable>(_ data: Data?, completionBlock: RequestReponse<T>?) {
        guard let data = data else {
            print(NetworkError.emptyServerResponse.description)
            completionBlock?(.failure(.emptyServerResponse))
            return
        }

        do {
            let decodeResult = try JSONDecoder().decode(T.self, from: data)
            completionBlock?(.success(decodeResult))
        } catch let error {
            print("\(NetworkError.decoding.description) : \(error)")
            completionBlock?(.failure(.decoding))
        }
    }
}
