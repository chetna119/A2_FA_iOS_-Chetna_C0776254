//
//  ProviderListViewCell.swift
//  A2_FA_iOS_ Chetna_C0776254
//
//  Created by Macbook on 2021-02-01.
//

import UIKit

class ProviderListViewCell: UITableViewCell{
    
    @IBOutlet weak var providerName: UITextField!
    @IBOutlet weak var productCount: UITextField!
   
   func initCell(_ provider: Provider){
       providerName.text = provider.name
    //productCount.text = String(format: "%d", provider.products?.count ?? 0)
   }
}

