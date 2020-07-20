//
//  Util.swift
//  Companies
//
//  Created by Daniel Gx on 04/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    
    // MARK: - Properties
    
    var backgroundColor: UIColor {
        return UIColor(red: 234/255, green: 233/255, blue: 213/255, alpha: 1)
    }
    
    var barTintColor: UIColor {
        return UIColor(red: 255/255, green: 0/255, blue: 128/255, alpha: 1.0)
    }
    
    var cellBorderColor: CGColor {
        return UIColor.lightGray.cgColor
    }
    
    var titleImageView: UIImage {
        let image = "logoIcon"
        if let path = Bundle.main.path(forResource: image, ofType: nil) {
            if let imageFinished = UIImage(contentsOfFile: path) {
                return imageFinished
            }
        }
        
        return #imageLiteral(resourceName: "logoIcon")
    }
    
    
    // MARK: - Methods
        
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
    func alertController(_ title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
}
