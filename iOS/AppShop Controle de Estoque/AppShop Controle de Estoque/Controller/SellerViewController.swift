//
//  FirstViewController.swift
//  AppShop Controle de Estoque
//
//  Created by Igor Meira on 19/04/19.
//  Copyright © 2019 Igor Meira. All rights reserved.
//

import UIKit
import PDFKit

class SellerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, EditAnItemDelegate, AddAnItemDelegate {

    //MARK: - Outlets
    @IBOutlet weak var tableItem: UITableView!
    @IBOutlet weak var searchField: UISearchBar!
    
    //MARK: - Attributes
    let FILENAME = "sellerlist"
    var items = Array<Item>()
    var currentItems = Array<Item>()
    var doneList = Array<Item>()
    var selectedItem : Item?
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
        firstLaunch()
        
        tableItem.dataSource = self
        tableItem.delegate = self
        
        searchField.delegate = self
        searchField.inputAccessoryView = setToolBar(self)
        
        items = ItemDAO(FILENAME).load()
        currentItems = items.sorted(by: {$0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending})
        doneList = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        items = ItemDAO(FILENAME).load()
        if searchField.text == "" {
            currentItems = items.sorted(by: {$0.name.localizedCaseInsensitiveCompare($1.name) == ComparisonResult.orderedAscending})
        }
        tableItem.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editSellerItemSegue") {
            let view = segue.destination as! ItemViewController
            guard let sItem = self.selectedItem else {return}
            view.selectedItem = sItem
            view.editDelegate = self
            view.items = self.items
        }
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
        
        if Util().isDone(item, doneList) {
            cell.backgroundColor = UIColor(named: "selected")
        } else {
            cell.backgroundColor = .white
        }
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    @objc func longPress(_ longPress : UILongPressGestureRecognizer) {
        if longPress.state == .began {
            let touchPoint = longPress.location(in: self.tableItem)
            if let indexPath = tableItem.indexPathForRow(at: touchPoint) {
                let item = currentItems[indexPath.row]
                if Util().isDone(item, doneList) {
                    doneList = Util().removeDoneItem(item, doneList)
                } else {
                    doneList.append(item)
                }
                tableItem.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 100 : 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        selectedItem = currentItems[row]
        self.performSegue(withIdentifier: "editSellerItemSegue", sender: tableView.cellForRow(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let removeButton = UITableViewRowAction(style: .default, title: "Remover") { (rowAction, indexpath) in
            DispatchQueue.main.async {
                let item = self.currentItems[indexPath.row]
                RemoveItemController(controller: self).show(item, handler : { action in
                    self.currentItems.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.removeItem(indexPath.row, item)
                })
                
            }
        }
        
        removeButton.backgroundColor = UIColor(named: "remove")
        
        return [removeButton]
    }
    
    //MARK: - Methods
    
    func firstLaunch() {
        if UIViewController.isFirstLaunch() {
            FirstLaunch().populateSellerList()
            FirstLaunch().populateTechList()
            tableItem.reloadData()
        }
    }
    
    func updateTableView() {
        ItemDAO(FILENAME).save(items)
        tableItem.reloadData()
    }
    
    func removeItem(_ row: Int, _ item: Item) {
        for index in 0...(items.count - 1) {
            if (items[index].name == item.name) && (items[index].amount == item.amount) && (items[index].details == item.details) {
                items.remove(at: index)
                break
            }
        }
        updateTableView()
    }
    
    //MARK: - Delegates
    
    func add(_ item: Item) {
        items.append(item)
        currentItems.append(item)
        updateTableView()
    }
    
    func edit(_ item: Item, _ originalIndex: Int) {
        let itm = items[originalIndex]
        itm.name = item.name
        itm.amount = item.amount
        itm.details = item.details
        updateTableView()
    }
    
    //MARK: - Actions

    @IBAction func menu(_ sender: Any) {
        guard let navigation = navigationController else { return }
        let menu = Menu().configMenu(navigation: navigation, doneList: doneList, view: self, filename: FILENAME, delegate: self)
        present(menu, animated: true, completion: nil)
        
    }
}

