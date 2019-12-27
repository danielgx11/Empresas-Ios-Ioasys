//
//  ListarEmpresasTableViewController.swift
//  Empresas Ios
//
//  Created by Daniel G on 14/12/19.
//  Copyright © 2019 danielgomes. All rights reserved.
//

import UIKit
import Kingfisher

class ListarEmpresasTableViewController: UIViewController, Storyboarded {
    
    //MARK: -Outlets
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: -Variables
    
    weak var coordinator: MainCoordinator?
    var empresas = [Empresas]()
    
    //MARK: -Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        empresasRequest()
        navigationItem.hidesBackButton = true
    }
    
    private func empresasRequest() {
        EmpresasAPI.getCompanies { (response, error, cache) in
            if response != nil {
                self.empresas = response ?? []
                debugPrint("Success!")
                self.tableView.reloadData()
                //Reload Data
            } else if let error = error {
                let viewController = ViewController()
                if let urlResponse = error.urlResponse, urlResponse.statusCode == 401 {
                    viewController.allertController(titulo: "Error 401", message: urlResponse as! String)
                } else if let responseObject = error.responseObject as? [String: Any], let errorMessage = responseObject["error_message"] {
                    viewController.allertController(titulo: "Response error", message: errorMessage as! String)
                } else {
                    viewController.allertController(titulo: "Error localized description", message: error as! String)
                }
            }
        }
    }
    
    
    //Create IMAGE
    private func createImage(url: URL){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 150, width: 150, height: 150))
        //How to convert URL in String
        let image = UIImage(named: "")
        imageView.image = image
        self.view.addSubview(imageView)
    }
    
}



// MARK: -Table view data source and delegate

extension ListarEmpresasTableViewController: UITableViewDelegate, UITableViewDataSource {

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return empresas.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! EmpresasCelulaTableViewCell
        let company = empresas[indexPath.row]
        let urlImage = company.photo ?? ""
        let imageURL = "\(APIRequest.Constants.baseURL)\(urlImage)"
        let defaultImage = UIImage(named: "imgEmpresaDefault")
        
        //Caso a URL da imagem da empresa seja nula
        if urlImage == "<null>" {
            reusableCell.imageView?.image = #imageLiteral(resourceName: "imgEmpresaDefault")
        }
        else {
            reusableCell.imageView?.kf.indicatorType = .activity
            reusableCell.imageView?.kf.setImage(with: URL(string: imageURL), placeholder: defaultImage, options: [.transition(.fade(0.5))], progressBlock: nil)
        }
        
        reusableCell.nomeEmpresaLabel.text = company.enterprise_name
        reusableCell.descricaoEmpresaLabel.text = company.enterprise_type_name
        reusableCell.locationEmpresaLabel.text = company.country

        return reusableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.empresasDescricoes(to: empresas[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
