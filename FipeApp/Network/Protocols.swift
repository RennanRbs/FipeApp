//
//  Protocols.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

protocol Service {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}

protocol Provider {
    func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void)
}

