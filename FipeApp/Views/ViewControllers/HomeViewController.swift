//
//  HomeViewController.swift
//  FipeApp
//
//  Created by Mateus Sales on 27/09/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var carsNames = [String]()
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "fipecell")
        tableView.separatorStyle = .singleLine
        return tableView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        requestFipe()
        setupTableView()
        
    }
    
    func requestFipe (){
        let service = AppService.getMarcas
        NetworkManager.getAll(service: service) { (marcas: [Marca]?, error) in
            if error == nil {
                guard let newMarcas = marcas else { return }
                DispatchQueue.main.async {
                    newMarcas.forEach { (marca) in
                        self.carsNames.append(marca.fipeName)
                    }
                }
                
            }
        }
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])    }
    


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "fipecell") else { return UITableViewCell()}
            cell.textLabel?.text = "test"
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

    
    
}
