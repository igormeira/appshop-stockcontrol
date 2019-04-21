//
//  EditAnItemDelegate.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 20/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import Foundation

protocol EditAnItemDelegate {
    func edit(_ item: Item, _ originalIndex: Int)
}
