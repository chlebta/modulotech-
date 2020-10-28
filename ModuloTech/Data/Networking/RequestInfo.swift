//
//  RequestInfo.swift
//  francefoot
//
//  Created by Ahmed K. on 24/01/2020.
//  Copyright © 2020 lequipe. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

struct RequestInfo {
    let url: URL
    let method: HTTPMethod
    let headerParams: [String: String]?
    let body: Data?
    let key: String

    init(url: URL) {
        self.url = url
        self.key = url.absoluteString
        self.method = .get
        self.headerParams = nil
        self.body = nil
    }
}
