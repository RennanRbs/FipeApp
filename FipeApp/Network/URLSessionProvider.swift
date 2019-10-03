//
//  URLSessionProvider.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

final class URLSessionProvider: Provider {

    private var session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func request<T: Decodable>(
        type: T.Type, service: Service, completion: @escaping (Result<T, Error>) -> Void) {

        let request = URLRequest(service: service)

        let task = self.session.dataTask(with: request) { (result) in
            self.handleResult(result: result, completion: completion)
        }

        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }

    private func handleResult<T: Decodable>(
        result: Result<(URLResponse, Data), Error>, completion: (Result<T, Error>) -> Void) {

        switch result {
        case .failure(let error):
            completion(.failure(error))
        case .success(let response, let data):
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.noJSONData))
            }
//            if let dataString = String(bytes: data, encoding: .utf8) {
//                print("Json by Api: \(dataString)")
//            }
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let model = try decoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(NetworkError.unknown))
                }
            default:
                completion(.failure(NetworkError.unknown))
            }
        }

    }
}
