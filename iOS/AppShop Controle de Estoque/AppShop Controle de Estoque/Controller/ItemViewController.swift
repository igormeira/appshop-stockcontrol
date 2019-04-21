//
//  ItemController.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 20/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var labelTitle: UILabel!
    
    
    //MARK: - Variables
    var editDelegate : EditAnItemDelegate?
    var addDelegate : AddAnItemDelegate?
    var selectedItem : Item?
    var items : Array<Item>?    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
        if items != nil {
            labelTitle.text = "EDITAR ITEM"
            fillFields()
        } else {
            labelTitle.text = "ADICIONAR ITEM"
        }
        
        nameField.inputAccessoryView = setToolBar(self)
        amountField.inputAccessoryView = setToolBar(self)
        detailsField.inputAccessoryView = setToolBar(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Functions
    
    func getIndex(_ item : Item) -> Int {
        var index = 0
        for itm in items! {
            if (itm.name == item.name) && (itm.amount == item.amount) && (itm.details == item.details) {
                return index
            } else {
                index = index + 1
            }
        }
        return index
    }
    
    func fillFields() {
        let index = getIndex(selectedItem!)
        let item = items![index]
        nameField.text = "\(item.name)"
        amountField.text = "\(item.amount)"
        detailsField.text = "\(item.details)"
    }
    
    func getItemFromForm() -> Item? {
        if let name = nameField?.text {
            if let amount = amountField?.text {
                if let details = detailsField?.text {
                    if (nameField.text == "") || (amountField.text == "") {
                        Alert(controller: self).show(message: "Preencha todos os campos!")
                    } else {
                        let finalDetails = (detailsField.text == "") ? "-" : details
                        let item = Item(name: name, amount: Int(amount)!, details: finalDetails)
                        return item
                    }
                }
            }
        }
        return nil
    }
    
    func addItem(_ item : Item, _ delegate : AddAnItemDelegate) {
        delegate.add(item)
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        } else {
            Alert(controller: self).show(message: "Erro ao voltar, mas o item foi adicionado.")
        }
    }
    
    func editItem(_ item : Item, _ delegate : EditAnItemDelegate) {
        delegate.edit(item, getIndex(selectedItem!))
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        } else {
            Alert(controller: self).show(message: "Erro ao voltar, mas o item foi atualizado.")
        }
    }
    
    @IBAction func save(_ sender: Any) {
        if let item = getItemFromForm() {
            if (nameField.text == "") || (amountField.text == "") {
                Alert(controller: self).show(message: "Preencha todos os campos!")
            } else {
                if let delegate = addDelegate {addItem(item, delegate)}
                if let delegate = editDelegate {editItem(item, delegate)}
            }
        }
        Alert(controller: self).show(message: "Algo deu errado.")
    }
    @IBAction func back(_ sender: Any) {
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }
}
