//
//  Item.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

class Item : NSObject, NSCoding {
    
    //MARK: - Variables
    
    var name : String
    var amount : Int
    var details : String
    
    //MARK: - Init
    
    init(name : String, amount : Int, details : String) {
        self.name = name
        self.amount = amount
        self.details = details
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey : "name") as! String
        self.amount = aDecoder.decodeInteger(forKey: "amount")
        self.details = aDecoder.decodeObject(forKey : "details") as! String
    }
    
    //MARK: - Functions
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(amount, forKey : "amount")
        aCoder.encode(details, forKey : "details")
    }
}
