//
//  HomeViewController.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
//    let marcas = [Marca]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        let service = AppService.getMarcas
        NetworkManager.getAll(service: service) { (marcas: [Marca]?, error) in
            if error == nil {
                guard let newMarcas = marcas else { return }
                newMarcas.forEach { (marca) in
                    print(marca.fipeName)
                }
            }
        }
    }
    


}
