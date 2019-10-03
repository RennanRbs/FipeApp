//
//  AppService.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

enum AppService: Service {

    // MARK: - Get
    case getMarcas
//    case getMarca(id: Int)

    var baseURL: URL {
        guard let url = URL(string: "http://fipeapi.appspot.com/api/1/carros")
            else {
                return URL(fileURLWithPath: "")
        }
        return url

    }

    var path: String {
        switch self {
        case .getMarcas:
            return "/marcas.json/"
//        case .getMarca(id: <#T##Int#>)
        }

    }

    var method: HTTPMethod {
        switch self {
        case .getMarcas:
            return .get
        }

    }

    var task: HTTPTask {
        switch self {
        case .getMarcas:
            return .requestPlain
        }
    }
    
    var headers: Headers? {
        switch self {
        case .getMarcas:
            return nil
        }
    }
    
    var parametersEncoding: ParametersEncoding {
        switch self {
        case .getMarcas:
            return .url
        }
    }
    
}
