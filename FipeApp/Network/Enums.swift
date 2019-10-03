//
//  Enums.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias Parameters = [String: Any]

enum HTTPTask {
    case requestPlain
    case requestParameters(Parameters)
    case requestWithBody(Encodable)
}

enum NetworkError: Error {
    case unknown
    case noJSONData
}

enum ParametersEncoding {
    case url
    case json
}


