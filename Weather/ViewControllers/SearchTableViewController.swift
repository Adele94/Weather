//
//  SearchTableViewController.swift
//  Weather
//
//  Created by  Adele Shavalieva on 20/11/2019.
//  Copyright © 2019  Adele Shavalieva. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    /// The search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    /// The currency data parsed from city_list.json file
    let currencyData = NSData(contentsOfFile: Bundle.main.path(forResource: "city_list", ofType: "json")!)
    
    /// The city_list as a JSON object
    var city_list: JSON?
    
    /// The city_list filtered based on what is typed in the search bar
    var filteredCity_list = [JSON] ()
    
    /// The origin view controller
    weak var vc = ForecastTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Do the actual JSON parsing
        do {
            city_list = try JSON(data: currencyData! as Data)
        } catch {
            // Do nothing for now
        }
        
        
        /// Search bar interraction - make is visible from the get-go
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    @IBAction func backBarButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCity_list.count
        }
       // return city_list!.count
        return 0

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        
        var data: JSON
        
        if searchController.isActive && searchController.searchBar.text != "" {
            data = filteredCity_list[indexPath.row]
        } else {
            data = city_list![indexPath.row]
        }
        
        let currencyName = data["name"].stringValue
        let currencyCountry = data["country"].stringValue
        
        cell.textLabel?.text = currencyName
        cell.detailTextLabel?.text = currencyCountry
        
        return cell
    }
    
    
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        vc!.AddRow(city: (cell?.textLabel!.text)!, country: (cell?.detailTextLabel!.text)!)
        
        var data:JSON
        if searchController.isActive && searchController.searchBar.text != "" {
            data = filteredCity_list[indexPath.row]
        } else {
            data = city_list![indexPath.row]
        }
        
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)

    }
    
    func filterContentForSearchText(searchText: String){
        //let sortedCityArray = city_list!.array!.sorted() { $0["name"] < $1["name"] }
        filteredCity_list =  city_list!.array!.filter { currency in
            return currency["name"].stringValue.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
