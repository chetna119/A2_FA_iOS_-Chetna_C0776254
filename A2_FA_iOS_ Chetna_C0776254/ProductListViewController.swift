//
//  ProductListViewController.swift
//  A2_FA_iOS_ Chetna_C0776254
//
//  Created by Macbook on 2021-02-01.
//

import UIKit
import CoreData

class ProductListViewController: UITableViewController {
    
    @IBOutlet weak var productSearchBar: UISearchBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productList: [Product] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        loadData()
        staticDataEntry()
        productSearchBar.delegate = self
        
        //MARK: - to dispaly first product
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        performSegue(withIdentifier: "productDetail", sender: self)
    }
    
    // MARK: - load Data
    func loadData()
    {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            productList = try context.fetch(request)
        } catch {
            print("Error loading products \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    //MARK: - data manipulation core data
    func loadData(with request: NSFetchRequest<Product> = Product.fetchRequest(), predicates: [NSPredicate]){
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            productList = try context.fetch(request)
        } catch {
            print("Error loading prodcuts \(error.localizedDescription)")
        }
        
        tableView.reloadData()
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ProductViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destination.product = productList[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListViewCell", for: indexPath) as! ProductListViewCell
        let product = productList[indexPath.row]
        cell.initCell(product)
        return cell
    }
    
    // MARK: - Static data entry
    func staticDataEntry(){
        deleteProvider()
        productList.forEach { (product) in
            context.delete(product)
        }
        productList.removeAll()
        
        let provider1 = Provider(context: context)
        provider1.name = "Category 1"
        
        let provider2 = Provider(context: context)
        provider2.name = "Category 2"
        
        var product = Product(context: context)
        product.id = 1
        product.name = "Product 1"
        product.desc = "It has daily usage.It has daily usage.It has daily usage.It has daily usage. It has daily usage.It has daily usage.It has daily usage."
        product.price = 20
        product.provider = provider1
        productList.append(product)
        
        product = Product(context: context)
        product.id = 2
        product.name = "Product 2"
        product.desc = "It is used in kitchen.It is used in kitchen.It is used in kitchen.It is used in kitchen.It is used in kitchen.It is used in kitchen.It is used in kitchen."
        product.price = 30
        product.provider = provider1
        productList.append(product)
        
        product = Product(context: context)
        product.id = 3
        product.name = "Product 3"
        product.desc = "It is used while camping. It is used while camping.It is used while camping.It is used while camping.It is used while camping.It is used while camping."
        product.price = 40
        product.provider = provider1
        productList.append(product)
        
        product = Product(context: context)
        product.id = 4
        product.name = "Forth Product"
        product.desc = "It is used in household.It is used in household.It is used in household.It is used in household.It is used in household.It is used in household."
        product.price = 25
        product.provider = provider2
        productList.append(product)

        
        do{
            try context.save()
            tableView.reloadData()
        } catch {
            print("Error saving products \(error.localizedDescription)")
        }
    }

    // delete old providers
    func deleteProvider(){
        print("number of provider :")
        let request: NSFetchRequest<Provider> = Provider.fetchRequest()
        
        do {
            let providerList = try context.fetch(request)
            providerList.forEach { (provider) in
                context.delete(provider)
            }
        } catch {
            print("Error loading providers \(error.localizedDescription)")
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    
    //MARK: - searchbar on click event
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let titlePredicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        let descriptionPredicate = NSPredicate(format: "desc CONTAINS[cd] %@", searchBar.text!)
        loadData(predicates: [titlePredicate, descriptionPredicate])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          
        }
    }
}
