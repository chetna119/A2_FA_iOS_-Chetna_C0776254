//
//  ProductListViewCell.swift
//  A2_FA_iOS_ Chetna_C0776254 
//
//  Created by Macbook on 2021-02-01.
//

import UIKit

class ProductListViewCell: UITableViewCell{
    
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productProvider: UITextField!
    
    func initCell(_ product: Product){
        productName.text = product.name
        productPrice.text = String(format: "$ %.2f", product.price)
        productProvider.text = product.provider?.name ?? ""
    }
}
