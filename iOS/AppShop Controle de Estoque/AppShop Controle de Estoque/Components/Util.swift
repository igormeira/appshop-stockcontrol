//
//  PDF.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 20/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit
import WebKit

class Util {
    
    init() {}

    func createList(_ list : [Item]) -> String {
        var response = ""
        for item in list {
            response.append(contentsOf: "- \(item.name) \n Qtd.: \(item.amount) \n Descrição: \(item.details) \n")
        }
        return response
    }
    
    func isDone(_ item : Item, _ list : [Item]) -> Bool {
        var response = false
        for itm in list {
            if (itm.name == item.name) && (itm.amount == item.amount) && (itm.details == item.details) {
                response = true
                break
            }
        }
        return response
    }
    
    func removeDoneItem(_ item : Item, _ list : [Item]) -> [Item] {
        var response = list
        for index in 0...(list.count - 1) {
            if (list[index].name == item.name) && (list[index].amount == item.amount) && (list[index].details == item.details) {
                response.remove(at: index)
                break
            }
        }
        return response
    }
}
