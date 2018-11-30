//
//  RepositoriesListViewController.swift
//  Github Demo
//
//  Created by Mo-Ramadan Abdelhafez on 11/30/18.
//  Copyright © 2018 Mo-Ramadan Abdelhafez. All rights reserved.
//

import UIKit

class RepositoriesListViewController: UIViewController {

    
    @IBOutlet weak fileprivate var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

fileprivate extension RepositoriesListViewController {
    var cells: [UITableViewCell.Type] {
        return [RepositoryTableViewCell.self]
    }
    
    fileprivate func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        registerCells()
    }
    
    func registerCells() {
        cells.forEach { item in
            let cellName = String(describing: item)
            let nib = UINib(nibName: cellName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellName)
        }
    }
}

extension RepositoriesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryTableViewCell.self))
            as? RepositoryTableViewCell else {
                return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row #\( indexPath.row ) is selected.")
    }
}


