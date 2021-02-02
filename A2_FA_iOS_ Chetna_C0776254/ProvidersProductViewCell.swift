//
//  ProvidersProductViewCell.swift
//  A2_FA_iOS_ Chetna_C0776254
//
//  Created by Macbook on 2021-02-01.
//

import UIKit

class ProvidersProductViewCell: UITableViewCell {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    
    func initCell(_ product: Product){
        txtName.text = product.name
        txtPrice.text = String(format: "$ %.2f", product.price)
    }
}
