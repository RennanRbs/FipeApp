//
//  NetworkManager.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

class NetworkManager {
    
    // MARK: - Get all objects with generics for any class
    static func getAll<T: Codable>(service: AppService, completion: @escaping (T?, Error?) -> Void) {
        let session = URLSessionProvider()
        session.request(type: T.self, service: service) { (result) in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Get one object with generics for any class
    static func get<T: Codable>(service: AppService, completion: @escaping (T?, Error?) -> Void) {
        let session = URLSessionProvider()
        session.request(type: T.self, service: service) { (result) in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
