//
//  ItemDAO.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import Foundation

class ItemDAO {
    
    let itemListArchive:String
    
    init(_ list : String) {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        itemListArchive = "\(dir)/\(list).data"
    }
    
    func save(_ items:Array<Item>) {
        NSKeyedArchiver.archiveRootObject(items, toFile: itemListArchive)
    }
    
    func load() -> Array<Item> {
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: itemListArchive) {
            let items = loaded as! Array<Item>
            return items
        }
        print("Couldn't read file")
        return []
    }
    
}
