//
//  Heater.swift
//  ModuloTech
//
//  Created by Ahmed K. on 11/10/2020.
//

import Foundation

struct NetworkClient: NetworkClientProtocol {

    private let session = URLSession.shared

    func perform(_ request: RequestInfo, _ completion: NetworkClientCompletionResult?) -> URLSessionDataTask {

        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headerParams

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion?(.failure(.requestFailed))
                return
            }
            completion?(.success(NetworkResponse(statusCode: httpResponse.statusCode, data: data)))
        }
        task.resume()
        return task
    }
}
