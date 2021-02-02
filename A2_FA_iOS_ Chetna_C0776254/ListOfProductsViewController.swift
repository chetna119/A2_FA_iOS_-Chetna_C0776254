//
//  ProductListViewController.swift
//  A2_FA_iOS_ Chetna_C0776254
//
//  Created by Macbook on 2021-02-01.
//

import UIKit
import CoreData

class ListOfProductsViewController: UITableViewController {
    
    @IBOutlet weak var productSearchBar: UISearchBar!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var productList: [Product] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
        initialdata()
        productSearchBar.delegate = self
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        performSegue(withIdentifier: "productDetail", sender: self)
    }
    
    // MARK: - load Data
    func getData()
    {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            productList = try context.fetch(request)
        } catch {
            print("Products  could not be loaded \(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    //MARK: -  changing the core data
    func getData(with request: NSFetchRequest<Product> = Product.fetchRequest(), predicates: [NSPredicate]){
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            productList = try context.fetch(request)
        }
        catch
        {
            print("Products  could not be loaded \(error.localizedDescription)")
        }
        
        tableView.reloadData()
        
    }
    
    // MARK: - Navigation
 
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListViewCell", for: indexPath) as! ProductViewCell
        let product = productList[indexPath.row]
        cell.initCell(product)
        return cell
    }
    
    // MARK: - Enter initial Data
    func initialdata()
    {
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
}

extension ListOfProductsViewController: UISearchBarDelegate {
    
    //MARK: - searchbar on click event
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let titlePredicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)
        let descriptionPredicate = NSPredicate(format: "desc CONTAINS[cd] %@", searchBar.text!)
        getData(predicates: [titlePredicate, descriptionPredicate])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            getData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          
        }
    }
}
