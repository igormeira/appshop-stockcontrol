//
//  FirstViewController.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit

class SellerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    //MARK: - Outlets
    @IBOutlet weak var tableItem: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    //MARK: - Attributes
    var items = Array<Item>()
    var currentItems = Array<Item>()
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
        firstLaunch()
        
        tableItem.dataSource = self
        tableItem.delegate = self
        
        searchField.delegate = self
        searchField.inputAccessoryView = setToolBar(self)
        
        items = ItemDAO("sellerlist").load()
        currentItems = items.sorted(by: {$0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending})
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentItems = items.sorted(by: {$0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending})
        var listAux: Array<Item> = []
        if searchText != "" {
            for itm in currentItems {
                if (itm.name.contains(searchText)) {
                    listAux.append(itm)
                }
            }
            currentItems = listAux.sorted(by: {$0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending})
        }
        tableItem.reloadData()
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableItem.dequeueReusableCell(withIdentifier: "itemViewCell", for: indexPath) as! ItemViewCell
        let row = indexPath.row
        let item = currentItems[row]
        
        cell.configSellerListCell(name: item.name, amount: item.amount, details: item.details)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 100 : 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Methods
    
    func firstLaunch() {
        FirstLaunch().populateSellerList()
        tableItem.reloadData()
    }

}

