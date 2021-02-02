//
//  ProductViewController.swift
//  A2_FA_iOS_ Chetna_C0776254
//
//  Created by Macbook on 2021-02-01.
//

import UIKit

class ProductViewController: UIViewController {
    
    weak var product: Product!

    @IBOutlet weak var txtId: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtProvider: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtId.text = String(format:"%d",product.id)
        txtName.text = product.name
        txtDescription.text = product.desc
        txtPrice.text = String(format:"$ %.2f",product.price)
        txtProvider.text = product.provider?.name ?? ""
    }
}
