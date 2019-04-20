//
//  ItemViewCell.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

class ItemViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var labelSellerName: UILabel!
    @IBOutlet weak var labelSellerAmount: UILabel!
    @IBOutlet weak var labelSellerDetails: UILabel!
    
    @IBOutlet weak var labelTechName: UILabel!
    @IBOutlet weak var labelTechAmount: UILabel!
    @IBOutlet weak var labelTechDetails: UILabel!
    
    //MARK: - Functions
    func configSellerListCell(name : String, amount : Int, details: String) {
        labelSellerName.text = "Item: \(name)"
        labelSellerAmount.text = "Qtd.: \(amount)"
        labelSellerDetails.text = "Descrição: \(details)"
    }
    
    func configTechListCell(name : String, amount : Int, details: String) {
        labelTechName.text = "Item: \(name)"
        labelTechAmount.text = "Qtd.: \(amount)"
        labelTechDetails.text = "Descrição: \(details)"
    }

}
