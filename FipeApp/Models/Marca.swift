//
//  Marca.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

class Marca: Codable {
    let name: String
    let fipeName: String
    let order: Int
    let key: String
    let idMarca: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case fipeName = "fipe_name"
        case order
        case key
        case idMarca = "id"
    }
    
    init(name: String, fipeName: String, order: Int, key: String, idMarca: Int) {
        self.name = name
        self.fipeName = fipeName
        self.order = order
        self.key = key
        self.idMarca = idMarca
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        fipeName = try values.decode(String.self, forKey: .fipeName)
        order = try values.decode(Int.self, forKey: .order)
        key = try values.decode(String.self, forKey: .key)
        idMarca = try values.decode(Int.self, forKey: .idMarca)
    }
}
