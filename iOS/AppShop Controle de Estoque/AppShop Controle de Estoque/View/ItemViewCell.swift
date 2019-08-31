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
    @IBOutlet weak var imgSellerSelected: UIImageView!
    
    @IBOutlet weak var labelTechName: UILabel!
    @IBOutlet weak var labelTechAmount: UILabel!
    @IBOutlet weak var labelTechDetails: UILabel!
    @IBOutlet weak var imgTechSelected: UIImageView!
    
    //MARK: - Functions
    func configSellerListCell(name : String, amount : Int, details: String, selected: Bool) {
        labelSellerName.text = "Item: \(name)"
        labelSellerAmount.text = "Qtd.: \(amount)"
        labelSellerDetails.text = "Descrição: \(details)"
        imgSellerSelected.isHighlighted = selected
    }
    
    func configTechListCell(name : String, amount : Int, details: String, selected: Bool) {
        labelTechName.text = "Item: \(name)"
        labelTechAmount.text = "Qtd.: \(amount)"
        labelTechDetails.text = "Descrição: \(details)"
        imgTechSelected.isHighlighted = selected
    }

}
