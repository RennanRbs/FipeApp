//
//  ViewCodable.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

protocol ViewCodable: class {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCodable {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
