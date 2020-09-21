//
//  DetailCoordinator.swift
//  Companies
//
//  Created by Daniel Gx on 28/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol DetailFlow: class { }

class DetailCoordinator: Coordinator, DetailFlow {
    
    
    // MARK: - Properties
    let navigationController: UINavigationController
    var selectedCompany: Companies
    
    init(navigationController: UINavigationController, selectedCompany: Companies) {
        self.navigationController = navigationController
        self.selectedCompany = selectedCompany
    }
    
    func start() {
        let detailViewController = DetailViewController()
        detailViewController.coordinator = self
        detailViewController.enterprise = selectedCompany
        navigationController.present(detailViewController, animated: true)
    }
}