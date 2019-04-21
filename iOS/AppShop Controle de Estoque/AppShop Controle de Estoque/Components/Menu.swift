//
//  Menu.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 20/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

class Menu: NSObject {
    
    func configMenu(navigation: UINavigationController, doneList : [Item], view : UIViewController, filename : String, delegate: AddAnItemDelegate) -> UIAlertController {
        let menu = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        
        let refresh = UIAlertAction(title: "Restaurar Lista", style: .default) { (acao) in
            let items = ItemDAO(filename).load()
            for itm in items {
                itm.amount = 0
                itm.details = "-"
            }
            ItemDAO(filename).save(items)
            view.viewWillAppear(true)
        }
        menu.addAction(refresh)
        
        let new = UIAlertAction(title: "Adicionar Item", style: .default) { (acao) in
            let newItem = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "itemController") as! ItemViewController
            newItem.addDelegate = delegate
            navigation.pushViewController(newItem, animated: true)
        }
        menu.addAction(new)
        
        let share = UIAlertAction(title: "Compartilhar Lista", style: .default) { (acao) in
            let titleBox = (filename == "sellerlist") ? "Vendedor" : "Técnico"
            let ac = UIAlertController(title: titleBox, message: nil, preferredStyle: .alert)
            ac.addTextField { textField in
                textField.placeholder = "Nome"
                textField.textAlignment = .center
            }
            
            let submitAction = UIAlertAction(title: "Compartilhar", style: .default) { [unowned ac] _ in
                guard let nameField = ac.textFields?[0] else {return}
                let name = nameField.text
                let items = Util().createList(doneList)
                let finalList = "\(titleBox): \(name ?? "")\n\n\(items)"
                
                let activityController = UIActivityViewController(activityItems: [finalList], applicationActivities: nil)
                activityController.completionWithItemsHandler = { (nil, completed, _, error) in
                    if completed {
                        print("completed")
                    }else{
                        print("canceled")
                    }
                }
                view.present(activityController, animated: true)
            }
            
            ac.addAction(submitAction)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            view.present(ac, animated: true)
        }
        menu.addAction(share)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}
