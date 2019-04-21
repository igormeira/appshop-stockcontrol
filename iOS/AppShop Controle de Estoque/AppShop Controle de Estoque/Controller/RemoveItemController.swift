//
//  RemoveItemController.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 21/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import Foundation
import UIKit

class RemoveItemController {
    
    let controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func show(_ item : Item, handler: @escaping (UIAlertAction) -> Void) {
        
        let details = UIAlertController(title: item.name, message: "Qtd.: \(item.amount)\nDescrição: \(item.details)", preferredStyle: UIAlertController.Style.alert)
        
        let remove = UIAlertAction(title: "Remover", style: UIAlertAction.Style.destructive, handler: handler)
        details.addAction(remove)
        
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil)
        details.addAction(cancel)
        
        controller.present(details, animated: true, completion: nil)
    }
}
