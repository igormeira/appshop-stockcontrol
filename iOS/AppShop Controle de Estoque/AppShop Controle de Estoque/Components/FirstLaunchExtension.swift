//
//  FirstLaunchExtension.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

class FirstLaunch {
    
    init() {}
    
    func populateSellerList() {
        let fileURL = Bundle.main.path(forResource: "sellerList", ofType: "txt")
        var readString = ""
        
        do {
            readString = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Can't read de initial list file!")
            print(error)
        }
        addToSellerList(readString)
    }
    
    func addToSellerList(_ text : String) {
        let lines = text.split(separator: "\n")
        var itemName = ""
        var items = ItemDAO("sellerlist").load()
        for line in lines {
            if (line != "-") && (line != "") {
                itemName = String(line)
                let item = Item(name: itemName, amount: 0, details: "-")
                items.append(item)
            }
        }
        ItemDAO("sellerlist").save(items)
    }
    
    func populateTechList() {
        let fileURL = Bundle.main.path(forResource: "techList", ofType: "txt")
        var readString = ""
        
        do {
            readString = try String(contentsOfFile: fileURL!, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Can't read de initial list file!")
            print(error)
        }
        addToTechList(readString)
    }
    
    func addToTechList(_ text : String) {
        let lines = text.split(separator: "\n")
        var itemName = ""
        var items = ItemDAO("techlist").load()
        for line in lines {
            if (line != "-") && (line != "") {
                itemName = String(line)
                let item = Item(name: itemName, amount: 0, details: "-")
                items.append(item)
            }
        }
        ItemDAO("techlist").save(items)
    }
}

extension UIViewController {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
