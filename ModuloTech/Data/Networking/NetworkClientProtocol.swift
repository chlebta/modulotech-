//
//  Heater.swift
//  ModuloTech
//
//  Created by Ahmed K. on 11/10/2020.
//

import Foundation

protocol NetworkClientProtocol {
    func perform(_ request: RequestInfo, _ completion: NetworkClientCompletionResult?) -> URLSessionDataTask
}

typealias NetworkClientCompletionResult = (Result<NetworkResponse, NetworkError>) -> Void

enum NetworkError: Error {
    case invalidRequest
    case emptyServerResponse
    case requestFailed
    case encoding
    case decoding
    case notFound
    case unknown

    var description: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidRequest:
            return "Invalid URL request"
        case .emptyServerResponse:
            return "Empty server response data"
        case .requestFailed:
            return "Request failed"
        case .encoding:
            return "Encoding error"
        case .decoding:
            return "Decoding error"
        case .notFound:
            return "Not found"
        }
    }
}

struct NetworkResponse {
    let statusCode: Int
    let data: Data?
}
