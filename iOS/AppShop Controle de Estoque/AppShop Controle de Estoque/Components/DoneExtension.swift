//
//  DoneExtension.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    func setToolBar(_ viewController: UIViewController) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: viewController, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: viewController, action: #selector
            (doneClicked))
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        
        return toolbar
    }
}
