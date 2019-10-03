//
//  ExtensionsNetwork.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

extension URLSession {

    /// DataTask
    ///
    /// - Parameters:
    ///   - url: expect some url as value
    ///   - result: expect a
    /// - Returns: return a response containing response and data

    func dataTask(
        with url: URLRequest,
        result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {

        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

extension URLRequest {

    /// Expect to receive a Service as param
    ///
    init(service: Service) {
        if let urlComponents = URLComponents(service: service),
            let url = urlComponents.url {
            self.init(url: url)

            self.httpMethod = service.method.rawValue

            service.headers?.forEach { key, value in
                addValue(value, forHTTPHeaderField: key)
            }

            guard case let .requestWithBody(payload) = service.task,
                service.parametersEncoding == .json else {
                    return
            }

            if let payloadEncoded = payload.asData() {
                self.httpBody = payloadEncoded
            }
        } else {
            self.init(url: URL(fileURLWithPath: ""))
        }
    }
}

extension URLComponents {

    /// Initializer
    ///
    /// - Parameter service: receive a service

    init?(service: Service) {
        let url = service.baseURL.appendingPathComponent(service.path)
        self.init(url: url, resolvingAgainstBaseURL: false)

        guard case let .requestParameters(parameters) = service.task,
            service.parametersEncoding == .url else {
                return
        }

        self.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}

extension Encodable {

    /// Convert some data in String dictionary
    ///
    /// - Returns: serializable dictionary
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(
                with: data, options: .allowFragments) as? [String: Any] else {
            return nil
        }
        return dictionary
    }

    /// Encode to data
    ///
    /// - Returns: data type
    func asData() -> Data? {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(self)
        return data
    }
}
