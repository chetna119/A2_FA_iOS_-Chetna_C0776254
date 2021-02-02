//
//  ProvidersProductListViewController.swift
//  A2_FA_iOS_ Chetna_C0776254
//
//  Created by Macbook on 2021-02-01.
//

import UIKit
import CoreData

class ProvidersProductListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productList: [Product] = []
    var selectedProvider: Provider! {
        didSet{
            loadData()
        }
    }
    
    override func viewDidLoad() {
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    //MARK: - load product data with proider name filtered from CoreData
    func loadData(){
        self.title = selectedProvider.name
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.predicate = NSPredicate(format: "provider.name ==  %@", selectedProvider.name ?? "")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            productList = try context.fetch(request)
        } catch {
            print("PRODUCT COULD NOT BE LOADED\(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
    
    // table view delegate for no of rows going to be in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    // table view delegate for returning table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProvidersProductViewCell", for: indexPath) as! ProvidersProductViewCell
        let product = productList[indexPath.row]
        cell.initCell(product)
        return cell
        
    }
    
}
